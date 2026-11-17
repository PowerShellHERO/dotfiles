
require('user.ime2')

-- req:
-- WLSg (terminal)
-- brew install wl-clipboard
vim.opt["clipboard"] = "unnamedplus"


-- [TODO] folder を wsl に移動
-- [TODO] このファイルは wsl/init.lua でもいい。
-- [TODO] user.ime2 を wsl/ime2.lua に
-- [TODO] wsl/clip.lua を作成 `YANK {..` 以下を移す

-- if not os.getenv("WSL_DISTRO_NAME") then
--     return {}
-- end

