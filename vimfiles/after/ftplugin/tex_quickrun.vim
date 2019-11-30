" LaTeX Quickrun
let g:quickrun_config = {
            \ 'tex': {
            \   'command': 'latexmk',
            \   'outputter': 'error',
            \   'outputter/error/success': 'null',
            \   'outputter/error/error': 'quickfix',
            \   'srcfile': expand("%"),
            \   'cmdopt': '-pdfdvi',
            \   'hook/sweep/files': [
            \                        '%S:p:r.aux',
            \                        '%S:p:r.bbl',
            \                        '%S:p:r.blg',
            \                        '%S:p:r.dvi',
            \                        '%S:p:r.fdb_latexmk',
            \                        '%S:p:r.fls',
            \                        '%S:p:r.log',
            \                        '%S:p:r.out',
            \                        ],
            \   'exec': '%c %o %a %s'
            \ }
            \}

let g:quickrun_config.tmptex = {
            \ 'exec': [
            \         'mv %s %a/tmptex.latex',
            \         'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
            \         ],
            \ 'args': expand("%:p:h:gs?\\\\?/?"),
            \ 'outputter': 'error',
            \ 'outputter/error/error': 'quickfix',
            \
            \ 'hook/eval/enable': 1,
            \ 'hook/eval/cd': "%s:r",
            \
            \ 'hook/eval/template': '\documentclass{jarticle}'
            \                      .'\usepackage{amsthm,amssymb,amsmath}'
            \                      .'\begin{document}'
            \                      .'%s'
            \                      .'\end{document}', 
            \
            \ 'hook/sweep/files': [
            \                     '%a/tmptex.latex',
            \                     '%a/tmptex.out',
            \                     '%a/tmptex.fdb_latexmk',
            \                     '%a/tmptex.log',
            \                     '%a/tmptex.aux',
            \                     '%a/tmptex.dvi'
            \                     ]
            \}

vnoremap <silent><buffer> <F5> :QuickRun -mode v -type tmptex<CR>

" QuickRun and view compile result quickly (but don't preview pdf file)
nnoremap <silent><F5> :QuickRun -args -pv<CR>

augroup latex_autocompile
  autocmd!
  autocmd BufWritePost,FileWritePost *.tex :QuickRun
augroup END
