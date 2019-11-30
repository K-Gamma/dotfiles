""" dein run configuration

if !dein#load_state(g:dein#base_path)
    finish
endif

let g:dein#install_progress_type = 'tabline'
let g:dein#install_log_filename = g:dein#base_path.'/dein.log'

let s:here = fnamemodify(expand('<sfile>'), ':h')
let s:dein_toml = s:here.'/dein.toml'
let s:dein_lazy_toml = s:here.'/dein_lazy.toml'
let s:dein_ft_toml = s:here.'/dein_ft.toml'

call dein#begin(g:dein#base_path, [
            \ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml, s:dein_ft_toml
            \ ])

call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
call dein#load_toml(s:dein_ft_toml)

call dein#end()
call dein#save_state()

if has('vim_starting') && dein#check_install()
    " Installation check.
    call dein#install()
endif
