--[[

  Linux Ubuntu

require("user.ime").setup()

戻り値を null にリダイレクトしないと，何故か buffer に
幽霊文字が出力されるし，表示が崩れる。
local on_cmd  = spzenhan_path .. " 1 " .. " 2>&1 >/dev/null"

応急処置は完了しているが，問題は起こるかも。

あと，戻り値が取得できないからか，IME の状態は復元できない。
必要なら <F6> などで日本語/英語モードを toggle させる関数を作る。

解決策？
vim.api.nvim_command('silent !~/bin/spzenhan.exe 1')
vim.api.nvim_command('silent !~/bin/spzenhan.exe 0')

--]]

local spzenhan_path = "~/bin/spzenhan.exe"
local on_cmd  = spzenhan_path .. " 1" .. " 2>&1 >/dev/null"
local off_cmd = spzenhan_path .. " 0" .. " 2>&1 >/dev/null"

local M = {}

-- insert mode: true なら InsertMode に入るとき，前回の状態を復元する
M.iminsert = true
-- 以前の IME の状態
M.previous_ime_state = 0

M.toggle_iminsert = function()
  M.iminsert = (not M.iminsert)
  local state = M.iminsert and "ON" or "OFF"
  print("now iminser is: " .. state)
end

M.ime_on = function()
  -- IME を on にする
  return os.execute(on_cmd)
end

M.ime_off = function()
  -- IME を off にする
  return os.execute(off_cmd)
end

M.insert_leave = function()
   M.previous_ime_state = M.ime_off()
end

M.insert_enter = function()
  -- autocmd InsertEnter 用

  -- InsertMode に入るとき，iminsert が true なら以前の状態を復元
  if M.iminsert and (M.previous_ime_state == 1) then
    M.ime_on()
  else
    M.ime_off()
  end
end

local ins = function()
   M.previous_ime_state = M.ime_off()
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

return M

