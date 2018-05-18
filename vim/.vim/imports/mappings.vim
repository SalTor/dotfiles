map <C-n> :NERDTreeToggle<CR>
map <C-f> :FZF<CR>

" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP

ino <down> <ESC>ddpi
ino <left> <Nop>
ino <right> <Nop>
ino <up> <ESC>ddkPi

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" EasyMotion Maps
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader> <Plug>(easymotion-prefix)
