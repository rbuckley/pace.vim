" Vim global plugin for Pace stuff
" Last Change: 2014 Apr 9
" Maintainer Robert Buckley <robert.buckley@pace.com>


if exists("g:loaded_pacevim")
    finish
endif
let g:loaded_pacevim=1

let s:save_cpo = &cpo
set cpo&vim

noremap <unique> <script> <Plug>PaceGetStatus
noremap <SID>GetStatus :call <SID>GetStatus<CR>

function s:GetStatus()
    exec !cvs status
endfunction

if !exists(":PaceStatus")
    command -nargs=0 PaceStatus :call s:GetStatus()
endif

let &cpo = s:save_cpo
