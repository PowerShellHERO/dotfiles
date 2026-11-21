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
require('user.cabbr_expansion')

-- abbreviations {{{

local cmd_aliases = {
    meta = 'Meta',
    memo = 'Memo',
    ask  = 'Ask',
    add  = '!chezmoi add %',
    ya   = '%y',
    grep = 'Telescope live_grep',
    nof  = 'Telescope oldfiles',
    cdp  = 'cd %:p:h',
}

local search_aliases = {
  t = 'TODO',
  f = [[function\|def\>]],
  h = '^## ',
}

-- set
_G.set_cmd_alias(cmd_aliases)
_G.set_search_alias(search_aliases)


-- }}}
--
