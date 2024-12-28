local copy_indent_macro = "<Esc>0\"_D" -- clear current line
    .. "?.<CR>" -- find first non-empty line above
    .. "<cmd>noh<CR>" -- clear highlight
    .. "^\"yy0" -- copy indentation to y register
    .. "<C-o>" -- return to original line
    .. "\"yp" -- paste y register
    .. "A" -- enter insert mode

vim.keymap.set({ "n" }, "o", "o" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "n" }, "O", "O" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "i" }, "<CR>", "<CR>" .. copy_indent_macro, { buffer = 0 })
