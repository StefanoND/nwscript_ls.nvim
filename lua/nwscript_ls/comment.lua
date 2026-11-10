local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("ts_context_commentstring") and funcs.is_loaded("Comment") then
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
    local ft = require("Comment.ft")
    ft.nwscript = { "//%s", "/*%s*/" }
    ft.nss = { "//%s", "/*%s*/" }
  end
end

return M
