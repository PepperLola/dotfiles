def find_platform [platform?: string] {
    match $platform {
        "alea-v1" | "launchpad" => $platform,
        _ if (lsusb | rg FT230X | str length) != 0 => "alea-v1",
        _ => "launchpad"
    }
}

def get_root [] {
    return (git rev-parse --show-toplevel)
}

def is_aleasat [root_path: string] {
    let dir = $root_path | path basename
    ($dir == "aleasat-software")
}

export def flash [platform?: string] {
    let git_root = (get_root)
    if not (is_aleasat $git_root) {
        return "Cannot run this command from outside of the aleasat-software repository."
    }

    let p = (find_platform $platform)

    printf $"PLATFORM: ($p)\n"

    let fw_path = [$git_root, "alea-fsw", "obc-fw"] | path join
    let config_path = [$fw_path, "tools", "debug", "ccs", $"($p).ccxml"] | path join
    let build_path = [$fw_path, "build", $p, "ext", "A", "ALEA_OBC.elf"] | path join
    dslite --verbose --flash --run --config=$"($config_path)" $"($build_path)"
}

export def build [
    platform?: string,
    --target: string = "ext",
    --flash-slot: string = "A",
    --comms-over-serial (-c),
    --standalone (-s)
] {
    let git_root = (get_root)
    if not (is_aleasat $git_root) {
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

    let fw_path = [$git_root, "alea-fsw", "obc-fw"] | path join
    let script_path = [$fw_path, "scripts", "fw_build_docker.sh"] | path join

    bash ($script_path) $"($p)" $"($target)" $"($flash_slot)" $"(if $comms_over_serial { "-c" } else { })" $"(if $standalone { "-s" } else { })"
}
