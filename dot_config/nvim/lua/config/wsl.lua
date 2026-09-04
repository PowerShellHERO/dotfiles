--[[

依存:
-  clip.exe : `~/bin` に置く

--]]

require('user.ime2')

-- [TODO] folder を wsl に移動
-- [TODO] このファイルは wsl/init.lua でもいい。
-- [TODO] user.ime2 を wsl/ime2.lua に
-- [TODO] wsl/clip.lua を作成 `YANK {..` 以下を移す

-- if not os.getenv("WSL_DISTRO_NAME") then
--     return {}
-- end
--
-- require('wsl.ime2')
-- require('wsl.clip')

-- YANK {{{
-- for WSL
local bin_path = '~/bin/'
local clip_path = bin_path .. 'clip.exe'

if not vim.uv.fs_stat(vim.fn.expand(clip_path)) then
    return {}
end

local copycmd = "iconv -f utf-8 -t utf-16le | sed '1s/^\xFF\xFE//' | " .. clip_path
local group = vim.api.nvim_create_augroup('Yank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
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
