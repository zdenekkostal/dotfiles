return {
  'isakbm/gitgraph.nvim',
  dependencies = { 'sindrets/diffview.nvim' },
  opts = {
    hooks = {
      on_select_commit = function(commit)
        vim.cmd('DiffviewOpen ' .. commit.hash .. '^!')
      end,
      on_select_range_commit = function(from, to)
        vim.cmd('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
      end,
    },
    symbols = {
      merge_commit = '',
      commit = '',
      merge_commit_end = '',
      commit_end = '',
      GVER = '',
      GHOR = '',
      GCLD = '',
      GCRD = '',
      GCLU = '',
      GCRU = '',
      GLRU = '',
      GLRD = '',
      GLUD = '',
      GRUD = '',
      GFORKU = '',
      GFORKD = '',
      GRUDCD = '',
      GRUDCU = '',
      GLUDCD = '',
      GLUDCU = '',
      GLRDCL = '',
      GLRDCR = '',
      GLRUCL = '',
      GLRUCR = '',
    },
  },
  keys = {
    {
      '<leader>gl',
      function()
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end,
      desc = '[g]it [l]og graph',
    },
  },
}
