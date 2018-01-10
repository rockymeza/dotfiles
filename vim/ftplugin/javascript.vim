set ts=2
set sw=2

let g:jsx_ext_required = 0

" https://github.com/othree/javascript-libraries-syntax.vim#config
let g:used_javascript_libs = 'jquery,lodash,angular,angularui,jasmine'

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" https://github.com/pangloss/vim-javascript#concealing-characters
let g:javascript_conceal_arrow_function = "⇒"

let g:javascript_plugin_flow = 1
