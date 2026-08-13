

-- ここでテスト -> 設定ファイルに追加


-- JAPANESE WRITING (vip gq) or gp -> config.keymaps
vim.opt.textwidth  = 74
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
--
-- 例えば， `-   sample.txt` みたいな行の先頭では `gf` がファイルを開かない。

local function smart_gf()
    -- まずは通常の gf と同じ判定を試す
    -- その後 f(, f`, f" をしてから gf判定を試す
    -- 文字列が取得できたら `gf`

    local filename
    local cmd
    local patterns = {":", "f(", "f`", 'f"', "f " }

    for _, v in ipairs(patterns) do
        cmd = string.format("normal %s", v)
        -- print (cmd)
        vim.cmd(cmd)
        filename = vim.fn.expand("<cfile>")

        -- 見つかったら開く
        if filename ~= "" then
            if vim.fn.filereadable(filename) == 1 then
                vim.cmd.edit(vim.fn.fnameescape(filename))
                return
            end
        end
    end

    -- 通常エラー
    -- vim.notify("File not found", vim.log.levels.WARN)

    -- このスクリプトでは，
    -- lua Script の記法など，gf 出来るけど，出来ない判定に
    -- なる場合がある。最後は，強制的に gf して，見つからな
    -- ければ gf のエラーを出す
    vim.cmd("normal! gf")
end

vim.keymap.set("n", "gf", smart_gf)

-- (TODO.md)
-- ate `TODO.md`
-- ("`TODO.md`")
--    TODO.md
-- }}}

