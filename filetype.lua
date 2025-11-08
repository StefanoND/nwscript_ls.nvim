vim.g.do_filetype_lua = 1 -- Enable

vim.filetype.add({
  extension = {
    nss = "nwscript",
  },
  pattern = {
    [".*%.nss$"] = "nwscript",
  },
})
