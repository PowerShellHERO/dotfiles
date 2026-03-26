
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
require('config.lazy')

require('user.ime2')
require('user.file_navigation').setup()


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


-- abbreviations {{{

vim.cmd([[
" iabbr nvim Neovim
cabbr add !chezmoi add %
cabbr ya %y
]])

-- }}}

-- Untill Lazy Install
-- vim.cmd.colorscheme("unokai")


-- JAPANESE WRITING (vip gq)
vim.opt.textwidth  = 76
vim.opt.formatexpr = "autofmt#japanese#formatexpr()"
-- vim.opt.wrap = true

vim.keymap.set('n', '<leader>i', 'gg=G<C-o>', { desc = 'Re-Indent buffer' })

vim.opt.wildmode = "noselect"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function ()
    vim.fn.wildtrigger()
  end
})

-- Set Search Pattern
vim.keymap.set('n', '<Leader>l', function()
    local ft = vim.bo.filetype
    local pattern = ""

    if ft == "lua" then
        -- Lua: require('...') の中身を選択
        pattern = [[\v^require\('\zs.*\ze'\)]]
    else
        -- markdownlink URL
        pattern = [[\v\]\(\zs.*\ze\)]]
    end

    -- 検索レジスタ（/）にパターンをセット
    vim.fn.setreg("/", pattern)

    print("Set Search pattern for" .. ft)
end, { desc = "Set search pattern based on filetype" })

