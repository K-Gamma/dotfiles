return {
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local parsers = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'yaml',
      }
      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end
          if not vim.treesitter.language.add(language) then
            local ts = require 'nvim-treesitter'
            if vim.tbl_contains(ts.get_available(), language) then ts.install { language } end
            return
          end
          vim.treesitter.start(buf, language)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    config = function()
      local TS = require 'nvim-treesitter-textobjects'
      if not TS.setup then return end

      TS.setup {
        move = { enable = true, set_jumps = true },
      }

      local moves = {
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
      }

      local descs = { ['function'] = '関数', class = 'クラス', parameter = '引数' }

      local function attach(buf)
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if not lang then return end
        local ok, query = pcall(vim.treesitter.query.get, lang, 'textobjects')
        if not ok or not query then return end

        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local obj = query:gsub('@', ''):gsub('%..*', '')
            local dir = key:sub(1, 1) == '[' and '前の' or '次の'
            local pos = key:sub(2, 2) == key:sub(2, 2):upper() and '末尾' or '先頭'
            vim.keymap.set({ 'n', 'x', 'o' }, key, function()
              -- diff モードでは ]c/[c をデフォルト動作（diff ナビゲーション）に委譲
              if vim.wo.diff and key:find '[cC]' then return vim.cmd('normal! ' .. key) end
              require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
            end, { buffer = buf, desc = dir .. (descs[obj] or obj) .. 'の' .. pos, silent = true })
          end
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_textobjects', { clear = true }),
        callback = function(ev) attach(ev.buf) end,
      })
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then attach(buf) end
      end
    end,
  },
}
