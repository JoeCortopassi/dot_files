syntax on
" filetype plugin indent on
set laststatus=2
set smartcase
set splitbelow
set splitright
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
set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
set directory=$HOME/.vim/swapfiles//
"autocmd BufNewFile,BufRead *.js set spell
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\'

call plug#begin("~/.nvim/plugged")
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Valloric/YouCompleteMe'
Plug 'mkitt/tabline.vim'
Plug 'fatih/vim-go'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'airblade/vim'
Plug 'pangloss/vim-javascript'
Plug 'keith/swift'
Plug 'groenewege/vim-less'
Plug 'mhinz/vim-signify'
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'morhetz/gruvbox'
Plug 'flowtype/vim-flow'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

" YouCompleteMe settings
"let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
"let g:ycm_min_num_of_chars_for_completion = 2


" Synatic settings (ESLint)
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

let g:flow#autoclose = 1


" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap tt :ALEToggleBuffer<CR>
nmap 22 :noh<CR>
nmap <silent> g9 :lw<CR>:set wrap<CR>

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
