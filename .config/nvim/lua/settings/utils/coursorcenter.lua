vim.api.nvim_create_autocmd({ "CursorMoved", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        vim.cmd [[exec "normal zz"]]
        vim.api.nvim__redraw({valid=true})
    end,
})
