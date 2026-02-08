-- return {
--   'nvim-pack/nvim-spectre',
--   dependencies = {
--     {'nvim-lua/plenary.nvim'}
--   },
--   config = function()
--     vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
--         desc = "Toggle Spectre"
--     })
--     vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--         desc = "Search current word"
--     })
--     vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--         desc = "Search current word"
--     })
--     vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--         desc = "Search on current file"
--     })
--   end
-- }
return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup({
      -- options, see Configuration section below
      -- there are no required options atm
    });
  end,
  keys = {
    { "<leader>S", function() require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search and replace" },
    { "<leader>SA", function() require('grug-far').open({ engine = 'astgrep' }) end, desc = "Search and replace with AST engine" },
  },
}
