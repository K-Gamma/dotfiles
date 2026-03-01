return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.diagnostic.config {
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },
        virtual_text = false,
        virtual_lines = false,
        jump = { float = true },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = require('util.keymap').buf_map(event.buf, 'LSP')

          map('n', 'grn', vim.lsp.buf.rename, '名前変更 ([R]e[n]ame)')
          map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, 'コードアクション ([A]ction)')
          map('n', 'grD', vim.lsp.buf.declaration, '宣言へ移動 ([D]eclaration)')

          map('n', 'grr', function() Snacks.picker.lsp_references() end, '参照一覧 ([R]eferences)')
          map('n', 'gri', function() Snacks.picker.lsp_implementations() end, '実装へ移動 ([I]mplementation)')
          map('n', 'grd', function() Snacks.picker.lsp_definitions() end, '定義へ移動 ([D]efinition)')
          map('n', 'gO', function() Snacks.picker.lsp_symbols() end, 'ドキュメントシンボル')
          map('n', 'gW', function() Snacks.picker.lsp_workspace_symbols() end, 'ワークスペースシンボル ([W]orkspace)')
          map('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, '型定義へ移動 ([T]ype)')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map(
              'n',
              '<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              'インレイヒント切替 ([T]oggle [H]ints)'
            )
          end
        end,
      })

      local servers = {
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                }),
              },
            })
          end,
          settings = { Lua = {} },
        },
      }

      -- カスタム設定を上書き
      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
      end

      -- LSP サーバーのインストール + 自動有効化（automatic_enable = true がデフォルト）
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      -- 非 LSP ツール（フォーマッタ等）のインストール
      require('mason-tool-installer').setup { ensure_installed = { 'stylua' } }
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = 'フォーマット ([F]ormat)',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- バッファローカル → グローバルの順で autoformat 設定を確認
        if vim.b[bufnr].autoformat == false or (vim.b[bufnr].autoformat == nil and vim.g.autoformat == false) then return nil end
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
}
