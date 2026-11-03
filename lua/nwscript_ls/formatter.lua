local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("conform") then
    require("conform").setup({
      formatters_by_ft = {
        nwscript = { "clang-format" },
        nss = { "clang-format" },
      },
    })
  end
  if funcs.is_loaded("null-ls") then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require("null-ls")

    local format = function(bufnr)
      vim.lsp.buf.format({
        async = false,
        bufnr = bufnr,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end

    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            format(bufnr)
          end,
        })
      end
    end

    local formatting = null_ls.builtins.formatting -- to setup formatters
    local functions = require("nwscript_ls.functions")

    local clangPath = function(path)
      if path ~= nil then
        if functions.clf_path(path) ~= nil then
          return "-style=file:" .. vim.fn.expand(functions.clf_path(path))
        end
      end
      if functions.clf_path() ~= nil then
        return "-style=file:" .. vim.fn.expand(functions.clf_path())
      end
    end

    local sources = {
      formatting.clang_format.with({
        filetypes = { "nss", "nwscript" },
        extra_args = { clangPath() },
      }),

      formatting.clang_format,
    }

    null_ls.register(sources)

    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
      if client.name == "null-ls" then
        on_attach(client, 0)
      end
    end
  end
end

return M
