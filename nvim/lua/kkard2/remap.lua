vim.g.mapleader = " "

vim.keymap.set({"n", "v"}, ";", ":")
vim.keymap.set({"n", "v"}, ":", ";")

vim.keymap.set("n", "<leader>ff", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set({"n", "v"}, "<leader>d", [["+d]])
vim.keymap.set("n", "<leader>D", [["+D]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("i", "<C-Enter>", "<Esc>o")

-- exit floating window when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", function()
    local win_number = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win_number).relative ~= "" then
        vim.cmd(":q")
    end
end)

-- lmao
vim.keymap.set("i", "<S-Tab>", "<Esc>0d$?.<CR><cmd>noh<CR>0yw<C-o>0\"_d$pa")
vim.keymap.set("n", "<C-j>", "xi<CR><Esc>f ")
