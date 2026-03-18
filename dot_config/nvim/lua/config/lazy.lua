-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- プラグイン一覧
  spec = {
    -- lua/plugins/*.lua,
    -- lua/plugins/**/*.lua を spec として読み込む
    { import = "plugins" },
    -- { import = "plugins.lsp"},

    -- 1 line で書ける Pluguin
    { "vim-jp/autofmt" },
    { "folke/which-key.nvim", event = "VeryLazy", opts = { } },

    -- colors tmux 非対応
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    -- { "shaunsingh/nord.nvim"},

    -- [TODO] lsp, mason は導入したので，あとは lsp の情報を使って補完する方
    -- 法を調べる。
    -- [TODO] また，keybinding の設定など

    -- -- 補完
    -- { "hrsh7th/nvim-cmp", event = "VeryLazy", opts = { } },
    -- { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy", opts = { } },

    -- -- スニペット
    -- { "L3MON4D3/LuaSnip", event = "VeryLazy", opts = { } },
    -- { "saadparwaiz1/cmp_luasnip", event = "VeryLazy", opts = { } },

  },

  -- lua rocks
  rocks = {
    enabled = true,
    hererocks = false,
    root = "C:/lua", -- hererocks で選んだ path。
  },

  -- Lazy の挙動
  change_detection = { notify = false },
  -- 更新チェック
  -- cehcker = {} 
})

