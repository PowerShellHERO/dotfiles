-- ここでテスト -> 設定ファイルに追加

-- JAPANESE WRITING (vip gq) or gp -> config.keymaps
vim.opt.textwidth = 74
vim.opt.formatexpr = 'autofmt#japanese#formatexpr()'
vim.opt.formatoptions:append('mB') -- single byte 文字の行連結で空白を足す
-- vim.opt.wrap = true

vim.keymap.set('n', '<leader>i', 'gg=G<C-o>', { desc = 'Re-Indent buffer' })

vim.opt.wildmode = 'noselect'
vim.api.nvim_create_autocmd('CmdlineChanged', {
    pattern = ':',
    callback = function()
        vim.fn.wildtrigger()
    end,
})

-- Find -> Recursive fuzzy
function _G.my_find(text, _)
    local files = vim.fn.glob("**/*", true, true)

    return vim.fn.matchfuzzy(files, text)
end
vim.opt.findfunc = "v:lua.my_find"

-- Set Search Pattern
vim.keymap.set('n', '<C-i>', function()
    local ft = vim.bo.filetype
    local pattern = ''

    if ft == 'lua' then
        -- Lua: require('...') の中身を選択
        pattern = [[\v^require\('\zs.*\ze'\)]]
    elseif ft == 'zsh' then
        pattern = [[\v^zsh_add_file \zs.*\ze]]
    else
        -- markdownlink URL
        pattern = [[\v\]\(\zs.*\ze\)]]
    end

    -- 検索レジスタ（/）にパターンをセット
    vim.fn.setreg('/', pattern)
    -- 次の検索結果へ
    vim.cmd('normal! n')

    print('Set Search pattern for' .. ft)
end, { desc = 'Set search pattern based on filetype' })

-- Issue: <C-w> をシステムが定義しているため消せない。
-- やりたいこと: Windows 移動を <C-w> だけで簡潔させる。
-- vim.keymap.set('n', '<C-w>', '<Nop>')
-- vim.keymap.set("n", "<C-w>", "<Cmd>wincmd w<CR>")

-- Issue: Google IME の入力が消えずに残る。
-- 次に表示がバグったら <Esc><Esc> に :redraw を足す。
-- でも :redraw じゃ消えない。

-- smart_gf {{{
-- テキスト内にファイル名を表現する時，かならず (), ` `, "" で囲む。
-- `gf` を少し拡張すれば，filejump 可能

local function smart_gf()
    -- まずは通常の gf と同じ判定を試す
    -- その後 f(, f`, f" をしてから gf を試す
    -- バッファが変わってたら終了

    local cmd
    local move_patterns = { ':', 'f(', 'f`', 'f"', 'f ' }

    local bufname = vim.api.nvim_buf_get_name(0)

    for _, v in ipairs(move_patterns) do
        -- 次の記号 (, `, ", \s に移動して gf
        cmd = string.format('silent! normal! %sgf', v)
        -- print (cmd)
        vim.cmd(cmd)

        -- バッファが変わってたら終了
        if bufname ~= vim.api.nvim_buf_get_name(0) then
            return
        end
    end

    vim.notify('File not found', vim.log.levels.WARN)
end

vim.keymap.set('n', 'gf', smart_gf)

-- }}}

-- edit after ftplugin

vim.api.nvim_create_user_command('EditAfterFtplugin', function()
    -- Get the buffer's filetype: vim.bo.filetype
    -- Get the Config's Path: vim.fn.stdpath("config")

    local ft = vim.bo.filetype

    if ft == '' then
        vim.notify('filetype が設定されていません', vim.log.levels.WARN)
        return
    end

    local path = vim.fs.joinpath(vim.fn.stdpath('config'), 'after', 'ftplugin', ft .. '.lua')

    vim.cmd.edit(vim.fn.fnameescape(path))
end, {})

vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format)

-- git blame
-- --  現在行の Git blame（作者と日時まで）を簡易表示
vim.api.nvim_create_user_command('Blame', function()
  -- 現在の行番号とファイルパスを取得
  local line = vim.fn.line('.')
  local file = vim.fn.expand('%')

  -- git blame コマンドを実行して結果を取得
  local cmd = string.format('git blame -L %d,%d %s', line, line, vim.fn.shellescape(file))
  local result = vim.fn.system(cmd)

  -- エラー時やGit管理外のファイルの場合はそのまま表示して終了
  if vim.v.shell_error ~= 0 or result == '' then
    print(result)
    return
  end

  -- ')' の位置を探して、それ以降（コード本文）をカットする
  local paren_pos = string.find(result, '%)')
  if paren_pos then
    result = string.sub(result, 1, paren_pos)
  end

  -- 改行コードを取り除いて表示
  print(vim.trim(result))
end, {})

-- list
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(args)
        vim.keymap.set("i", "<Space>", function()
            -- カーソルより左の文字列を取得
            local before = vim.api.nvim_get_current_line():sub(1, vim.fn.col(".") - 1)
            local bullet = "*   "

            -- 行頭，またはタブだけが続いている -> リスト開始
            if before:match("^\t*$") then
                return bullet
            end

            -- リスト (bullet) の直後 -> インデント増
            if before:match("^\t*%*   $") then
                print("a")
                return "<C-w>\t" .. bullet
                -- return "<Cmd>normal! >>A<CR>" -- 着地位置が変なのでダメ
                -- return "<BS><BS><BS><BS><Tab>" .. bullet
            end

            return " "
        end, { buffer = args.buf, expr = true, desc = "space で bullet 挿入" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(args)
        -- <C-h>
        vim.keymap.set("i", "<C-w>", function()
            -- カーソルより左の文字列を取得
            local before = vim.api.nvim_get_current_line():sub(1, vim.fn.col(".") - 1)
            local bullet = "*   "

            -- インデントされたリスト -> インデント減
            if before:match("^\t+%*   $") then
                return "<C-w><BS>" .. bullet
                -- return "<Cmd>normal! <<<CR>" -- カーソル位置がやっぱり変
            end

            return "<C-w>"
        end, { buffer = args.buf, expr = true, desc = "space で bullet 挿入" })
    end,
})

