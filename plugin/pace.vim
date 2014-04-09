" Vim global plugin for Pace stuff
" Last Change: 2014 Apr 9
" Maintainer Robert Buckley <robert.buckley@pace.com>


if exists("g:loaded_pacevim")
    finish
endif
let g:loaded_pacevim=1




function s:PaceGetStatus()
    exec !cvs status
endfunction
