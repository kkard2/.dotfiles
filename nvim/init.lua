-- set
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false -- i didn't like it

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 2

vim.opt.colorcolumn = "80,100,120"

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_banner = 0

vim.opt.signcolumn = "yes"
vim.opt.list = true

vim.o.exrc = true

-- remap
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")

vim.keymap.set("n", "<leader>ff", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])
vim.keymap.set("n", "<leader>D", [["+D]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("i", "<NL>", "<Esc>o")
vim.keymap.set("n", "<NL>", "o<Esc>")

vim.keymap.set("n", "<Esc>", function()
    local win_number = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win_number).relative ~= "" then
        vim.cmd("q")
    end
end)

-- copy indent from line above
vim.keymap.set("i", "<S-Tab>", "<Esc>0\"_d$?.<CR><cmd>noh<CR>0\"myw<C-o>0\"_d$\"mpa")
-- insert line break under cursor in normal mode
vim.keymap.set("n", "<C-j>", function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

    if char == " " then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\"_xi<CR><Esc>f ", true, true, true))
    else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("i<CR><Esc>f ", true, true, true))
    end
end)

vim.keymap.set("n", "<leader>tt", function()
    -- idk it works
    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.expandtab:get() then
        vim.opt.expandtab = false
    else
        vim.opt.expandtab = true
    end

    -- this is idiotic
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, true, true))
end)

-- what not using lualine does to a mf
vim.cmd([[set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P]]) --default
vim.cmd([[set statusline+=\ ft=%{&filetype}]])
vim.cmd([[set statusline+=\ ff=%{&fileformat}]])
vim.cmd([[set statusline+=\ spaces=%{&expandtab}]])

-- closing "code blocks"
vim.keymap.set("i", "<C-l>", function()
    if vim.bo.filetype == "html" or vim.bo.filetype == "xml" then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
            [[<Esc>mx?<[^/].\{-}><CR>l"zy/[ >]<CR>`xa<CR></<Esc>"zpa><Esc>O]],
            true, true, true
        ))
        vim.schedule(function()
            vim.cmd("noh")
        end)
    elseif vim.bo.filetype == "lua" then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
            [[<CR>end<Esc>O]], true, true, true
        ))
    else -- reasonable default
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
            [[<CR>}<Esc>O]], true, true, true
        ))
    end
end)

-- i've heard you tagged your files so i tagged your file that were not tagged
vim.keymap.set("n", "<leader>tf", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.cmd("silent !ctags -a " .. path)
end)

vim.keymap.set("n", "<leader>td", function()
    vim.cmd("silent !ctags -aR .")
end)


-- colorscheme

vim.cmd("colorscheme industry")
vim.opt.guicursor = "n-v-c-i-r:block";

vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = nil, ctermbg = nil })

vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = "White", ctermbg = "DarkRed" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = "LightYellow" })

vim.api.nvim_set_hl(0, "LineNrAbove", { ctermfg = "LightYellow" })
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = "White" })
vim.api.nvim_set_hl(0, "LineNrBelow", { ctermfg = "LightBlue" })


-- lazy.nvim
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
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                highlight = {
                    enable = true,
                },
            })
            vim.cmd("TSUpdate")
        end
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>ut", "<cmd>UndotreeToggle<CR><C-w>h<C-w>h<C-w>h<C-w>h" }
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
        keys = {
            { "<leader><leader>", "<cmd>Telescope find_files<CR>" },
            { "<leader>fg",       "<cmd>Telescope live_grep<CR>" },
            { "<leader>fh",       "<cmd>Telescope help_tags<CR>" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    preview = {
                        treesitter = false,
                    },
                    file_ignore_patterns = {
                        ".git",
                        -- i should probly make this less bad
                        "zig-cache/",
                        "zig-out/",
                        "build/",
                        "bin/",
                    },
                },
            })
        end
    },

    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-commentary",

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            local lsp = lsp_zero.preset({})
            local lspconfig = require("lspconfig")

            lspconfig.rust_analyzer.setup({})
            lspconfig.zls.setup({})
            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
            lspconfig.omnisharp.setup({
                cmd = { "OmniSharp" }
            })
            lspconfig.clangd.setup({})

            lsp.setup()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gh", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader><CR>", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
                    vim.keymap.set("n", "<leader>ls", function()
                        vim.lsp.stop_client(vim.lsp.get_clients())
                    end)
                end,
            })
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "quangnguyen30192/cmp-nvim-tags" },
        config = function()
            require("cmp").setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "tags" },
                },
            })
        end

    },
    { "L3MON4D3/LuaSnip" },
    { "neovim/nvim-lspconfig" },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>s", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
            vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
            vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
            vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)
        end,
    }
})
