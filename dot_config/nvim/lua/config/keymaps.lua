-- Linux Ubuntu

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader Key
vim.g.mapleader = ' '

vim.keymap.set('n', '<Leader>cd', function()
    local current_file = vim.fn.expand('%:t')

    vim.cmd([[
    :Oil
    set hlsearch
    ]])
    vim.fn.setreg('/', current_file)
end, { desc = 'Oil' })

-- EDIT VIMRC
keymap('n', '<Space>o', '<cmd>edit $MYVIMRC<CR>', opts)
-- :sou で十分な気がしてきた
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'vim' },
    callback = function()
        keymap('n', '<Space>e', '<cmd>sou<CR>', { buffer = true, noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'vim' },
    callback = function()
        keymap('v', '<Space>e', "<ESC>:'<,'>lua<CR>", { buffer = true, noremap = true, silent = true })
    end,
})

-- <Leader>8 "#+TITLE: " を挿入
-- vim.keymap.set('n', '<Leader>8', 'gg}i#+TITLE: <ESC>', { noremap = true })

-- <Leader>9: 現在の日時を挿入（形式: %Y-%m-%d %H:%M:%S）
vim.keymap.set('n', '<Leader>9', function()
    local datetime = os.date('%Y-%m-%d %H:%M:%S')
    vim.api.nvim_put({ '### ' .. datetime }, 'c', true, true)
end, { noremap = true })

vim.keymap.set('i', '<C-Space>', ' ', { noremap = true })

-- SAVE, CLOSE
keymap('n', '<Leader>w', '<cmd>w<CR>', opts)
keymap('n', '<Leader>q', '<cmd>bdel<CR>', opts)

-- COMPLETE
keymap('c', '<C-j>', '<C-n>', opts)

-- UNDO, REDO
keymap('n', '<C-u>', 'u', opts)
keymap('v', '<C-u>', '<ESC>:undo<CR>', opts)

-- ESC, INSER:T
keymap({ 'i', 'c' }, '<C-o>', '<Esc>', opts)
keymap('v', '<C-o>', '<Esc>', opts)
keymap('i', '<C-c>', '<C-o>', opts)
-- keymap('n', 'o', 'o<Esc>o', opts)
keymap('n', '<C-h>', 'I', opts)

keymap('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>')

-- SWITCH BUFFER
keymap('n', 'gt', '<cmd>bnext<CR>', opts)
keymap('n', '-', '<cmd>bnext<CR>', opts)
keymap('n', '=', '<cmd>bprevious<CR>', opts)

-- EOF
-- -- Set the previous context mark
-- -- G, zt がいいか zz がいいかは検討中。
keymap('n', '<C-o>', "m'Gzt", opts)

keymap('n', '<C-c>', '<C-o>', opts)

-- ZZs
keymap('n', '<C-n>', 'nzz', opts)
keymap('n', '<C-k>', 'Nzz', opts)
keymap('n', '*', '*zz', opts)
keymap('n', '#', '#zz', opts)

-- FOLD
keymap('n', 'zm', 'za', opts)
keymap('n', 'zn', 'zj', opts)
keymap('n', 'zu', 'zx', opts)
keymap('n', 'zr', 'zX', opts)

-- OTHER
keymap('i', '<C-v>', '<Esc>v', opts)
keymap('n', 'vat', 'va<', opts)
keymap('n', 'vit', 'vi<', opts)
keymap('n', '<C-z>', ':e!<CR>', opts)
keymap('n', 'A', ':%y<CR>', opts)
-- keymap('i', '<C-t>', '<Esc>ea', opts) -- used Tmux Leader Key
keymap('n', '<C-e>', 'xhep', opts)

-- keymap('n', 'd,', 'dt，', opts)
-- keymap('n', 'd.', 'df。', opts)
local function move_to(chars)
    local chars = '[' .. chars .. ']'
    vim.fn.search(chars, 'W', vim.fn.line('.'))

    local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexedの列番号
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if string.find(chars, char) then
        vim.cmd('normal! l')
    end
end

vim.keymap.set('o', '.', function()
    move_to('.。')
end, { desc = 'move to ./。' })

vim.keymap.set('o', ',', function()
    move_to(',.，、。')
end, { desc = 'move to ,/./，/。/、' })

vim.cmd([[
" KILL {

noremap! <C-d> <C-h>

" }
" MOVE: UP, DOWN {

nnoremap k gk
nnoremap n gj
" vnoremap n j
" vnoremap j n

" noremap! == inore + cnore
noremap! <C-k> <UP>
noremap! <C-n> <DOWN>

" inoremap <C-k> <C-o>gk
" inoremap <C-n> <C-o>gj
inoremap <C-j> <C-n>
"" window command
nnoremap <c-w>n <c-w>j

noremap u {zz
noremap e }zz

" }
" MOVE: LEFT, RIGHT {

noremap! <C-l> <RIGHT>
noremap! <C-h> <LEFT>
noremap! <C-e> <End>
inoremap <C-u> <ESC>^i
cnoremap <C-u> <HOME>
map L $
map H ^
nnoremap <C-l> A
vnoremap <C-h> I
""" 矩形選択に対応
vnoremap <C-l> $A

inoremap <C-b> <C-o>b
inoremap <C-f> <C-o>w

" （最後の保存か）バッファが開かれた時の状態に戻す。undo 可能
nnoremap <C-z> :e!<CR>

" USABILITY (なんか挙動がおかしいので，vim.cmd で設定)
nnoremap ; :

"" }
]])
-- -- MOVE: UP, DOWN
vim.keymap.set('x', 'n', 'j')
vim.keymap.set('x', 'j', 'n')

-- Move lines up/down
keymap('n', '<A-n>', ':m .+1<CR>==', { desc = 'Move line down' })
keymap('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
keymap('v', 'N', ":m '>+1<CR>gv=gv", { desc = 'Move Selection down' })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Selection up' })

keymap('n', '<', 'V<gv')
keymap('n', '>', 'V>gv')

-- Better indenting in visual mode
keymap('v', '<', '<gv', { desc = 'Indent left and reselect' })
keymap('v', '>', '>gv', { desc = 'Indent right and reselect' })

keymap('n', '<Leader>m', function()
    print('a')
end, { desc = 'ii' })

-- copy
keymap('v', 'p', 'P', opts)

-- test
keymap('v', 'gp', 'gq', opts)
