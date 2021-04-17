" exit when already loaded (or compatible mode set)
if exists("g:loaded_margin") || &cp
  finish
endif
let g:loaded_margin = 1 " version number
let s:keepcpo = &cpo
set cpo&vim

let g:centered=0


let s:name = '_padding_'

function! s:MarginDisable()
    if bufwinnr(s:name) > 0
        only
    endif
    let g:centered=0
endfunction

function! s:MarginEnable()
    let l:width = ((&columns - &textwidth) / 2 - 5)
    if l:width > 1 && bufwinnr(s:name) <= 0
        execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted' s:name | wincmd p
        execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted' s:name | wincmd p
    endif
    let g:centered=1
endfunction

function! s:MarginResize()
    if g:centered == 1
        call s:MarginDisable()
        call s:MarginEnable()
    endif
endfunction

function! s:MarginToggle()
    if g:centered == 1
        call s:MarginDisable()
    elseif g:centered == 0
        call s:MarginEnable()
    endif
endfunction

autocmd BufDelete * :call s:MarginDisable()
autocmd VimResized * :call s:MarginResize()
autocmd QuitPre <buffer> :call s:MarginDisable()

command! Margin call s:MarginToggle()
"call MarginEnable()

let &cpo= s:keepcpo
unlet s:keepcpo
