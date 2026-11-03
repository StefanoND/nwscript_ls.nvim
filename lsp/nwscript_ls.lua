---@type vim.lsp.Config
return {
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  name = "nwscript_ls",
  cmd = { "nwscript_ls" },
  filetypes = { "nss", "nwscript" },
  root_markers = { "nasher.cfg", ".git" },
  message_level = vim.lsp.protocol.MessageType.Error,
  settings = {
    single_file_support = true,
    ["nwscript-ee-lsp"] = {
      completion = {
        addParamsToFunctions = true,
      },
      hovering = {
        addCommentsToFunctions = true,
      },
      formatter = {
        enabled = true,
        verbose = true,
        executable = "clang-format",
      },
      compiler = {
        enabled = true,
        os = vim.uv.os_uname().sysname,
        verbose = true,
        reportWarnings = true,
        nwnHome = os.getenv("NWN_HOME"),
        nwnInstallation = os.getenv("NWN_ROOT"),
        workspaceIncludes = { vim.fn.getcwd() },
      },
    },
  },
  docs = {
    description = [[
      https://github.com/StefanoND/nwscript_ls.nvim

      Language Server Protocol for Neverwinter Nights' NWScript

      nwscript_ls can be installed via npm:
      ]],
  },
}
