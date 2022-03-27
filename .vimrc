" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
" Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'chrisbra/Colorizer'
Plug 'file://'.expand('~/.vim/plugged/vimawesome')
Plug 'christoomey/vim-tmux-navigator'
" below is not working in vim 8.1
Plug 'yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-vinegar'
Plug 'romainl/vim-cool'
Plug 'dense-analysis/ale' 
Plug 'jalvesaq/Nvim-R/'
Plug 'tpope/vim-unimpaired' 
Plug 'terryma/vim-multiple-cursors'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'kassio/neoterm'
" DEOPLETE
"" Below 3 are for deoplete
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"" javascript - tern
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern'  }
"COC - Conqueror of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

""" LANGUAGE """
"" language completion
" COC 
" COC extensions
" add extensions to list to activate, COC will install on neovim/vim startup
" run manually to install COC extensions: :CocInstall extension-name
" coc-r-lsp:
" uses R on top of path - works with prncevince/r-shims :)
" uses languageserver R package, which lints with lintr, and can use styler
" you can still fix code using ALE with styler
let g:coc_global_extensions = [
  \ 'coc-css', 
  \ 'coc-html',
  \ 'coc-json', 
  \ 'coc-marketplace',
  \ 'coc-pyright',
  \ 'coc-r-lsp',  
  \ 'coc-tsserver'
  \ ]
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" update speeds
set updatetime=300
"
" DEOPLETE
"let g:deoplete-options-auto_complete_delay 
let g:deoplete#enable_at_startup = 1 
" javascript - tern
" Set bin if you have many instalations
"let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
"let g:deoplete#sources#ternjs#timeout = 1
" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1
" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
"let g:deoplete#sources#ternjs#depths = 1
" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1
" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
"let g:deoplete#sources#ternjs#filter = 0
" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
"let g:deoplete#sources#ternjs#case_insensitive = 1
" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
"let g:deoplete#sources#ternjs#guess = 0
" Determines whether the result set will be sorted. Default: 1
"let g:deoplete#sources#ternjs#sort = 0
" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
"let g:deoplete#sources#ternjs#expand_word_forward = 0
" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
"let g:deoplete#sources#ternjs#omit_object_prototype = 0
" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
"let g:deoplete#sources#ternjs#include_keywords = 1
" If completions should be returned when inside a literal. Default: 1
"let g:deoplete#sources#ternjs#in_literal = 0
"Add extra filetypes
"let g:deoplete#sources#ternjs#filetypes = [
"                \ 'jsx',
"                \ 'javascript.jsx',
"                \ 'vue',
"                \ '...'
"                \ ]
"" LINTING / SYNTAX
" ALE Plugin
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\	'javascript': ['eslint', 'standard'],
\	'r': ['styler']
\}
let g:ale_linters = {
\  'javascript': ['eslint', 'standard'],
\}
" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" Go - vim-go plugin 
function DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
        set filetype=gohtmltmpl 
    endif
endfunction
augroup filetypedetect
    au! BufRead,BufNewFile * call DetectGoHtmlTmpl()
augroup END

""" FUNCTIONALITY """
" FZF Fuzzy Find
" To use fzf in Vim, add the following line to your .vimrc:
set rtp+=/usr/local/opt/fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
" to see all search matches highlighted (vim-cool turns off automagically)
set hlsearch
" Copy & Paste
set viminfo='100,<1000,s10" 
" Line Numbers
set relativenumber
set numberwidth=2
nmap <C-N><C-N> :set invnumber<CR>
" White Space "
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Tab Lines "
" indentline plugin
"for 'vim'
if !has('nvim')
  let g:vim_json_conceal = 0
endif
" below is not working in vim 8.1
"set listchars=tab:\|\ 
"set list
" airline plugin
let g:airline_powerline_fonts = 1
let g:airline_symbols = get(g:,'airline_symbols',{})
let g:airline_symbols["dirty"] = '!'
let g:airline_theme='vince'
" GIT
" gitgutter plugin
set updatetime=250
" fugitive 
set modifiable
" Netrw
" doesn't work anymore ... not in vim > 8
" remove/delete directories
"let g:netrw_localrmdir='rm -r'
" resource vimrc on save
autocmd BufWritePost .vimrc source %
" GITHUB - rhubarb
let g:github_enterprise_urls = [expand("$GHE1")]

""" KEYBINDINGS  """
let mapleader = ","
" vimrc & nvim/init.vim
map <leader>ne :e $MYVIMRC<CR>
map <leader>ns :sp $MYVIMRC<CR>
map <leader>nv :vsp $MYVIMRC<CR>
map <leader>ve :e $VIMRC<CR>
map <leader>vs :sp $VIMRC<CR>
map <leader>vv :vsp $VIMRC<CR>
" zshrc
map <leader>ze :e $ZSHRC<CR>
map <leader>zs :sp $ZSHRC<CR>
map <leader>zv :vsp $ZSHRC<CR>
" tmuxconf
map <leader>te :e $TMUXCONF<CR>
map <leader>ts :sp $TMUXCONF<CR>
map <leader>tv :vsp $TMUXCONF<CR>
" escape terminal emulatory
:tnoremap <leader><Esc> <C-\><C-n>
" neoterm 
" REPL
" sends the current file to a REPL in a terminal
map <LEADER>rf :TREPLSendFile<CR>
" sends the current line to a REPL in a terminal
map <LEADER>rl :TREPLSendLine<CR>
" sends the selection to a REPL in a terminal
map <LEADER>rs :TREPLSendSelection<CR>
" use mapped ALE fixer - ALEFix command
nmap <LEADER>l <Plug>(ale_fix)
" <SPACE> is <ENTER>
map <SPACE> <ENTER>
" quick save
noremap <Leader>s :update<CR>
" fzf
nnoremap <leader>r :FZF<CR>
nmap <Leader>: :History:<CR>
" vim / iterm2 / mac specific (<Arrow-key> direction mappings work correctly in
" nvim)
if !has('nvim')
  " Maps Alt-[h,j,k,l] to resizing a window split
  execute "set <M-h>=\eh"
  execute "set <M-j>=\ej"
  execute "set <M-k>=\ek"
  execute "set <M-l>=\el"
  map <M-h> <C-w><
  map <M-j> <C-W>-
  map <M-k> <C-W>+
  map <M-l> <C-w>>
  "in iterm2 (with ⌥→ set) forward-word to ⌥→ - https://superuser.com/a/1453391/101877
  "vim
  execute "set <M-p>=\e[1;9C"
  execute "set <M-u>=\e[1;9D"
  map <M-p> w
  map <M-u> b
  "tmux
  execute "set <M-i>=\e[1;3C"
  execute "set <M-o>=\e[1;3D"
  map <M-i> w
  map <M-o> b
endif 
"tmux-vim-navigator fixing <c-l> in netrw
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
  nnoremap <buffer> <c-l> :wincmd l<cr>
endfunction

""" COLOR SCHEMES """
"
"vim file editted in insert mode is SLOW - so we've commented it out
"" let g:colorizer_auto_filetype='css,html,vim'
let g:colorizer_auto_filetype='css,html'
"let g:colorizer_use_virtual_text = 1

" Nord Plugin
" colo nord
" Seoul256 Plugin
" Unified color scheme (default: dark)
"colo seoul256
" Light color scheme
"colo seoul256-light
" Switch
"set background=dark
"set background=light
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
"LAST USED --v
set cursorline 
if match([$ITERM_PROFILE], "Nord")+1
  let g:seoul256_background = 233
  colo seoul256
  hi CocFloating ctermfg=252 ctermbg=235 guifg=#D9D9D9 guibg=#333233
  hi CursorLine ctermbg=235 "ctermfg=0 guifg=#060606 guibg=#060606
endif
if match([$ITERM_PROFILE], "Outside")+1
  colo seoul256-light
endif

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" let g:seoul256_background = 256
" colo seoul256

""" COMMANDS """
command! E Explore
command! C CocConfig 
