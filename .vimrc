
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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Initialize plugin system
call plug#end()

" General VIM settings
map <F4> :q<CR>
let mapleader=","

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

" Ligtline
set laststatus=2
set noshowmode

" Emmet
let g:user_emmet_leader_key=','

" A NerdTree
map <C-e> :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#282c34')
call NERDTreeHighlightFile('ini', 'yellow', 'none', '#c678dd', '#282c34')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#282c34')
call NERDTreeHighlightFile('yml', 'yellow', 'none', '#e5c07b', '#282c34')
call NERDTreeHighlightFile('config', 'yellow', 'none', '#e5c07b', '#282c34')
call NERDTreeHighlightFile('conf', 'yellow', 'none', '#e5c07b', '#282c34')
call NERDTreeHighlightFile('json', 'yellow', 'none', '#e5c07b', '#282c34')
call NERDTreeHighlightFile('html', 'yellow', 'none', '#f06529', '#282c34')
call NERDTreeHighlightFile('styl', 'cyan', 'none', '#282c34', '#282c34')
call NERDTreeHighlightFile('css', 'cyan', 'none', '#56b6c2', '#282c34')
call NERDTreeHighlightFile('coffee', 'Red', 'none', '#e06c75', '#282c34')
call NERDTreeHighlightFile('js', 'Red', 'none', '#f0db4f', '#282c34')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#282c34')

" Execute python
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:ter++rows=10 python3 "%"<CR>
autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:vert ter python3 "%"<CR>

" FZF
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
