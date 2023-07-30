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
end
