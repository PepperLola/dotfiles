def find_platform [platform?: string] {
    match $platform {
        "alea-v1" | "alea-v4" | "launchpad" => $platform,
        _ if (lsusb | rg FT230X | str length) != 0 => "alea-v1",
        _ => "launchpad"
    }
}

def get_root [] {
    return (git rev-parse --show-toplevel)
}

# repo root for normal clones; for worktrees, the dir holding .bare and the worktrees,
# so docker mounts include the git common dir
def get_mount_root [] {
    let common = (git rev-parse --path-format=absolute --git-common-dir)
    if ($common | path basename) == ".git" {
        get_root
    } else {
        $common | path dirname
    }
}

def is_aleasat [root_path: string] {
    let dir = $root_path | path basename
    ($dir == "aleasat-software")
}

def fw_docker_build [...args: string] {
    let git_root = (get_root)
    let mount = (get_mount_root)
    let rel = ($git_root | path relative-to $mount)
    let workdir = if $rel == "" { "/usr/local/src/repo" } else { ["/usr/local/src/repo", $rel] | path join }

    # dual mount: space-free path for the build scripts (unquoted vars), host path so
    # absolute worktree gitdir links resolve; safe.directory=* since docker_git.sh
    # only marks /usr/local/src/repo
    (docker run --rm -i --platform linux/amd64
        -e $"HOST_UID=(^id -u)"
        -e $"HOST_GID=(^id -g)"
        -e GIT_CONFIG_COUNT=1
        -e GIT_CONFIG_KEY_0=safe.directory
        -e "GIT_CONFIG_VALUE_0=*"
        -v $"($mount):/usr/local/src/repo:z"
        -v $"($mount):($mount):z"
        --workdir $workdir
        alea-obc-fw-build:latest
        ./tools/docker/docker_user.sh ./alea-fsw/obc-fw/scripts/fw_build.sh ...$args)
}

export def flash [
    platform?: string,
    --target: string = "ext",
    --flash-slot: string = "A",
    --erase-all
] {
    let git_root = (get_root)
    if not (is_aleasat (get_mount_root)) {
        return "Cannot run this command from outside of the aleasat-software repository."
    }

    let p = (find_platform $platform)
    let target_opts = [
        "startup",
        "boot",
        "core",
        "ext"
    ]
    let flash_slot_opts = [
        "A", "B"
    ]

    if ($target in $target_opts) == false {
        return "Target must be one of [startup, boot, core, ext]."
    }
    if ($flash_slot in $flash_slot_opts) == false {
        return "Flash slot must be one of [A, B]."
    }

    printf $"PLATFORM: ($p)\n"
    printf $"TARGET: ($target)\n"
    printf $"FLASH SLOT: ($flash_slot)\n"

    let fw_path = [$git_root, "alea-fsw", "obc-fw"] | path join
    let config_path = [$fw_path, "tools", "debug", "ccs", $"($p).ccxml"] | path join
    let build_path = [$fw_path, "build", $p, $target, $flash_slot, "ALEA_OBC.elf"] | path join
    # 0 = "Entire Flash", 1 = "Necessary Sectors Only (for Program Load)"
    let erase_selection = if $erase_all { 0 } else { 1 }
    dslite --verbose --flash --run --config=$"($config_path)" --setting FlashEraseSelection=($erase_selection) $"($build_path)"
}

# build slot images (non-standalone, comms over radio) and flash them in one dslite call,
# so board runs full startup->boot->ext chain for OTA update testing
export def flash_ota_stack [platform?: string, --comms-over-serial (-c)] {
    let git_root = (get_root)
    if not (is_aleasat (get_mount_root)) {
        return "Cannot run this command from outside of the aleasat-software repository."
    }

    let p = (find_platform $platform)

    printf $"PLATFORM: ($p)\n"

    let fw_path = [$git_root, "alea-fsw", "obc-fw"] | path join
    let images = [
        ["startup", "A"],
        ["boot", "A"],
        ["boot", "B"],
        ["ext", "A"],
        ["ext", "B"]
    ]

    let extra_args = if $comms_over_serial { ["-c"] } else { [] }
    for image in $images {
        fw_docker_build $p ($image | first) ($image | last) ...$extra_args
    }

    let config_path = [$fw_path, "tools", "debug", "ccs", $"($p).ccxml"] | path join
    let elf_paths = $images | each {|image|
        [$fw_path, "build", $p, ($image | first), ($image | last), "ALEA_OBC.elf"] | path join
    }
    # default FlashEraseSelection=0 is "Entire Flash", which would wipe previously loaded slots;
    # 1 = "Necessary Sectors Only (for Program Load)". dslite.sh wrapper evals args unquoted,
    # so must use numeric index, not string value
    dslite --verbose --flash --run --config=$"($config_path)" --setting FlashEraseSelection=1 ...$elf_paths
}

export def build [
    platform?: string,
    --target: string = "ext",
    --flash-slot: string = "A",
    --comms-over-serial (-c),
    --standalone (-s)
] {
    let git_root = (get_root)
    if not (is_aleasat (get_mount_root)) {
        return "Cannot run this command from outside of the aleasat-software repository."
    }

    let p = (find_platform $platform)
    let target_opts = [
        "startup",
        "boot",
        "core",
        "ext"
    ]
    let flash_slot_opts = [
        "A", "B"
    ]

    if ($target in $target_opts) == false {
        return "Target must be one of [startup, boot, core, ext]."
    }
    if ($flash_slot in $flash_slot_opts) == false {
        return "Flash slot must be one of [A, B]."
    }

    printf $"PLATFORM: ($p)\n"
    printf $"TARGET: ($target)\n"
    printf $"FLASH SLOT: ($flash_slot)\n"
    printf $"COMMS OVER SERIAL: ($comms_over_serial)\n"
    printf $"STANDALONE: ($standalone)\n"

    mut extra_args = []
    if $comms_over_serial { $extra_args = ($extra_args | append "-c") }
    if $standalone { $extra_args = ($extra_args | append "-s") }

    fw_docker_build $"($p)" $"($target)" $"($flash_slot)" ...$extra_args
}
