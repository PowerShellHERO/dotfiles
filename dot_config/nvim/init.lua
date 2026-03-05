
    ----------------------
   --                  --
  --   nvim ubuntu    --
 --                  --
----------------------

-- netrw
    -- d, new dir
    -- %, new file

function pp(v) print(vim.inspect(v)) end -- pretty print table

require('config.options')
require('config.keymaps')
-- require("user.ime").setup()
require("user.ime2").setup()

-- YANK {{{
local group = vim.api.nvim_create_augroup("Yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    local yanked = vim.fn.getreg('"')
    vim.fn.system("~/bin/clip.exe", yanked)
  end,
})
-- }}}

-- abbreviations
vim.cmd([[
" iabbr nvim Neovim
" cabbr add !chezmoi add %
]])

