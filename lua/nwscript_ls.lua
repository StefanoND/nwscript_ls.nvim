local M = {}

M.setup = function(opts)
  opts = opts or nil
  local functions = require("nwscript_ls.functions")

  vim.cmd([[autocmd FileType *.nss setfiletype nwscript]])

  if opts and opts.auto_build then
    if not functions.find_executable("node") then
      vim.notify("You must have Node.js installed", vim.log.levels.ERROR)
    end
    if not functions.find_executable("npm") then
      vim.notify("You must have npm installed", vim.log.levels.ERROR)
    end
    if functions.find_executable("node") and functions.find_executable("npm") then
      local path = vim.fn.stdpath("data") .. "/lazy/nwscript_ls.nvim/build_lsp.sh"
      local chmod = "silent!!chmod +x " .. path
      local run = path
      local command = chmod .. " && " .. run
      vim.api.nvim_command(command)
    end
  end

  require("nwscript_ls.treesitter").setup() -- Enable syntax highlighting for NWScript
  require("nwscript_ls.formatter").setup() -- Enable auto-formatting (conform/none-ls) on-save for NWScript
  require("nwscript_ls.snippets").setup() -- Enable snippets (LuaSnip/UltiSnipts) for NWScript
  require("nwscript_ls.neogen").setup() -- Enable "neogen" comment generation functionality for NWScript
  require("nwscript_ls.icons").setup() -- Adds a icon (mini/nvim-web-devicons) for NWScript
  require("nwscript_ls.comment").setup() -- Enable comment for NWScript

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.name == "nwscript_ls" then
        local bufnr = event.buf
        local keymaps = require("nwscript_ls.keymaps")
        keymaps.setKeymaps(client, bufnr) -- Set keymaps
        functions.nwscript_refresh(bufnr) -- Enable auto-refresh on save
      end
    end,
  })

  vim.lsp.enable({
    "nwscript_ls",
  }, true)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nwscript", "nss" },
    callback = function()
      local buf = vim.api.nvim_get_current_buf()

      -- Try to guess the filetype (may change later on during Neovim startup)
      local ft = vim.filetype.match({ buf = buf })
      if ft then
        -- Add treesitter highlights and fallback to syntax
        local lang = vim.treesitter.language.get_lang(ft)

        if not (lang and pcall(vim.treesitter.start, buf, lang)) then
          vim.bo[buf].syntax = ft
        end

        -- Trigger early redraw
        vim.cmd([[redraw]])
      end
    end,
  })

  local ftmodule = "ftplugin.%s"

  local function loadftmodule(ft, action)
    local modname = ftmodule:format(ft)
    local _, res = pcall(require, modname)
    if type(res) == "table" then
      if type(res[action]) == "function" then
        res[action]()
      end
    elseif
      type(res) == "string"
      and not res:match("Module '" .. modname .. "' not found")
      and not res:match("	no file")
    then
      print(res)
    end
  end

  vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter", "Colorscheme" }, {
    pattern = { "*" },
    callback = function()
      loadftmodule(vim.bo.filetype, "ftplugin")
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "*" },
    callback = function()
      loadftmodule(vim.bo.filetype, "newfile")
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "VimEnter", "BufWinEnter", "Colorscheme" }, {
    pattern = { "*" },
    callback = function()
      loadftmodule(vim.bo.filetype, "syntax")
    end,
  })
end

return M
