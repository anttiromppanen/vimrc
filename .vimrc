
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')

" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'tmhedberg/SimpylFold'

" React
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'

" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" General
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
call plug#end()

" General VIM settings
map <F4> :q<CR>

set tabstop=2 shiftwidth=2 expandtab
set nu rnu
set visualbell
set t_vb=
set splitbelow
set encoding=UTF-8

" Theme
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:lightline = { 'colorscheme': 'onehalfdark' }

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" NerdTree
map <C-e> :NERDTreeToggle<CR>
" NERDTress File highlighting

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Execute python
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:ter++rows=10 python3 "%"<CR>
autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:vert ter python3 "%"<CR>
