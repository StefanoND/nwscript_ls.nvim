local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("nvim-web-devicons") then
    local devicons = require("nvim-web-devicons")

    devicons.set_icon_by_filetype({
      nwscript = "nwscript",
      nss = "nwscript",
    })

    devicons.set_icon({
      nwscript = {
        icon = "󰛐",
        color = "#b4befe",
        cterm_color = "153",
        name = "nwscript",
      },
      nss = {
        icon = "󰛐",
        color = "#b4befe",
        cterm_color = "153",
        name = "nwscript",
      },
    })

    devicons.setup({
      override = {
        nwscript = {
          icon = "󰛐",
          color = "#b4befe",
          cterm_color = "153",
          name = "nwscript",
        },
        nss = {
          icon = "󰛐",
          color = "#b4befe",
          cterm_color = "153",
          name = "nwscript",
        },
      },
    })
  end
  if funcs.is_loaded("mini.nvim") or funcs.is_loaded("mini.icons") then
    require("mini.icons").setup({
      filetype = {
        nwscript = { glyph = "󰛐", hl = "MiniIconsBlue" },
        nss = { glyph = "󰛐", hl = "MiniIconsBlue" },
      },
    })
    require("mini.icons").mock_nvim_web_devicons()
  end
end

return M
