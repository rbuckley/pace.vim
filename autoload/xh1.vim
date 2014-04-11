"
"
"
"
"

let g:xh1_pace_build_dir = g:pace_src_dir.'xh1/pace/buildsys/C209'

function! s:Make(target) abort
    silent !clear
    execute 'make -C '.g:xh1_pace_build_dir.' '.a:target
endfunction

function! s:MakeComplete(A, L, P)
    let curdir = getcwd()
    execut 'cd '.g:xh1_pace_build_dir
    let targets=system('egrep ^[a-z].+: makefile -o | cut -d : -f 1') 
    execute 'cd '.curdir
    return targets
endfunction

command -nargs=1 -complete=custom,s:MakeComplete XH1Make :call s:Make(<f-args>)
