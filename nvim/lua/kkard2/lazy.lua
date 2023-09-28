local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
        config = require("kkard2.lazy.catppuccin"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = require("kkard2.lazy.treesitter"),
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>ut", "<cmd>UndotreeToggle<CR><C-w>h" },
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("lualine").setup({
            options = {
                component_separators = { left = " ", right = " " },
                section_separators = { left = " ", right = " " },
            },
        }) end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader><leader>", "<cmd>Telescope find_files<CR>" },
            { "<leader>fg",       "<cmd>Telescope live_grep<CR>" },
            { "<leader>fh",       "<cmd>Telescope help_tags<CR>" },
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        },
        config = require("kkard2.lazy.lsp"),
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            icons = false,
            fold_open = "-",      -- icon used for open folds
            fold_closed = "+",    -- icon used for closed folds
            indent_lines = false, -- add an indent guide below the fold icons
            signs = {
                -- icons / text used for a diagnostic
                error = "E",
                warning = "W",
                hint = "H",
                information = "I"
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        },
        keys = {
            { "<leader>xx", function() require("trouble").open() end },
            { "<leader>xw", function() require("trouble").open("workspace_diagnostics") end },
            { "<leader>xd", function() require("trouble").open("document_diagnostics") end },
        },
    },
    {
        "echasnovski/mini.trailspace",
        config = function() require("mini.trailspace").setup() end,
    },

    { "github/copilot.vim" },
    { "https://tpope.io/vim/repeat.git" },
    { "https://tpope.io/vim/surround.git" },
    -- i also don't know why the above ones are like this
    { "tpope/vim-commentary" },
})
