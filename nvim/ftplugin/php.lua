local copy_indent_macro = "<Esc>^\"_d0" -- clear current indentation
    .. "?.<CR>" -- find first non-empty line above
    .. "<cmd>noh<CR>" -- clear highlight
    .. "^\"yy0" -- copy indentation to y register
    .. "<C-o>0" -- return to original line
    .. "\"yP" -- paste y register
    .. "a" -- enter insert mode

vim.keymap.set({ "n" }, "o", "o" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "n" }, "O", "O" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "i" }, "<CR>", "<CR>" .. copy_indent_macro, { buffer = 0 })
