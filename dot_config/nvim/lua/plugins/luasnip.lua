--[[

　Keybind は Blink.cmp に全て吸われる。向うで設定するのが慣習。

--]]

return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    event = 'VeryLazy',

    config = function()
        -- -- set keybinds for both INSERT and VISUAL.
        -- local ls = require("luasnip")

        -- -- vim.keymap.set({"i", "s"}, "<C-I>", function() ls.expand_or_jump() end, {silent = true})
        -- vim.keymap.set({"i", "s"}, "<C-I>", function()
        --   if ls.expand_or_jumpable() then
        --     ls.expand_or_jump()
        --   else
        --     -- 通常の Tab を入力（インデント等）
        --     vim.api.nvim_feedkeys(
        --       vim.api.nvim_replace_termcodes("<C-I>", true, false, true),
        --       "n",
        --       false
        --     )
        --   end
        -- end, { silent = true, expr = false })

        -- vim.keymap.set({"i", "s"}, "<C-S-I>", function() ls.jump(-1) end, {silent = true})
        -- vim.keymap.set({"i", "s"}, "<C-O>", function()
        --     -- スニペット編集を強制終了
        --     ls.unlink_current()
        --     -- ノーマルモードに移行！
        --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        -- end)

        -- vim.keymap.set({"s"}, "<C-u>", function()
        --     -- スニペット編集を強制終了
        --     ls.unlink_current()
        --     -- ノーマルモードに移行！
        --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>:undo<ESC>", true, false, true), "n", true)
        -- end)

        -- vim.keymap.set({"i", "s"}, "<C-L>", function()
        --     if ls.jumpable( 1) then
        --         ls.jump( 1)
        --     else
        --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<RIGHT>", true, false, true), "n", true)
        --     end
        -- end, {silent = true})
    end
}

