
-- Linux Ubuntu

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader Key
vim.g.mapleader = ' '

vim.keymap.set("n", "<Leader>cd", function()
  local current_file = vim.fn.expand('%:t')
  local search_current_file = (current_file == "") and "" or  ('/' .. current_file)
  vim.cmd.Ex()
  vim.cmd(search_current_file)
end ,{ desc="Netrw with Temporary Buffer" })

-- EDIT VIMRC
keymap('n', '<Space>o', '<cmd>edit $MYVIMRC<CR>', opts)
-- :sou で十分な気がしてきた
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim' },
  callback = function()
    keymap('n', '<Space>e', '<cmd>sou<CR>', { buffer = true, noremap = true, silent = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim' },
  callback = function()
    keymap('v', '<Space>e', "<ESC>:'<,'>lua<CR>", { buffer = true, noremap = true, silent = true })
  end
})

-- <Leader>8 "#+TITLE: " を挿入
-- vim.keymap.set('n', '<Leader>8', 'gg}i#+TITLE: <ESC>', { noremap = true })

-- <Leader>9: 現在の日時を挿入（形式: %Y-%m-%d %H:%M:%S）
vim.keymap.set('n', '<Leader>9', function()
  local datetime = os.date('%Y-%m-%d %H:%M:%S')
  vim.api.nvim_put({ datetime }, 'c', true, true)
end, { noremap = true })

vim.keymap.set('i', '<C-Space>', ' ', { noremap = true })

-- SAVE, CLOSE
-- <C-u> は，直前のコマンドライン入力を先頭まで消去する意味で使われている。
-- モダンな書き方は， <cmd> を使うことで，<C-u> を使うのと同等に安全であるし
-- 推奨された書き方。
-- keymap('n', '<Leader>w', ':<C-u>w<CR>', opts)
-- keymap('n', '<Leader>q', ':<C-u>bdel<CR>', opts)

keymap('n', '<Leader>w', '<cmd>w<CR>', opts)
keymap('n', '<Leader>q', '<cmd>bdel<CR>', opts)

-- COMPLETE
keymap('c', '<C-j>', '<C-n>', opts)

-- UNDO, REDO
keymap('n', '<C-u>', 'u', opts)
keymap('v', '<C-u>', '<ESC>:undo<CR>', opts)

-- ESC, INSER:T
keymap({'i','c'}, '<C-o>', '<Esc>', opts)
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
keymap('n', '<C-o>', "m'G", opts)
keymap('n', '<C-c>', '<C-o>', opts)

-- USABILITY (なんか挙動がおかしいので，vim.cmd で設定)
-- keymap('n', ';', ':', opts)
-- keymap('v', ';', ':', opts)

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
keymap('n', 'd,', 'dt，', opts)
keymap('n', 'd.', 'df。', opts)
keymap('n', '<C-z>', ':e!<CR>', opts)
keymap('n', 'A', ':%y<CR>', opts)
-- keymap('i', '<C-t>', '<Esc>ea', opts) -- used Tmux Leader Key
keymap('n', '<C-e>', 'xhep', opts)


vim.cmd([[
set ambiwidth=double 
" KILL {

    noremap! <C-d> <C-h>

" }
" MOVE: UP, DOWN {

nnoremap k gk
nnoremap n gj
vnoremap n j
vnoremap j n
cnoremap <C-k> <UP>
cnoremap <C-n> <DOWN>
inoremap <C-k> <UP>
inoremap <C-n> <DOWN>
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

" USABILITY
nnoremap ; :

"" }
]])
-- -- MOVE: UP, DOWN
-- keymap('n', 'k', 'gk', opts)
-- keymap('n', 'n', 'gj', opts)
-- keymap('v', 'n', 'j', opts)
-- keymap('v', 'j', 'n', opts)
-- keymap('c', '<C-k>', '<Up>', opts)
-- keymap('c', '<C-n>', '<Down>', opts)
-- keymap('i', '<C-k>', '<C-o>gk', opts)
-- keymap('i', '<C-n>', '<C-o>gj', opts)
-- keymap('i', '<C-j>', '<C-n>', opts)
-- keymap('n', '<C-w>n', '<C-w>j', opts)
-- keymap('n', 'u', '{zz', opts)
-- keymap('n', 'e', '}zz', opts)
-- 
-- -- MOVE: LEFT, RIGHT
-- keymap({'i','c'}, '<C-l>', '<Right>', opts)
-- keymap('i', '<C-h>', '<Left>', opts)
-- keymap('i', '<C-e>', '<End>', opts)
-- keymap('i', '<C-u>', '<Esc>^i', opts)
-- keymap('c', '<C-u>', '<Home>', opts)
-- keymap('n', 'L', '$', opts)
-- keymap('n', 'H', '^', opts)
-- keymap('n', '<C-l>', 'A', opts)
-- keymap('v', '<C-h>', 'I', opts)
-- keymap('v', '<C-l>', '$A', opts)
-- keymap('i', '<C-b>', '<C-o>b', opts)
-- keymap('i', '<C-f>', '<C-o>w', opts)

-- Move lines up/down
keymap("n", "<A-n>", ":m .+1<CR>==",     { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==",     { desc = "Move line up" })
keymap("v", "<A-n>", ":m '>+1<CR>gv=gv", { desc = "Move Selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection up" })

keymap("n", "<", "V<gv")
keymap("n", ">", "V>gv")

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect"})
keymap("v", ">", ">gv", { desc = "Indent right and reselect"})

vim.opt.path:append("**")


keymap("n", "<Leader>m", function() print('a') end, { desc = "ii"})




