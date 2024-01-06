" BEHAVIOUR {{{

filetype plugin indent on

set spelllang=en_gb
set laststatus=2
set cursorline
set termguicolors

" Always show tab line
set showtabline=2
set noshowmode
set number

set scrolloff=5
set sidescrolloff=10

set splitright
set splitbelow

" }}}

" REMAPS {{{

" no more shift holding for :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Leader on ,
let mapleader = ","

" move by screen lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" reselect after indenting
vnoremap < <gv
vnoremap > >gv

nnoremap Y y$

" jj as escape
inoremap jj <ESC>
inoremap jk <ESC>
inoremap j; <ESC>:

nnoremap <leader><space> :nohl<cr>

" use <leader>y and <leader>p to copy and paste from system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

nnoremap <leader>D :r! date "+\%Y-\%m-\%d \%H:\%M"<cr>
nnoremap <leader>d :r! date "+\%Y-\%m-\%d"<cr>
nnoremap <leader>t :r! date "+\%H:\%M"<cr>

" use regular regex syntax rather than vim regex
nnoremap / /\v
vnoremap / /\v

" Easy navigation for split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle comments (via vim-commentary)
" Note that console vim recognizes <C-/> as <C-_>
nmap <C-/> gcc
vmap <C-/> gc
autocmd FileType fsharp setlocal commentstring=//\ %s

" Don't fold in git commits
autocmd FileType gitcommit set foldmethod=syntax
autocmd FileType gitcommit setlocal nofoldenable

" Don't hard wrap in Markdown
autocmd FileType markdown set textwidth=0

" Normalize split sizes
au VimResized * exe "normal! \<c-w>="

" Browse files and buffers with fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <C-m> :Buffers<CR>
cnoremap <C-r> History:<CR>

" Search and replace quickly
nnoremap gs yiw:%s/\<<C-r>"\>//g<Left><Left>
nnoremap gS yiw:%s/<C-r>"//g<Left><Left>
vnoremap gs y:%s/<C-r>"//g<Left><Left>
nnoremap <leader>* yaw:Rg <C-r>"<CR>
vnoremap * y:Rg <C-r>"<CR>

