function! os#is_windows() abort
    return has('win32') || has('win64')
endfunction

function! os#is_mac() abort
    return os#is_windows() && !has('win32unix')
                \ && (has('mac') || has('macunix') || has('gui_macvim')
                \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction
