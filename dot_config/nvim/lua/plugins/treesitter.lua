-- req: git, clang, build-essential

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    lazy = false,
    build = ':TSUpdate',

    config = function()
        local ts = require("nvim-treesitter")
        local parsers = {
            "rust",
            "python",
            "lua",
            "bash",
            "zsh",
            "markdown",
            "markdown_inline",
            "json",
            "toml",
            "c",
            "cpp",
            "query",
            "vim",
            "vimdoc",
            "tmux",
        }

        for _, parser in ipairs(parsers) do
            ts.install(parser)
        end

        vim.api.nvim_create_autocmd('FileType', {
            pattern = parsers,
            callback = function()
                vim.treesitter.start()

                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.opt.foldenable = true
                vim.opt.foldlevel = 99

                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}


