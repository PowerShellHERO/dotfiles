
--[[

  Linux Ubuntu

require("user.ime2").setup()

:ime<Tab>
:ImeToggleIminsert で 日本語/英語モードを toggle

os.execute() だと表示変になる。vim.fn.system() を使う。
ただし，改行記号などが付与されるため，Triming が必要。

--]]

local spzenhan_path = "~/bin/spzenhan.exe"

local M = {}

-- insert mode: true なら InsertMode に入るとき，前回の状態を復元する
M.iminsert = true
-- 以前の IME の状態
M.previous_ime_state = '0'

M.toggle_iminsert = function()
  M.iminsert = (not M.iminsert)
  local state = M.iminsert and "ON" or "OFF"
  print("now ime_auto is: " .. state)
end

M.ime_on = function()
  -- IME を on にする
  local state = vim.fn.system('~/bin/spzenhan.exe 1')
  return state:sub(1,1)
end

M.ime_off = function()
  -- IME を off にする
  local state = vim.fn.system('~/bin/spzenhan.exe 0')
  return state:sub(1,1)
end

M.insert_leave = function()
   M.previous_ime_state = M.ime_off()
end

M.insert_enter = function()
  -- autocmd InsertEnter 用

  -- InsertMode に入るとき，iminsert が true なら以前の状態を復元
  if M.iminsert and (M.previous_ime_state == '1') then
    M.ime_on()
  else
    M.ime_off()
  end
end

M.setup = function()
  -- autocmd グループを作成
  local group = vim.api.nvim_create_augroup("IMEControl", { clear = true })

  -- InsertLeave イベント
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = M.insert_leave,
  })

  -- CmdlineLeave 検索からの帰還時など
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = group,
    callback = M.insert_leave,
  })

  -- Telescope buffer などからの帰還時
  vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    callback = M.insert_leave,
  })

  -- Telescope buffer などからの帰還時
  vim.api.nvim_create_autocmd("BufLeave", {
    group = group,
    callback = M.insert_leave,
  })

  -- InsertEnter イベント
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = M.insert_enter,
  })


  -- <F1> で iminsert を toggle
  vim.api.nvim_create_user_command("ImeToggleIminsert", function()
    M.toggle_iminsert()
  end,{})

  -- keybind
  vim.keymap.set('n', '<c-1>', '<cmd>:ImeToggleIminsert<CR>', { silent = true })

  -- print("IME Control plugin loaded!")
end

-- M.setup()

-- M.ime_on()
-- print(M.previous_ime_state)
-- M.insert_leave()
-- print(M.previous_ime_state)
-- M.insert_enter()
-- print(M.previous_ime_state)
--
-- Shoul be: 0, 1, 1

return M

