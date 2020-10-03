let g:maplocalleader = '\'

let s:local_leader_map = {}
let s:local_leader_map['name'] = 'root'

nnoremap <silent> <LocalLeader> :<c-u>WhichKey  '\'<CR>

let g:saltor#map#localleader#desc = s:local_leader_map
call which_key#register('\', 'g:saltor#map#localleader#desc')
