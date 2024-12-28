local copy_indent_macro = "<Esc>0\"_d$?.<CR><cmd>noh<CR>0\"myw<C-o>0\"_d$\"mpa"

vim.keymap.set({ "n" }, "o", "o" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "n" }, "O", "O" .. copy_indent_macro, { buffer = 0 })
vim.keymap.set({ "i" }, "<CR>", "<CR>" .. copy_indent_macro, { buffer = 0 })
