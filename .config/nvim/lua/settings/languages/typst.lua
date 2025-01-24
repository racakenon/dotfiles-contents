local root_files = {
	'.git'
}
local cmd = { 'tinymist' }
require 'settings.languages.lsp'.setup('typst', 'tinymist', root_files, cmd, {
	settings = {
		exportPdf = "onSave",
		outputPath = "$root/$name",
		formatterMode = "typstyle",
	}
})

--[[ vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    os.execute("zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
  end
end, {}) ]]
