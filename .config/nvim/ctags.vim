" Automatically generates tags file on file save.
function! s:OnCtagsExit()
    echo "Wrote .tags file"
endfunction

function! s:DeleteTags(callback)
    let filename = expand("%:p")
    let directory = expand("%:p:h")
    let tagfilename = directory . "/.tags"
    let file = substitute(filename, directory . "/", "", "")
    let file = escape(file, "./")
    let cmd = "sed -i '/" . file . "/d' '" . tagfilename . "'"

    call jobstart(cmd, {
    \ "on_exit": a:callback,
    \})
endfunction

function! s:UpdateTags()
    let filename = expand("%:p")
    let directory = expand("%:p:h")
    let tagfilename = directory . "/.tags"
    let cmd = "ctags -a --sort=foldcase -f " . tagfilename . " '" . filename . "'"
    call jobstart(cmd, {
    \ "on_exit": function("s:OnCtagsExit"),
    \ })
endfunction

function! g:ctags#UpdateTags()
    call s:DeleteTags(function("s:UpdateTags"))
endfunction
