-- 使いたい color は `lazy = ture` にする。
-- config 内で colorscheme を適用しない
-- お試しは `lazy = false` (ただし :colorscheme から補完は出来ない)

return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins

        opts = {
            styles = {
                keywords = { italic = false },
                comments = { italic = false },
            },
        },

        config = function()
            -- load the colorscheme here
            vim.cmd('colorscheme tokyonight')
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end,

    },

    {
        "Kopihue/one-dark-pro-max",
        lazy = true,
        -- event = "VeryLazy",
        name = "one-dark-pro-max",
        opts = {
            transparency = false,
            bold = true,
            italic = false,
        },
    },

    {
        "rose-pine/neovim",
        lazy = true,
        name = "rose-pine",
        opts = {
            variant = "moon",
            dark_variant = "main",

            styles = {
                bold = true,
                italic = false,
                transparency = false,
            },
        }
    },
}


