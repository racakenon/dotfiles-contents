if string.find(vim.uv.os_uname().release, 'microsoft') ~= nil then
    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        pattern = "*",
        callback = function()
            vim.system({ '/mnt/c/windows/system32/clip.exe' }, { stdin = vim.trim(vim.fn.getreg('"')) })
        end,
    })
end
