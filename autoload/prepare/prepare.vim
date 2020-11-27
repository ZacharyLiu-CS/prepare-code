" ==============================================================
" Create Date: 2018-05-29
" License: MIT
" ==============================================================

" generate the prepare code
function! prepare#prepare#gen_prepare_code()
  let suffix = prepare#util#get_current_file_suffix()
  call <sid>gen_prepare_code_by_suffix(suffix)
endfunction

" recognize the file suffix
function! s:gen_prepare_code_by_suffix(suffix)
  "we only support the code whose suffix is in our snippet respository
  let file_list = <sid>get_snippet_code_suffix()
  "To DO Optimization : search an unsorted list is time consuming
  if index(file_list,a:suffix) != -1
    " get the name
    let name=g:prepare_code_name
    " get the email
    let email=g:prepare_code_email_address
    let startNum = <sid>gen_notes(a:suffix,name,email)
    " get the code
    let lines = <sid>get_prepare_code(a:suffix)
    " replace the key word
    let target = prepare#util#get_current_file_base_name()
    let lines = prepare#util#replace_texts(lines, "snippet", target)
    call prepare#util#write_texts(startNum,lines)
  endif
endfunction


" generate nodes
function! s:gen_notes(suffix, name, mail)
  if a:suffix == "sh" ||a:suffix == "py"
    call setline(1, "\#########################################################################")
    call append(line(".")  , "\# File Name     : ".expand("%"))
    call append(line(".")+1, "\# Author        : ".a:name)
    call append(line(".")+2, "\# mail          : ".a:mail)
    call append(line(".")+3, "\# Created Time  : ".strftime("%c"))
    call append(line(".")+4, "\#########################################################################")
    call append(line(".")+5, "")
    return 6
  elseif a:suffix == "c" || a:suffix == "h" || a:suffix == "hpp" ||a:suffix == "cpp" || a:suffix == "cc"
    call setline(1, "/*************************************************************************")
    call append(line("."), "    > File Name       : ".expand("%"))
    call append(line(".")+1, "    > Author          : ".a:name)
    call append(line(".")+2, "    > Mail            : ".a:mail)
    call append(line(".")+3, "    > Created Time    : ".strftime("%c"))
    call append(line(".")+4, " ************************************************************************/")
    call append(line(".")+5, "")
    return 6
  endif
endfunction

" get the code snippets
function! s:get_prepare_code(suffix)
  let file_path = $HOME."/.vim/plugged/prepare-code/snippet/snippet." . a:suffix
  return prepare#util#read_file(file_path)
endfunction

" get all the code suffix in snippets directory
function! s:get_snippet_code_suffix()
  let snippet_path = $HOME."/.vim/plugged/prepare-code/snippet"
  let file_list = split(globpath(snippet_path,'*'),'\n')
  let file_list = map(copy(file_list),"split(v:val,'\\.')[-1]")
  return file_list
endfunction

