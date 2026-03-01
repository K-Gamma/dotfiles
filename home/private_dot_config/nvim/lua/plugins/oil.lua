return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      { '-', function() require('oil').open() end, desc = '親ディレクトリを開く' },
    },
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
