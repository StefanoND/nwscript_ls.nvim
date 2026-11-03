local M = {}

M.setKeymaps = function(client, bufnr)
  local kmn = function(key, func, desc)
    vim.keymap.set("n", key, func, { desc = desc or "", noremap = true, buffer = bufnr, silent = true })
  end

  local funcs = require("nwscript_ls.functions")

  if funcs.is_loaded("which-key") ~= nil then
    local wk = require("which-key")
    wk.add({
      mode = { "n" },
      {
        {
          "<leader>nwc",
          function()
            funcs.nasher_compile(false)
          end,
          desc = "Compile current script",
        },
        {
          "<leader>nwC",
          function()
            funcs.nasher_compile(true)
          end,
          desc = "Compile all scripts",
        },
        {
          "<leader>nwm",
          function()
            funcs.nasher_install("main", "-y")
          end,
          desc = "Pack and install project into module",
        },
        {
          "<leader>nwM",
          function()
            funcs.nasher_unpack("main", "-y")
          end,
          desc = "Unpack module to project folder",
        },
        {
          "<leader>nwh",
          function()
            funcs.nasher_install("haks", "-y")
          end,
          desc = "Pack and install project into separate haks",
        },
        {
          "<leader>nwH",
          function()
            funcs.nasher_unpack("haks", "-y")
          end,
          desc = "Unpack haks to project folder",
        },
        {
          "<leader>nwt",
          function()
            funcs.nasher_install("tlk", "-y")
          end,
          desc = "Pack and install project into tlk",
        },
        {
          "<leader>nwT",
          function()
            funcs.nasher_unpack("tlk", "-y")
          end,
          desc = "Unpack tlk to project folder",
        },
      },
    })
  else
    kmn("<leader>nwc", function()
      funcs.nasher_compile(false)
    end, "Compile current script")
    kmn("<leader>nwC", function()
      funcs.nasher_compile(true)
    end, "Compile all scripts")
    kmn("<leader>nwm", function()
      funcs.nasher_install("main", "-y")
    end, "Pack project into module")
    kmn("<leader>nwM", function()
      funcs.nasher_unpack("main", "-y")
    end, "Unpack module to project folder")
    kmn("<leader>nwh", function()
      funcs.nasher_install("haks", "-y")
    end, "Pack project into module")
    kmn("<leader>nwH", function()
      funcs.nasher_unpack("haks", "-y")
    end, "Unpack module to project folder")
    kmn("<leader>nwt", function()
      funcs.nasher_install("tlk", "-y")
    end, "Pack project into module")
    kmn("<leader>nwT", function()
      funcs.nasher_unpack("tlk", "-y")
    end, "Unpack module to project folder")
  end
end

return M
