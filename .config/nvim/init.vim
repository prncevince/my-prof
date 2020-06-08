" uses .vimrc 
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" alias
"command! "conf" "e $NVIMINIT" 

" language completion
" COC
" for allowing go to definition (gd) in files with unsaved changes 
set hidden

" highlighting & syntax
" this is NOT working in neovim 0.4.3 
"let g:vim_json_syntax_conceal = 0
" to make editing files in JSON functional - temporary fix
let g:indentLine_concealcursor = ''
" stops indentline 
""let g:indentLine_setConceal = 0

" keybindings 
" forward-word to Alt(⌥)→
map <M-Right> w
map <M-Left> b
" Maps Alt-[h,j,k,l] to resizing a window split
map <M-h> <C-w><
map <M-j> <C-w>-
map <M-k> <C-w>+
map <M-l> <C-w>>
