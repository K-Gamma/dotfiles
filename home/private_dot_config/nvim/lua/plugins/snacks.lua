return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      picker = {},
      explorer = {},
    },
    keys = {
      -- picker
      { '<leader>sh', function() Snacks.picker.help() end,                              desc = '[S]earch [H]elp' },
      { '<leader>sk', function() Snacks.picker.keymaps() end,                           desc = '[S]earch [K]eymaps' },
      { '<leader>sf', function() Snacks.picker.files() end,                             desc = '[S]earch [F]iles' },
      { '<leader>ss', function() Snacks.picker.pickers() end,                           desc = '[S]earch [S]elect Picker' },
      { '<leader>sw', function() Snacks.picker.grep_word() end,                         desc = '[S]earch current [W]ord', mode = { 'n', 'v' } },
      { '<leader>sg', function() Snacks.picker.grep() end,                              desc = '[S]earch by [G]rep' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end,                       desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', function() Snacks.picker.resume() end,                            desc = '[S]earch [R]esume' },
      { '<leader>s.', function() Snacks.picker.recent() end,                            desc = '[S]earch Recent Files' },
      { '<leader>sc', function() Snacks.picker.commands() end,                          desc = '[S]earch [C]ommands' },
      { '<leader><leader>', function() Snacks.picker.buffers() end,                     desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end,                              desc = '[/] Search in current buffer' },
      { '<leader>s/', function() Snacks.picker.grep({ buf = true }) end,                desc = '[S]earch [/] in Open Files' },
      { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath 'config' }) end, desc = '[S]earch [N]eovim files' },

      -- explorer
      { '<leader>e', function() Snacks.explorer() end, desc = 'File [E]xplorer' },
    },
  },
}
