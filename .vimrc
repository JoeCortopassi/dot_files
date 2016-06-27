syntax on
" filetype plugin indent on
set laststatus=2
set smartcase
set splitbelow
set splitright
imap jj <Esc>
map <Leader>\ \c<Space>
map <C-T> <C-P>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
set number
let g:ctrlp_working_path_mode = 'c'
set t_Co=256
set nowrap
set backspace=2
set expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
set directory=$HOME/.vim/swapfiles//
"autocmd BufNewFile,BufRead *.js set spell
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\'

call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'airblade/vim'
Plug 'pangloss/vim-javascript'
Plug 'groenewege/vim-less'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'morhetz/gruvbox'
Plug 'flowtype/vim-flow'
call plug#end()

" YouCompleteMe settings
"let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_min_num_of_chars_for_completion = 2


" Synatic settings (ESLint)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

let g:flow#autoclose = 1
