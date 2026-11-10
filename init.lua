-- opt-in to use filetype.lua for setting custom filetypes
vim.g.do_filetype_lua = 1 -- Enable

vim.lsp.config("nwscript_ls", {
  filetypes = { "nss", "nwscript" },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("nwscript_ft", { clear = true }),
  pattern = { "*.nss" },
  callback = function()
    vim.bo.filetype = "nwscript"
  end,
})
