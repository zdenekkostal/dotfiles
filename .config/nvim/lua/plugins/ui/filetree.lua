return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    {'kyazdani42/nvim-web-devicons', opt = true},
  },
  keys = {
    { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
    { "<leader>nf", "<cmd>NvimTreeFindFile<cr>", desc = "NvimTreeFindFile" },
  },
  config = function()
    require'nvim-tree'.setup({
      -- filters = {
      --   custom = {'.git'}
      -- }
    })
  end
}
