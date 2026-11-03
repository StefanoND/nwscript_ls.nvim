local M = {}

local funcs = require("nwscript_ls.functions")

M.setup = function()
  if funcs.is_loaded("nvim-treesitter") then
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      group = vim.api.nvim_create_augroup("nwscript_ft", { clear = true }),
      pattern = { "*.nss" },
      callback = function()
        vim.bo.filetype = "nwscript"
      end,
    })

    -- local parser = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser.nwscript = {
    --   install_info = {
    --     url = "https://github.com/StefanoND/tree-sitter-nwscript",
    --     files = { "src/parser.c" },
    --     generate_requires_npm = false,
    --     requires_generate_from_grammar = false,
    --   },
    --   filestype = "nwscript",
    -- }

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").lua.install_info.generate = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").nwscript = {
          install_info = {
            url = "https://github.com/StefanoND/tree-sitter-nwscript",
            revision = "ebafc659d634881bff8feb4b6cd35bf70e904e33", -- commit hash for revision to check out; HEAD if missing
            generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
            generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
            queries = "queries", -- also install queries from given directory
          },
          tier = 1,
        }
      end,
    })

    require("nvim-treesitter.config").setup()
    require("nvim-treesitter").install("nwscript")

    -- require("nvim-treesitter.config").setup(opts)
  end
end

return M
