local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("Comment") then
    local ft = require("Comment.ft")
    ft.set("nwscript", { "//%s", "/*%s*/" })
    ft.set("nss", { "//%s", "/*%s*/" })
    require("Comment").setup()
  end
end

return M
