local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("neogen") then
    require("neogen").setup({
      languages = {
        nwscript = require("nwscript_ls.neogen.nwscript"),
        nss = require("nwscript_ls.neogen.nwscript"),
      },
    })
  end
end

return M
