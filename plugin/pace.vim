" Vim global plugin for Pace stuff
" Last Change: 2014 Apr 9
" Maintainer Robert Buckley <robert.buckley@pace.com>


if exists("g:loaded_pacevim")
    finish
endif
let g:loaded_pacevim=1

if !exists("g:cvs_command")
    let g:cvs_cmd = "cvs"
endif

let s:save_cpo = &cpo
set cpo&vim

let g:have_pace_cvs_scripts = 0
if filereadable("/home/la-cvsbin/statuses")
    let g:have_pace_cvs_scripts = 1
endif

function s:GetStatus()
    if g:have_pace_cvs_scripts
        let statuses=system('statuses -nouk -noutd -nolocal -q')
        pedit __CVS_Status__
        wincmd P
        normal! ggdG
        setlocal buftype=nofile
        nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
        call append(0, split(statuses, '\n'))
    else
        let @z=system('cvs statuses')
    endif
endfunction

if !exists(":PaceStatus")
    command -nargs=0 PaceStatus :call s:GetStatus()
endif

let &cpo = s:save_cpo
