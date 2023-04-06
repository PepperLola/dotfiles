local var transparentBg = false

function SetColors(color)
	color = color or "tokyonight-night"
	vim.cmd.colorscheme(color)

	if transparentBg then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

SetColors()
