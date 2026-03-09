
    ----------------------
   --                  --
  --   nvim ubuntu    --
 --                  --
----------------------

-- netrw
    -- d, new dir
    -- %, new file

function pp(v) print(vim.inspect(v)) end -- pretty print table

require('config.options')
require('config.keymaps')
-- require("user.ime").setup()
require("user.ime2").setup()

-- YANK {{{
local binpath = '~/bin/'
local clippath = binpath .. 'clip.exe'
local copycmd = "iconv -f utf-8 -t utf-16le | sed '1s/^\xFF\xFE//' | " .. clippath
local group = vim.api.nvim_create_augroup("Yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    local yanked = vim.fn.getreg('"')
    vim.fn.system(copycmd, yanked)
  end,
})
-- x 連打で，autocmd も連打されるのを回避。
-- x を null register に捨てる。yank しない。
-- ただし xp (1文字送り，割と使う) は使えなくなる。
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete using blackhole register' })

-- }}}

-- abbreviations
vim.cmd([[
" iabbr nvim Neovim
cabbr add !chezmoi add %
]])

-- Untill Lazy Install
vim.cmd.colorscheme("unokai")



