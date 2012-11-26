set tabstop=4
set shiftwidth=4

let g:syntastic_python_checker_args = "--ignore=E501"

function! GetCurrentPythonClass()
    call search('^\s*class \ze\S\+\s*(', 'sbe')
    let class = expand('<cword>')
    normal ''
    return class
endfunction

function! GetCurrentPythonMethod()
    call search('^\s*def ', 'sbe')
    let method = expand('<cword>')
    normal ''
    return method
endfunction

function! GetFirstPythonArg()
    call search('^\s*def \S\+(', 'sbe')
    let method = expand('<cword>')
    normal ''
    return method
endfunction

function! GetCurrentPythonArgs()
    let line_number = search('^\s*def[^(]\+([^,]*,\?', 'sbe')
    let args = matchstr(getline(line_number), '^\s*def[^(]\+([^,]\+,\s*\zs.*\ze):$')
    let args = substitute(args, '\s*=[^,]\+', '', 'g')
    normal ''
    return args
endfunction
