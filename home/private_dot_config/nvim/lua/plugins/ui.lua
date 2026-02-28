return {
  { 'NMAC427/guess-indent.nvim', opts = {} },

  { 'brenoprata10/nvim-highlight-colors', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local map = function(mode, keys, func, desc) vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'Git: ' .. desc }) end

        -- hunk navigation
        map('n', ']h', function() gs.nav_hunk('next') end, 'Next Hunk')
        map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev Hunk')

        -- hunk 操作
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'Reset Hunk')
        map('n', '<leader>hu', gs.stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame Line')
      end,
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it' },
        { 'gr',        group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
