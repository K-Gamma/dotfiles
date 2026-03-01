return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'セッション復元 ([S]ession)' },
      { '<leader>qS', function() require('persistence').select() end, desc = 'セッション選択 ([S]elect)' },
      { '<leader>ql', function() require('persistence').load { last = true } end, desc = '最後のセッション復元 ([L]ast)' },
      { '<leader>qd', function() require('persistence').stop() end, desc = "セッション保存停止 ([D]on't save)" },
    },
  },
}
