local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        config = require("kkard2.lazy.catppuccin"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = require("kkard2.lazy.treesitter"),
    },
    { 
        "mbbill/undotree", keys = {
            { "<leader>ut", "<cmd>UndotreeToggle<CR><C-w>h" },
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function() require("lualine").setup({}) end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
})
