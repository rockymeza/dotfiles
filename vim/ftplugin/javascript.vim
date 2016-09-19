set ts=2
set sw=2

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_args = "--jsx-only --babel --babel-experimental"

" https://github.com/othree/javascript-libraries-syntax.vim#config
let g:used_javascript_libs = 'jquery,lodash,angular,angularui,jasmine'
