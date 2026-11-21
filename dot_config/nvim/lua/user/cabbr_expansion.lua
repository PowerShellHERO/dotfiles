
--[[ usage

-- require('user.cabbr_expansion')

-- buffer local の abbr が global より優先されるため上書き可能
-- まぁ M.set_alias とかを提供した方がいいとは思う

local cmd_aliases = {
    memo = 'Memo',
    ask  = 'Ask'
}

local search_aliases = {
  t = 'TODO',
  h = '^## ',
}

_G.set_cmd_alias(cmd_aliases)
_G.set_search_alias(search_aliases)

--]]

local function cabbrev(lhs, rhs)
    vim.keymap.set('ca', lhs, function()
        if vim.fn.getcmdtype() == ':'
            and vim.fn.getcmdline():match([[^%s*[%d%.,;%$%%'<>%+%-]*%s*]] .. vim.pesc(lhs) .. '$') then
            return rhs
        end
        return lhs
    end, { expr = true })
end

-- Search に応用
local function cabbrev_search(lhs, rhs)
    vim.keymap.set('ca', lhs, function()
        local t = vim.fn.getcmdtype()
        local in_search = (t == '/') or (t == '?')
        local is_match  = vim.fn.getcmdline() == lhs
        -- search mode, かつ，コマンドライン全体が lhs と一致
        if in_search and is_match then
            return rhs
        end
        return lhs
    end, { expr = true })
end


-- main
local function set_search_alias(t)
    for k, v in pairs(t) do
        cabbrev_search(k, v)
    end
end

local function set_cmd_alias(t)
    for k, v in pairs(t) do
        cabbrev(k, v)
    end
end


-- ftplugin かどこかから呼んで設定。
_G.set_cmd_alias    = set_cmd_alias
_G.set_search_alias = set_search_alias
