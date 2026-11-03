-- opt-in to use filetype.lua for setting custom filetypes
vim.g.do_filetype_lua = 1 -- Enable

vim.lsp.config("nwscript_ls", {
  filetypes = { "nss", "nwscript" },
})
