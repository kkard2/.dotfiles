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

-- i have no idea why it's here, i'm too afraid to yeet it
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=r")
        vim.cmd("set formatoptions-=o")
    end
})

-- removed because i do autosaves now to test if they're good (they're not)
-- vim.g.zig_fmt_autosave = 0 -- this is pretty annoying

vim.opt.signcolumn = "yes"
vim.opt.list = true

vim.o.exrc = true

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
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\"_xi<CR><Esc>", true, true, true))
    else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("i<CR><Esc>", true, true, true))
    end

    col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local target_char = ","

    -- Check if a comma exists after the cursor
    local comma_pos = line:sub(col + 1):find(target_char)

    if not comma_pos then
        -- If no comma found, check for space instead
        target_char = " "
        local space_pos = line:sub(col + 1):find(target_char)

        if space_pos then
            comma_pos = space_pos
        end
    end
    if comma_pos then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(comma_pos .. "l", true, true, true))

        if char ~= " " then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("l", true, true, true))
        end
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

vim.api.nvim_create_autocmd({"BufWinLeave"}, {
    pattern = {"*.*"},
    desc = "save view (folds), when closing file",
    command = "mkview",
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = {"*.*"},
    desc = "load view (folds), when opening file",
    command = "silent! loadview"
})

-- statusline
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

vim.api.nvim_set_hl(0, "CmpItemAbbr", { foreground = "White" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDefault", { foreground = "White" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { foreground = "Yellow" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchDefault", { foreground = "Yellow" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { foreground = "Yellow" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzyDefault", { foreground = "Yellow" })

vim.api.nvim_set_hl(0, "CmpItemKind", { foreground = "White" })
vim.api.nvim_set_hl(0, "CmpItemKindDefault", { foreground = "White" })
vim.api.nvim_set_hl(0, "CmpItemKindConstant", { foreground = "Red" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { foreground = "Lime" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { foreground = "Lime" })

vim.api.nvim_set_hl(0, "CmpItemMenu", { foreground = "Cyan" })
vim.api.nvim_set_hl(0, "CmpItemMenuDefault", { foreground = "Cyan" })

vim.api.nvim_set_hl(0, "CmpItemMenuDefault", { foreground = "Cyan" })

vim.api.nvim_set_hl(0, "LineNrAbove", { foreground = "LightYellow" })
vim.api.nvim_set_hl(0, "LineNr", { foreground = "White" })
vim.api.nvim_set_hl(0, "LineNrBelow", { foreground = "LightBlue" })

vim.api.nvim_set_hl(0, "MatchParen", { background = "#0000ff" })

-- contents[index] = string.format("%%#HarpoonNumberInactive# [%s] %%#HarpoonInactive#%s ", index, file_name)
vim.api.nvim_set_hl(0, "HarpoonNumberActive", { background = "Gray", foreground = "White" })
vim.api.nvim_set_hl(0, "HarpoonActive", { background = "Gray", foreground = "White" })
vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { background = "Black", foreground = "White" })
vim.api.nvim_set_hl(0, "HarpoonInactive", { background = "Black", foreground = "White" })

vim.api.nvim_set_hl(0, "DapBreakpoint", { background = "Red", foreground = "white" })
vim.api.nvim_set_hl(0, "DapStopped", { background = "#222222" })

vim.api.nvim_create_autocmd('FileType', {
    -- This handler will fire when the buffer's 'filetype' is "python"
    pattern = 'zig',
    callback = function(ev)
        vim.lsp.start({
            name = 'zls',
            cmd = {'zls'},

            -- Set the "root directory" to the parent directory of the file in the
            -- current buffer (`ev.buf`) that contains either a "setup.py" or a
            -- "pyproject.toml" file. Files that share a root directory will reuse
            -- the connection to the same LSP server.
            root_dir = vim.fs.root(ev.buf, {'build.zig', '.gitignore'}),
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "xml",
    callback = function()
        vim.opt_local.autoindent = false
        vim.opt_local.smartindent = false
        vim.opt_local.cindent = false
    end,
})

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
                ignore_install = {
                    "haskell", -- hangs terminal window in certain cases
                    "html",
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
        tag = "0.1.6",
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
                    map("<leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
                    map("<leader><CR>", vim.lsp.buf.code_action, "Code Action")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help)

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function(_)
                            local ft = vim.api.nvim_buf_get_option(0, "filetype")

                            if ft == "rust" or ft == "zig" then
                                vim.lsp.buf.format()
                            end
                        end
                    })
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
                }),
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

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
                vim.cmd(":do User")
            end)
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

            vim.keymap.set("n", "1<leader>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "2<leader>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "3<leader>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "4<leader>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "5<leader>", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "6<leader>", function() harpoon:list():select(6) end)
            vim.keymap.set("n", "7<leader>", function() harpoon:list():select(7) end)
            vim.keymap.set("n", "8<leader>", function() harpoon:list():select(8) end)
            vim.keymap.set("n", "9<leader>", function() harpoon:list():select(9) end)

            -- thx @lokxii, exactly what i wanted (https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1893131934)
            function Harpoon_files()
                local contents = {}
                local marks_length = harpoon:list():length()
                local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

                for index = 1, marks_length do
                    -- https://github.com/ThePrimeagen/harpoon/issues/555
                    local success, harpoon_file_path = pcall(function()
                        return harpoon:list():get(index).value
                    end)

                    if not success then
                        return ""
                    end

                    local file_name = harpoon_file_path == "" and "(empty)" or
                        vim.fn.fnamemodify(harpoon_file_path, ':t')

                    if current_file_path == harpoon_file_path then
                        contents[index] = string.format("%%#HarpoonNumberActive# [%s] %%#HarpoonActive#%s ", index,
                            file_name)
                    else
                        contents[index] = string.format("%%#HarpoonNumberInactive# [%s] %%#HarpoonInactive#%s ", index,
                            file_name)
                    end
                end

                return table.concat(contents)
            end

            vim.opt.showtabline = 2
            vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "User" }, {
                callback = function(_)
                    local result = Harpoon_files()

                    if result == "" then
                        vim.opt.showtabline = 1
                    else
                        vim.opt.showtabline = 2
                    end

                    vim.o.tabline = result
                end
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add    = { text = '+' },
                change = { text = '~' },
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
            vim.keymap.set("n", "-", oil.open) -- stolen from teej, makes sense
        end
    },
    {
        "mfussenegger/nvim-dap",
        keys = {
            {
                "\\r",
                function()
                    local runfile = io.open("compile.txt", "r")

                    if runfile then
                        local line = runfile:read("*l")
                        runfile:close()
                        os.execute(line)
                    else
                        print("hurr durr create compile.txt")
                        return
                    end

                    require("dap").continue()
                end
            },
            { "\\c", function() require("dap").continue() end },
            { "\\p", function() require("dap").pause() end },

            { "\\b", function() require("dap").toggle_breakpoint() end },
            { "\\B", function() require("dap").set_breakpoint(vim.fn.input("condition> ")) end },

            { "\\j", function() require("dap").step_into() end },
            { "\\k", function() require("dap").step_out() end },
            { "<C-\\>", function() require("dap").step_over() end },

            { "\\R", function() require("dap").run_to_cursor() end },
            { "\\s", function() require("dap").close() end },
        },

        config = function()
            local dap = require("dap")
            dap.adapters.coreclr = {
                type = "executable",
                command = "netcoredbg",
                args = { "--interpreter=vscode" },
            };
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        local programfile = io.open("program.txt", "r")

                        if programfile then
                            local line = programfile:read("*l")
                            programfile:close()
                            return vim.fn.getcwd() .. "/" .. line
                        end

                        return vim.fn.input(
                            "Path to dll >",
                            vim.fn.getcwd() .. "/bin/Debug/",
                            "file"
                        )
                    end,
                },
            }

            local sign = vim.fn.sign_define

            sign("DapBreakpoint", { text = "b", texthl = "DapBreakpoint", linehl = "", numhl = ""})
            sign("DapBreakpointCondition", { text = "B", texthl = "DapBreakpoint", linehl = "", numhl = ""})
            sign('DapStopped', { text='>', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
        end
    },
})
