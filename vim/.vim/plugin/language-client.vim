let g:LanguageClient_serverCommands = {
\ 'javascript': [exepath('typescript-language-server'), '--stdio'],
\ 'javascript.jsx': [exepath('typescript-language-server'), '--stdio'],
\ 'css': [exepath('css-languageserver'), '--stdio'],
\ }
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_selectionUI = "location-list"
let g:LanguageClient_rootMarkers = ['.git']
let g:LanguageClient_rootMarkers = ['package.json', '.git', '.eslintrc']
let g:LanguageClient_useVirtualText=1
let g:LanguageClient_virtualTextPrefix = '> '
let g:LanguageClient_diagnosticsDisplay = {
\    1: {
\        "name": "Error",
\        "texthl": "ALEError",
\        "signText": "✖",
\        "signTexthl": "MyALEErrorColors",
\        "virtualTexthl": "MyALEErrorColors",
\    },
\    2: {
\        "name": "Warning",
\        "texthl": "ALEWarning",
\        "signText": "⚠",
\        "signTexthl": "Todo",
\        "virtualTexthl": "Todo",
\    },
\    3: {
\        "name": "Information",
\        "texthl": "ALEInfo",
\        "signText": "ℹ",
\        "signTexthl": "Todo",
\        "virtualTexthl": "Todo",
\    },
\    4: {
\        "name": "Hint",
\        "texthl": "ALEInfo",
\        "signText": "➤",
\        "signTexthl": "Todo",
\        "virtualTexthl": "Todo",
\    },
\}
