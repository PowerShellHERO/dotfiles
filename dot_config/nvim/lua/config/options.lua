
-- Linux Ubuntu

os.setlocale('C')

-- オプション設定
local opt = vim.opt

-- ENCODE
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.bomb = false

-- CODE STYLE
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4 -- 連続空白に対して，backspace などが動く量
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4 -- smartindentでずれる幅

-- -- FILE
opt.hidden = true
opt.backup = false
opt.undofile = false
-- opt.directory = 'c:\\nvimswap'
opt.history = 1000
opt.foldmethod = 'marker'
opt.iskeyword:append({ "'" })
opt.iskeyword:remove({ "-" })
opt.helplang = { 'en' }
opt.suffixesadd:append({ '.txt', '.md' })
opt.wildmenu = true
opt.wildmode = 'full'
opt.display:append('lastline')

-- FileType
-- Lua, VimScript
vim.api.nvim_create_augroup("LuaSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "LuaSettings",
  pattern = "lua",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.expandtab = true
    vim.o.number = true
    vim.o.relativenumber = true
  end,
})

-- Markdown
vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "MarkdownSettings",
  pattern = "markdown",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- EDITING
-- [TODO] 要調査
-- vim.opt.completeopt = { "menu", "menuone", "preview" }
opt.backspace = { 'indent', 'eol', 'start' }
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.clipboard = 'unnamed'
opt.wrap = false

-- SEARCH STRING
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- [TODO] 要調査
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--   group = group_name,
--   pattern = { "*grep*" },
--   command = "cwindow",
-- })

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true

-- Keep signcolumn on by default
-- 左端に，modified mark などを表示するためのスペースを常時表示する
vim.o.signcolumn = 'no'

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
-- vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '|_', trail = '+', nbsp = '_' }

-- Preview substitutions live, as you type!
-- 置換の live preview
vim.o.inccommand = 'split'

-- -- Show which line your cursor is on
-- vim.o.cursorline = true

-- -- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- (like `:q`), 確認が必要な buffer に飛んで dialog asking
-- See `:help 'confirm'`
vim.o.confirm = true


-- vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })


