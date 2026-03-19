---- require 'telescope'

---- directory を登録，Key は :Findfiles <args> で補完可能になる
local pathdir = {
  ---- lsp = '~/.config/nvim/lua/plugins/lsp',
  o   = '~/.config/nvim/lua/',
  dot = '~/.local/share/chezmoi',
  current_dir = '',
}

local make_changedir_cmd = function(path)
  ---- ":cd " は ":cd %:h" と同じ。path が 'current_dir' ならこれを返す
  local path = vim.fn.trim(path)
  return ("cd " .. pathdir[path])
end

local M = {}

M.findfiles = function(path)
  local cd = make_changedir_cmd(path)

  ---- print(cd)
  vim.cmd(cd)
  vim.cmd("Telescope find_files")
end

M.setup = function()
  vim.api.nvim_create_user_command(
    "Findfiles",
    function(opts)
      ---- 引数を省略した場合は 'current_dir' になる
      local path = opts.args ~= '' and opts.args or 'current_dir'
      M.findfiles(path)
    end,
    { 
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
      end
    }
  )

  vim.cmd("cabbr ff  <ESC>:Findfiles")
  vim.cmd("cabbr ffo  <ESC>:Findfiles o")

  -- この好みの問題でこの書き方はしない
  -- <cmd> で始める場合は<CR> が必要になる。

  -- vim.cmd("cabbr fu <cmd>Findfiles user<CR>")
end

M.setup()

return M

