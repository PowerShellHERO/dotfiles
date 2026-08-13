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
require('config.wsl')

require('config.lazy')

require('user.ime2')
require('user.file_navigation').setup()

-- abbreviations {{{

vim.cmd([[
" iabbr nvim Neovim
cabbr add !chezmoi add %
cabbr ya %y
]])

-- }}}

