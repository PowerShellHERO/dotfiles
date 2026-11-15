-- config.scratch

--[[

    ----------------------
   --                  --
  --   nvim ubuntu    --
 --                  --
----------------------

-- netrw
    -- d, new dir
    -- %, new file

--]]

function pp(v)
    print(vim.inspect(v))
end -- pretty print table

require('config.options')
require('config.keymaps')
require('config.scratch')
require('config.lazy')

-- users
require('config.wsl')
require('user.file_navigation').setup()
require('user.timestamp')

-- abbreviations {{{

vim.cmd([[
" iabbr nvim Neovim
cabbr add !chezmoi add %
cabbr ya %y
cabbr grep <Cmd>Telescope live_grep<CR>
" :Telescope oldfiles'
cabbr nof <Cmd>Telescope oldfiles<CR>
" :cd this directory
cabbr cdp <Cmd>cd %:p:h<CR>
]])

-- }}}
--
