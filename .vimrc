syntax on
set laststatus=2
set smartcase
set splitbelow
set splitright
set number
set t_Co=256
set nowrap
set backspace=2
set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
set directory=$HOME/.vim/swapfiles//
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\|\.pyc$|__pycache__'

" Disable arrow keys in normal and insert mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

call plug#begin("~/.nvim/plugged")
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'mkitt/tabline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'vim-python/python-syntax' " Enhanced Python syntax highlighting
Plug 'klen/python-mode' " Python mode - provides linting, refactoring, documentation, and more
Plug 'davidhalter/jedi-vim' " Autocompletion for Python
Plug 'vim-scripts/indentpython.vim' " Improved Python indentation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Configuration for Python/Django development
let g:python3_host_prog = '/usr/bin/python3' " Specify the path to your Python 3 interpreter
let g:syntastic_python_checkers = ['flake8'] " Use flake8 for linting
let g:pymode_lint_ignore = 'E501,E402' " Ignore specific linting errors, adjust as needed
let g:ale_fixers = {
      \ 'python': ['black'],  " Use black for Python formatting
      \ }
let g:ale_python_flake8_options = '--max-line-length=120' " Flake8 options
let g:ale_linters = {
      \ 'python': ['flake8', 'mypy'],  " Enable linting with flake8 and mypy
      \ }
let g:ale_fix_on_save = 1  " Automatically format files on save

call plug#end()

" Coc configuration for Python/Django
let g:coc_global_extensions = ['coc-pyright', 'coc-django'] " Use coc-pyright for Python type checking and coc-django for Django

" Key mappings for Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap tt :ALEToggleBuffer<CR>
nmap 22 :noh<CR>
nmap <silent> g9 :lw<CR>:set wrap<CR>
autocmd FileType python hi CocFloating guifg=#000000
autocmd FileType django hi CocFloating guifg=#000000

" Additional Python/Django specific settings can be added here

