return function()
    require("catppuccin").setup({
        no_italic = true,
        color_overrides = {
            mocha = {
                base = "#000000",
                mantle = "#000000",
                crust = "#000000",
            },
        },
        highlight_overrides = {
            mocha = function(c)
                return {
                    MiniTrailspace = { bg = c.red },
                }
            end,
        },
    })

    vim.cmd("colorscheme catppuccin-mocha")
end
