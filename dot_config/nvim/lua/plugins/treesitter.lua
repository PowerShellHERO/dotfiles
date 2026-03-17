-- req: git, cc

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ":TSUpdate",

    config = function()
        local configs = require("nvim-treesitter.config")
        configs.setup({
            highlight = { enable = true, },
            indent    = { enable = true, },
            auto_install = true,

            ensure_installed = {
                "lua",
                "c",
                "cpp",
                "python",
                "query",
                "vim",
                "markdown",
                "markdown_inline",
                "vimdoc",
                "bash",
                "tmux",
                "rust",
            },
        })
    end
}
