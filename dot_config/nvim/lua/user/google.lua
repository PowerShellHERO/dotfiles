--[[

　選択範囲(一行目のみ) か，現在行を google で検索。

chrome ダークモード

--]]


-- for comment
local noise = '[%s#/*<>;"%-!%%]'

-- ※ vivaldi
local chrome = "/mnt/c/Users/quiet/AppData/Local/Vivaldi/Application/vivaldi.exe"
-- local chrome = "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
local url_template = "https://www.google.com/search?q=%s"

-- RFC 3986 の unreserved 文字以外はすべて %XX にする（日本語・空白・& や # も安全）
local function url_encode(s)
    return (s:gsub("[^A-Za-z0-9%-._~]", function(c)
        return string.format("%%%02X", c:byte())
    end))
end


local function strip_comment(s)
    return (s:gsub("^" .. noise .. "+", ""))
    -- 後ろも取る version。……前だけでいいかな。
    -- return (s:gsub("^" .. noise .. "+", ""):gsub(noise .. "+$", ""))
end

-- table -> nil
local function google(lines)
    -- query check
    -- google cmd check

    -- get query and check
    local query = strip_comment(lines[1] or "") -- 複数行あっても 1 行目のみ
    if query == "" then
        vim.notify("Google: 検索文が空です", vim.log.levels.WARN)
        return
    end

    -- google cmd check
    if vim.fn.executable(chrome) ~= 1 then
        vim.notify("Google: chrome が見つかりません: " .. chrome, vim.log.levels.ERROR)
        return
    end

    -- set url
    local url = url_template:format(url_encode(query))

    -- then search
    pp(query)
    vim.system({ chrome, url }, { detach = true })
end

local function is_from_visual(opts)
    -- `:'<,'>Google`（ビジュアル選択から）か？
    -- 手打ちの `:3,5Google` を区別する
    return opts.range == 2
    and opts.line1 == vim.fn.line("'<")
    and opts.line2 == vim.fn.line("'>")
end

local function get_region()
    return vim.fn.getregion(
        vim.fn.getpos("'<"), vim.fn.getpos("'>"),
        { type = vim.fn.visualmode() }
    )
end

vim.api.nvim_create_user_command("Google", function(opts)
    local lines
    if is_from_visual(opts) then
        -- 選択範囲そのものを取る
        lines = get_region()
    else
        -- 範囲なしなら現在行
        lines = { vim.api.nvim_get_current_line() }
    end
    google(lines)
end, { range = true, desc = "現在行 / ビジュアル選択を Google 検索" })


-- キーマップ。<Cmd> ではなく ":" を使う
vim.keymap.set({ "n", "x" }, "<leader>sa", ":Google<CR>", { silent = true })


