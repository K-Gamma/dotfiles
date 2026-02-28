return {
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewFileHistory',
    },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>',            desc = '[G]it [D]iff View' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>',   desc = '[G]it File [H]istory (current)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<CR>',     desc = '[G]it File [H]istory (repo)' },
      { '<leader>gc', '<cmd>DiffviewClose<CR>',           desc = '[G]it Diff [C]lose' },
    },
  },
}
