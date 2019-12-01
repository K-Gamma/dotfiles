" initialization run configuration

augroup MyAutoCmd
    " Initialize the autocommand group
    autocmd!
    " Make the filetype correspond to the file
    autocmd FileType,Syntax,ColorScheme,BufNewFile,BufNew,BufRead *?
                \ call vimrc#on_filetype()
    " Synchronize for .toml complex syntax.
    autocmd CursorHold *.toml syntax sync minlines=300
augroup END

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
    if os#is_windows() && !has('gui_running')
        set encoding=cp932
    else
        set encoding=utf-8
    endif
endif

" Build encodings.
let &fileencodings = join([
            \ 'ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp', 'cp932'])

" Setting of terminal encoding.
if !has('gui_running') && os#is_windows()
    " For system.
    set termencoding=cp932
endif

if has('multi_byte_ime')
    set iminsert=0 imsearch=0
endif

" Set character code of Vim script file.(you can use multibyte)
scriptencoding utf-8

" Use English interface.
language message C

" Use <Leader> in global plugin.
" Use ',' instead of default '\'.
let g:mapleader = ','
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = 'm'

" Release keymappings for plug-in.
nnoremap m  <Nop>
nnoremap ,  <Nop>

if os#is_windows()
    " Exchange path separator.
    set shellslash
endif

let g:config_home = empty($XDG_CONFIG_HOME) ? expand('${HOME}/.config') : $XDG_CONFIG_HOME
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('${HOME}/.cache') : $XDG_CACHE_HOME
let g:dein#base_path = g:cache_home . '/dein'

if !isdirectory(g:dein#base_path)
    call mkdir(g:dein#base_path, 'p')
endif

" Load dein.
let g:dein#repo_path = g:dein#base_path.'/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(g:dein#repo_path)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(g:dein#repo_path))
    endif
    execute 'set runtimepath^=' . substitute(
                \ fnamemodify(g:dein#repo_path, ':p') , '/$', '', '')
endif

"---------------------------------------------------------------------------
" Disable default plugins

" Disable menu.vim
if has('gui_running')
    set guioptions=Mc
endif

let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_man               = 1
set keywordprg=:help " Open Vim internal help by K command
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1  " -> vim-parenmatch
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
