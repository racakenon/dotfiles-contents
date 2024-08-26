local fn = vim.fn
vim.api.nvim_create_autocmd("BufRead", {
    callback = function(opts)
        vim.api.nvim_create_autocmd("BufWinEnter", {
            buffer = opts.buf,
            callback = function()
                local ignore_buftype = { "quickfix", "nofile", "help" }
                local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
                local open_folds = 1
                if vim.tbl_contains(ignore_buftype, vim.api.nvim_get_option_value("buftype", {})) or
                    vim.tbl_contains(ignore_filetype, vim.api.nvim_get_option_value("filetype", {})) or
                    fn.line(".") > 1
                then
                    return
                end
                local last_line = fn.line([['"]])
                local buff_last_line = fn.line("$")
                local window_last_line = fn.line("w$")
                local window_first_line = fn.line("w0")
                if last_line > 0 and last_line <= buff_last_line then
                    if window_last_line == buff_last_line then
                        vim.api.nvim_command([[keepjumps normal! g`"]])
                    elseif buff_last_line - last_line > ((window_last_line - window_first_line) / 2) - 1 then
                        vim.api.nvim_command([[keepjumps normal! g`"zz]])
                    else
                        vim.api.nvim_command([[keepjumps normal! G'"<c-e>]])
                    end
                end
                if fn.foldclosed(fn.line(".")) ~= -1 and open_folds == 1 then
                    vim.api.nvim_command([[normal! zvzz]])
                end
            end,
        })
    end,
})
