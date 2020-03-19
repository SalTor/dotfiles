let s:js_whitelist = [
            \ 'jsModuleKeyword',
            \ 'jsDestructuringBlock',
            \ 'jsDestructuringPropertyValue',
            \ 'jsObject',
            \ 'jsObjectProp',
            \ 'jsArrowFuncArgs',
            \ 'jsFuncArgs',
            \ 'jsParen',
            \ 'jsTemplateExpression',
            \ 'jsVariableDef',
            \ 'jsFuncCall',
            \ 'jsFuncBlock',
            \ ]

let g:Illuminate_ftwhitelist = [
    \ 'vim', 'javascript', 'javascriptreact',
    \ 'python', 'css', 'scss',
    \ ]
let g:Illuminate_ftHighlightGroups = {
    \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
    \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc'],
    \ 'javascript': s:js_whitelist,
    \ 'javascriptreact': s:js_whitelist,
    \ }
