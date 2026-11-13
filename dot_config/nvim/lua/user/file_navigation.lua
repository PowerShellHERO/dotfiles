---- require 'telescope'

---- directory を登録，Key は :Findfiles <args> で補完可能になる
local pathdir = {
    ---- lsp = '~/.config/nvim/lua/plugins/lsp',
    o = '~/.config/nvim/lua/',
    dot = '~/.local/share/chezmoi',
    cheatsheet = '~/tes/TeckStack/nvim/cheatsheet',
    current_dir = '',
}

local make_changedir_cmd = function(path)
    local path = path or vim.fn.trim(path)
    return ('cd ' .. pathdir[path])
end

local M = {}

M.findfiles = function(path)
    if path ~= 'current_dir' then
        local cd = make_changedir_cmd(path)
        vim.cmd(cd)
    end
    vim.cmd('Telescope find_files')
end

M.setup = function()
    vim.api.nvim_create_user_command('Findfiles', function(opts)
        ---- 引数を省略した場合は 'current_dir' になる
        local path = opts.args ~= '' and opts.args or 'current_dir'
        M.findfiles(path)
    end, {
        nargs = '?',
        complete = function(arg_lead, cmd_line, cursor_pos)
            -- pathdir から Value が '' でない key を保管リストに追加
            local comp = {}
            for key, val in pairs(pathdir) do
                if not (val == '') then
                    table.insert(comp, key)
                end
            end
            return comp
        end,
    })

    vim.cmd('cabbr ff   <ESC>:Findfiles')
    vim.cmd('cabbr ffo  <ESC>:Findfiles o')
    vim.cmd('cabbr ffc  <ESC>:Findfiles cheatsheet')

    -- この好みの問題でこの書き方はしない
    -- <cmd> で始める場合は<CR> が必要になる。

    -- vim.cmd("cabbr fu <cmd>Findfiles user<CR>")
end

M.setup()

return M
