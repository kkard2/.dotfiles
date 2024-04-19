vim.g.mapleader = " "

-- set
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 2

vim.opt.colorcolumn = "80,100,120"

vim.api.nvim_create_autocmd({"BufEnter"}, {
    callback = function()
        vim.cmd("set formatoptions-=r")
        vim.cmd("set formatoptions-=o")
    end
})


vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_banner = 0

vim.opt.signcolumn = "yes"
vim.opt.list = true

vim.o.exrc = true

vim.keymap.set("n", "<leader>w", vim.cmd.write)

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])
vim.keymap.set("n", "<leader>D", [["+D]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<Esc>", function()
    local win_number = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win_number).relative ~= "" then
        vim.cmd("q")
    else
        vim.cmd("noh")
    end
end)

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

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
    if vim.opt.expandtab:get() then
        vim.opt.expandtab = false
    else
        vim.opt.expandtab = true
    end

    -- this is idiotic
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, true, true))
end)

vim.cmd([[set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P]]) --default
vim.cmd([[set statusline+=\ ft=%{&filetype}]])
vim.cmd([[set statusline+=\ ff=%{&fileformat}]])
vim.cmd([[set statusline+=\ spaces=%{&expandtab}]])
vim.cmd([[set statusline+=%{get(b:,'\ \ gitsigns_status','')}]])

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

vim.api.nvim_set_hl(0, "FloatBorder", { foreground = nil, background = nil })

vim.api.nvim_set_hl(0, "DiagnosticError", { foreground = "White", background = "DarkRed" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { foreground = "Yellow" })

-- rust analyzer makes this navy blue by default for some reason
vim.api.nvim_set_hl(0, "CmpItemAbbr", { foreground = "White" })

vim.api.nvim_set_hl(0, "LineNrAbove", { foreground = "LightYellow" })
vim.api.nvim_set_hl(0, "LineNr", { foreground = "White" })
vim.api.nvim_set_hl(0, "LineNrBelow", { foreground = "LightBlue" })

vim.api.nvim_set_hl(0, "MatchParen", { background = "#0000ff" })

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
        branch = "master",
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
            { "<leader>u", "<cmd>UndotreeToggle<CR><C-w>h<C-w>h<C-w>h<C-w>h" }
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
    "tpope/vim-fugitive",

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("gh", vim.diagnostic.open_float, "[G]oto [H]ighlight Error (idk)")

                    map("[d", vim.diagnostic.goto_next, "Next [D]iagnostic")
                    map("]d", vim.diagnostic.goto_prev, "Prev [D]iagnostic")

                    map("<leader>lr", vim.lsp.buf.rename, "[L]SP [R]ename")
                    map("<leader><CR>", vim.lsp.buf.code_action, "Code Action")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }

            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua",
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "quangnguyen30192/cmp-nvim-tags", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "tags" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            })
        end

    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})

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
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { text = '+' },
                change       = { text = '~' },
                -- delete       = { text = '_' },
                -- topdelete    = { text = '‾' },
                -- changedelete = { text = '~' },
                -- untracked    = { text = '┆' },
            },
            on_attach = function()
                local gitsigns = require("gitsigns")
                vim.keymap.set("n", "<leader>K", gitsigns.preview_hunk)
            end
        },
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        config = function()
            local oil = require("oil")
            oil.setup({})
            vim.keymap.set("n", "<leader>ff", oil.open)
        end
    }
})
