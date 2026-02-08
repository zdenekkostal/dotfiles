return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    { '<leader>dvo', '<cmd>DiffviewOpen<cr>', desc = 'DiffviewOpen' },
    { '<leader>dvc', '<cmd>DiffviewClose<cr>', desc = 'DiffviewClose' },
    { '<leader>dvh', '<cmd>DiffviewFileHistory %<cr>', desc = 'DiffviewFileHistory' },
  },
  opts = {
    enhanced_diff_hl = false,
    use_icons = true,
  },
  config = function(_, opts)
    opts.keymaps = {
      file_panel = {
        { 'n', '<leader>cF', function()
          local view = require('diffview.lib').get_current_view()
          if not view then
            vim.notify("No diffview open", vim.log.levels.WARN)
            return
          end

          local file = view.panel.cur_file  -- Changed from cur_file() to cur_file
          if not file then
            vim.notify("No file selected", vim.log.levels.WARN)
            return
          end

          local file_path = file.path
          local left_commit = view.left.commit or "HEAD"
          local right_commit = view.right.commit
          
          -- Build the git diff command
          local cmd
          if right_commit then
            -- Comparing two commits
            cmd = string.format(
              "GIT_EXTERNAL_DIFF='difft --display side-by-side-show-both' git diff %s:%s %s:%s",
              left_commit, file_path, right_commit, file_path
            )
          else
            -- Comparing commit with working directory
            cmd = string.format(
              "GIT_EXTERNAL_DIFF='difft --display side-by-side-show-both' git diff %s -- %s",
              left_commit, file_path
            )
          end

          -- Create floating window
          local popup_buf = vim.api.nvim_create_buf(false, true)
          local width = vim.o.columns - 6
          local height = vim.o.lines - 6
          local win_opts = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            relative = "editor",
            width = width,
            height = height,
            row = 3,
            col = 3,
            noautocmd = true,
          }
          local popup_win = vim.api.nvim_open_win(popup_buf, true, win_opts)

          vim.fn.termopen(cmd)
          
          -- Add keymap to close the popup
          vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = popup_buf, nowait = true })
          vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = popup_buf, nowait = true })
        end, { desc = "Diff with difftastic" } },
      },
    }
    
    require('diffview').setup(opts)
  end,
}
