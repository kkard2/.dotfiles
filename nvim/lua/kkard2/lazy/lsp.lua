-- WARNING: BAD CODE AHEAD
-- look at your own risk
local function rename_file()
    local source_file, target_file

    vim.ui.input({
        prompt = "Source : ",
        completion = "file",
        default = vim.api.nvim_buf_get_name(0)
    },
        function(input)
            source_file = input
        end
    )
    vim.ui.input({
        prompt = "Target : ",
        completion = "file",
        default = source_file
    },
        function(input)
            target_file = input
        end
    )

    local params = {
        command = "_typescript.applyRenameFile",
        arguments = {
            {
                sourceUri = source_file,
                targetUri = target_file,
            },
        },
        title = ""
    }

    vim.lsp.util.rename(source_file, target_file)
    vim.lsp.buf.execute_command(params)
end
-- END OF WARNING

return function()
    local lsp = require("lsp-zero").preset({})

    lsp.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
    end)

    -- (Optional) Configure lua language server for neovim
    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()

    vim.keymap.set("n", "gh", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader><CR>", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)



    -- temp
    require("lspconfig").tsserver.setup({
        commands = {
            RenameFile = {
                rename_file,
                description = "Rename File"
            },
        }
    })
    -- end temp
end
