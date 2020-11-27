" ==============================================================
" Create Date: 2018-05-29
" License: MIT
" ==============================================================
 
function! prepare#util#get_current_file_base_name()
    let file_name = expand("%")
    return fnamemodify(file_name, ":t:r")
endfunction

function! prepare#util#write_text_at_current_row(i,text)
    call append(line(".") +a:i,a:text)
endfunction

function! prepare#util#write_texts(lineNumber,lines)
  "  call prepare#util#add_notes()
    for i in range(0, len(a:lines) - 1)
        call prepare#util#write_text_at_current_row(a:lineNumber+i,a:lines[i] )
    endfor
endfunction

function! prepare#util#get_current_file_suffix()
    return expand("%:e")
endfunction

function! prepare#util#read_file(file_path)
    return readfile(a:file_path)
endfunction

function! prepare#util#replace_string(str, src, target)
    return substitute(a:str, a:src, a:target, "g")
endfunction

function! prepare#util#replace_texts(lines, src, target)
    let texts = []
    for i in range(0, len(a:lines) - 1)
        let ret = prepare#util#replace_string(a:lines[i], a:src, a:target)
        call add(texts, ret)
    endfor
    return texts
endfunction

