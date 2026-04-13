local function get_default_branch_name()
  local res = vim.system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true }):wait()
  return res.code == 0 and 'main' or 'master'
end

return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    -- Shallow diffing (working directory changes)
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[g]it [d]iff repo' },
    { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = '[g]it [D]iff close' },

    -- Deep diffing (history)
    { '<leader>ghh', '<cmd>DiffviewFileHistory<cr>', desc = '[g]it [h]istory repo' },
    { '<leader>ghf', '<cmd>DiffviewFileHistory --follow %<cr>', desc = '[g]it [h]istory [f]ile' },
    { '<leader>ghl', '<cmd>.DiffviewFileHistory --follow<cr>', desc = '[g]it [h]istory [l]ine' },
    { '<leader>ghl', "<esc><cmd>'<,'>DiffviewFileHistory --follow<cr>", mode = 'v', desc = '[g]it [h]istory [l]ines' },

    -- Diff against default branch
    {
      '<leader>ghm',
      function()
        vim.cmd('DiffviewOpen ' .. get_default_branch_name())
      end,
      desc = '[g]it [h]istory vs [m]ain',
    },
    {
      '<leader>ghr',
      function()
        vim.cmd('DiffviewOpen origin/' .. get_default_branch_name())
      end,
      desc = '[g]it [h]istory vs [r]emote main',
    },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
  },
  config = function(_, opts)
    local actions = require('diffview.actions')

    opts.keymaps = {
      view = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', '<leader>co', actions.conflict_choose('ours'), { desc = '[c]onflict choose [o]urs' } },
        { 'n', '<leader>ct', actions.conflict_choose('theirs'), { desc = '[c]onflict choose [t]heirs' } },
        { 'n', '<leader>cb', actions.conflict_choose('base'), { desc = '[c]onflict choose [b]ase' } },
        { 'n', '<leader>ca', actions.conflict_choose('all'), { desc = '[c]onflict choose [a]ll' } },
        { 'n', '<leader>cO', actions.conflict_choose_all('ours'), { desc = '[c]onflict all [O]urs' } },
        { 'n', '<leader>cT', actions.conflict_choose_all('theirs'), { desc = '[c]onflict all [T]heirs' } },
        { 'n', '<leader>cB', actions.conflict_choose_all('base'), { desc = '[c]onflict all [B]ase' } },
        { 'n', '<leader>cA', actions.conflict_choose_all('all'), { desc = '[c]onflict all [A]ll' } },
      },
      file_panel = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', 's', actions.toggle_stage_entry, { desc = '[s]tage/unstage entry' } },
        { 'n', 'S', actions.stage_all, { desc = '[S]tage all' } },
        { 'n', 'U', actions.unstage_all, { desc = '[U]nstage all' } },
        { 'n', 'X', actions.restore_entry, { desc = 'Restore entry' } },
        { 'n', 'R', actions.refresh_files, { desc = '[R]efresh' } },
        { 'n', '<cr>', actions.goto_file_edit, { desc = 'Open file' } },
        { 'n', 'o', actions.goto_file_edit, { desc = 'Open file' } },
        { 'n', '<c-o>', actions.goto_file_split, { desc = 'Open in split' } },
        { 'n', '<c-t>', actions.goto_file_tab, { desc = 'Open in tab' } },
        {
          'n',
          '<leader>cF',
          function()
            local view = require('diffview.lib').get_current_view()
            if not view then
              vim.notify('No diffview open', vim.log.levels.WARN)
              return
            end

            local file = view.panel.cur_file
            if not file then
              vim.notify('No file selected', vim.log.levels.WARN)
              return
            end

            local file_path = file.path
            local left_commit = view.left.commit or 'HEAD'
            local right_commit = view.right.commit

            local cmd
            if right_commit then
              cmd = string.format(
                "GIT_EXTERNAL_DIFF='difft --display side-by-side-show-both' git diff %s:%s %s:%s",
                left_commit,
                file_path,
                right_commit,
                file_path
              )
            else
              cmd = string.format(
                "GIT_EXTERNAL_DIFF='difft --display side-by-side-show-both' git diff %s -- %s",
                left_commit,
                file_path
              )
            end

            local popup_buf = vim.api.nvim_create_buf(false, true)
            local width = vim.o.columns - 6
            local height = vim.o.lines - 6
            local win_opts = {
              focusable = true,
              style = 'minimal',
              border = 'rounded',
              relative = 'editor',
              width = width,
              height = height,
              row = 3,
              col = 3,
              noautocmd = true,
            }
            vim.api.nvim_open_win(popup_buf, true, win_opts)
            vim.fn.termopen(cmd)
            vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = popup_buf, nowait = true })
            vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = popup_buf, nowait = true })
          end,
          { desc = 'Diff with difftastic' },
        },
      },
      file_history_panel = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', '<cr>', actions.goto_file_edit, { desc = 'Open file' } },
        { 'n', 'o', actions.goto_file_edit, { desc = 'Open file' } },
        { 'n', 'y', actions.copy_hash, { desc = 'Copy commit hash' } },
        { 'n', 'zR', actions.open_all_folds, { desc = 'Open all folds' } },
        { 'n', 'zM', actions.close_all_folds, { desc = 'Close all folds' } },
      },
    }

    require('diffview').setup(opts)
  end,
}
