vim.api.nvim_create_user_command('TypstPreview', function()
    vim.fn.jobstart("tinymist preview " .. vim.fn.expand('%:p'))
end, {})
