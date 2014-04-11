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

let g:pace_src_dir = '/export/home/'.$USER.'/src/'

let g:have_pace_cvs_scripts = 0
if filereadable("/home/la-cvsbin/statuses")
    let g:have_pace_cvs_scripts = 1
endif


function! s:GoSrcDir()
    execute "cd ".g:pace_src_dir.g:pace_platform
    execute 'pwd'
endfunction


function! s:SetEnv(platform)
    let g:pace_platform = a:platform
    exec 'source ' .globpath(&rtp, 'autoload/'.a:platform.'.vim', 1)
endfunction


function! s:GetStatus()
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

command -nargs=0 PaceStatus :call s:GetStatus()
command -nargs=1 PaceSetEnv :call s:SetEnv(<f-args>)
command -nargs=0 PaceGoSrc :call s:GoSrcDir()

let &cpo = s:save_cpo
