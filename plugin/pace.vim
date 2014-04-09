" Vim global plugin for Pace stuff
" Last Change: 2014 Apr 9
" Maintainer Robert Buckley <robert.buckley@pace.com>


if exists("g:loaded_pacevim")
    finish
endif
let g:loaded_pacevim=1

let s:save_cpo = &cpo
set cpo&vim

let g:have_pace_cvs_scripts = 0
if filereadable("/home/la-cvsbin/statuses")
    let g:have_pace_cvs_scripts = 1
endif

function s:GetStatus()
    let regbak=@z
    if g:have_pace_cvs_scripts
        let @z=system('statuses -nouk -noutd -nolocal -q')
        10sv
        silent normal! "zP
    else
        let @z=system('cvs statuses')
    endif
    let @z=regbak
endfunction

if !exists(":PaceStatus")
    command -nargs=0 PaceStatus :call s:GetStatus()
endif

let &cpo = s:save_cpo
