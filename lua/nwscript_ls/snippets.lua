local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("luasnip") then
    local luasnip = require("luasnip")
    local loaders = require("luasnip.loaders.from_lua")

    luasnip.filetype_extend("nwscript", { "nwdocs" })
    luasnip.filetype_extend("nss", { "nwdocs" })

    local path = function()
      return vim.fn.stdpath("data") .. "/lazy/nwscript_ls.nvim/snippets"
    end

    loaders.load({ paths = path() })
  end

  if funcs.is_loaded("ultisnips") then
    local path = function()
      return vim.fn.stdpath("data") .. "/lazy/nwscript_ls.nvim/UltiSnips"
    end

    vim.g.UltiSnipsSnippetDirectories = { path(), "UltiSnips" }
  end
end

return M
