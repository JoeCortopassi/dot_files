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
set expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2
set directory=$HOME/.vim/swapfiles//
"autocmd BufNewFile,BufRead *.js set spell
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\'

call plug#begin("~/.nvim/plugged")
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Valloric/YouCompleteMe'
Plug 'godlygeek/tabular'
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
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
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
autocmd FileType javascript hi CocFloating guifg=#000000
autocmd FileType typescript hi CocFloating guifg=#000000

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" From ChatGPT
" Define the script-local function as before
"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Define a global function that calls the script-local function
"function! CheckBackSpaceWrapper() abort
  "return s:check_back_space()
"endfunction

"" Update your mappings to use the global wrapper function
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ CheckBackSpaceWrapper() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" From coc docs
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
