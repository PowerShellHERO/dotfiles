-- config.scratch

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
require('config.scratch')
require('config.lazy')

-- users
require('user.file_navigation').setup()
-- Comment out if not needed.
require('config.wsl')


-- abbreviations {{{

vim.cmd([[
" iabbr nvim Neovim
cabbr add !chezmoi add %
cabbr ya %y
cabbr grep <Cmd>Telescope live_grep<CR>
]])

-- }}}

