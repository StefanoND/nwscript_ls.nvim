---@type vim.lsp.Config
return {
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  name = "nwscript_ls",
  cmd = { "nwscript_ls" },
  filetypes = { "nss", "nwscript" },
  root_markers = { "nasher.cfg", ".git" },
  -- root_dir = function(fname)
  --   return vim.fs.dirname(vim.fs.find({ "nasher.cfg", ".git" }, { path = fname, upward = true })[1])
  -- end,
  message_level = vim.lsp.protocol.MessageType.Error,
}
