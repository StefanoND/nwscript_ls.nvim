vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.cmd([[
    set syntax=nwscript.doxygen
    hi! link doxygenStartL Comment
    hi! link doxygenParam Special
    hi! link doxygenParamName Special
    hi! link doxygenSpecialOneLineDesc Comment
    hi! link doxygenSpecialTypeOneLineDesc Special
    hi! link doxygenBOther Special
    hi! link doxygenBriefWord Special
    hi! link doxygenBrief Comment
    hi! TSComment gui=NONE
]])

local win = vim.api.nvim_get_current_win()
vim.wo[win].foldmethod = "expr"
vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[win].foldlevel = 99
vim.wo[win].foldcolumn = "1"
