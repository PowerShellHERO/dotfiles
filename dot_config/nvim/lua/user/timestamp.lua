
-- require('user.timestamp')

-- timestamp
local function has_header1()
    -- buf
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local has_h1 = false
    for _, line in ipairs(lines) do
        if line:match("^# .+") then
            has_h1 = true
            break
        end
    end
    return has_h1
end


local function make_timestamp(has_h1, date, time)
    -- Timestamp を作成
    local timestamp
    if not has_h1 then
        timestamp = {
            "", "", date, "", time, "", "",
        }
    else
        timestamp = {
            "", "", time, "", "",
        }
    end
    return timestamp
end

--
vim.api.nvim_create_user_command('Timestamp', function()
    local has_h1 = has_header1()
    local datetime = vim.split(os.date("%Y-%m-%d %H:%M"), ' ')
    local date  = "# "  .. datetime[1]
    local time  = "## " .. datetime[2]
    -- pp(date)
    -- pp(time)

    local timestamp = make_timestamp(has_h1, date, time)

    -- 引数は
    -- 現在の buffer (0)
    -- 末尾に追加 (-1, -1)
    -- 範囲外でエラー, false
    -- 置き換えるテキスト（行ごと）のリスト stamp
    vim.api.nvim_buf_set_lines(0, -1, -1, false, timestamp)

    -- buffer 内の余計な空行を削除 (3連続以上)
    --- vim.cmd([[<Cmd>%s/^\n\{3,}/\r\r/g<CR>]])
    vim.cmd[[%s/^\n\{3,}/\r\r/ge]]
    vim.cmd([[normal! Gzz]])

end, {})

vim.keymap.set('n', '<leader>8', '<Cmd>Timestamp<CR>')

