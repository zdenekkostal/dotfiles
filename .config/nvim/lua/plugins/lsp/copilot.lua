-- Copilot.
-- Thank you https://github.com/MariaSolOs/dotfiles/blob/e9eb1f8e027840f872e69e00e082e2be10237499/.config/nvim/lua/plugins/copilot.lua
return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    opts = {
        -- I don't find the panel useful.
        panel = { enabled = false },
        suggestion = {
            enabled = false,
            -- auto_trigger = true,
            -- -- Use alt to interact with Copilot.
            -- keymap = {
            --     -- Disable the built-in mapping, we'll configure it in nvim-cmp.
            --     accept = false,
            --     accept_word = '<M-w>',
            --     accept_line = '<M-l>',
            --     next = '<M-]>',
            --     prev = '<M-[>',
            --     dismiss = '/',
            -- },
        },
        filetypes = { markdown = true },
    },
    config = function(_, opts)
        local cmp = require 'cmp'
        local copilot = require 'copilot.suggestion'
        local luasnip = require 'luasnip'

        require('copilot').setup(opts)

        local function set_trigger(trigger)
            vim.b.copilot_suggestion_auto_trigger = trigger
            vim.b.copilot_suggestion_hidden = not trigger
        end

        -- Hide suggestions when the completion menu is open.
        cmp.event:on('menu_opened', function()
            if copilot.is_visible() then
                copilot.dismiss()
            end
            set_trigger(false)
        end)

        -- Disable suggestions when inside a snippet.
        cmp.event:on('menu_closed', function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
        end)
        vim.api.nvim_create_autocmd('User', {
            pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
            callback = function()
                set_trigger(not luasnip.expand_or_locally_jumpable())
            end,
        })
    end,
}
