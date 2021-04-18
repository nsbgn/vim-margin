" exit when already loaded (or compatible mode set)
if exists("g:loaded_margin") || &cp
  finish
endif
let s:keepcpo = &cpo
set cpo&vim

let g:margin_enabled=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer numbers of the margins --- no margin buffers exist at the start yet
let s:lmargin_bufnr=-1
let s:rmargin_bufnr=-1

" Calculate *current* preferred width of the margin based on textwidth
function! s:margin_calcwidth()
    let nwidth  = max([len(string(line('$'))) + 1, &numberwidth])
    let width   = &textwidth + (&number ? nwidth : 0)
    let hmargin = max([0, (&columns - width) / 2 - 1])
    return hmargin
endfunction

function! s:margin_create(create_command, repel_command)
    execute a:create_command
    setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile winfixwidth
    execute 'autocmd WinEnter,CursorMoved <buffer> execute "' a:repel_command '"'
    let bufnr = winbufnr(0)
    execute winnr('#') . 'wincmd w'
    return bufnr
endfunction

function! s:margins_resize_to(width)
    for bufnr in [s:lmargin_bufnr, s:rmargin_bufnr]
        if bufnr > 0
            execute bufwinnr(bufnr) . 'wincmd w'
            execute 'vertical resize ' . a:width
            execute winnr('#') . 'wincmd w'
        endif
    endfor
endfunction

function! s:margins_delete()
    for bufnr in [s:lmargin_bufnr, s:rmargin_bufnr]
        if bufnr > 0
            execute bufwinnr(bufnr) . 'wincmd w'
            execute 'wincmd q'
            " execute winnr('#') . 'wincmd w'
        endif
    endfor
    let s:rmargin_bufnr=-1
    let s:lmargin_bufnr=-1
endfunction

function! s:margins_create_if_necessary()
    if s:lmargin_bufnr < 0
        let s:lmargin_bufnr = s:margin_create('vertical topleft new', 'wincmd l')
    endif
    if s:rmargin_bufnr < 0
        let s:rmargin_bufnr = s:margin_create('vertical botright new', 'wincmd h')
    endif
endfunction

function! s:margins_recalc()
    let l:width = s:margin_calcwidth()
    if l:width > 0
        call s:margins_create_if_necessary()
        call s:margins_resize_to(l:width)
    else
        call s:margins_delete()
    endif
endfunction

if g:margin_enabled == 1
    augroup margin
    autocmd VimEnter,OptionSet,VimResized * :call s:margins_recalc()
    autocmd QuitPre :call s:margins_delete()
    augroup END
endif

command! MarginReset :call s:margins_recalc()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo= s:keepcpo
unlet s:keepcpo
