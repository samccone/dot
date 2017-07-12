set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'vim-airline/vim-airline'
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'valloric/MatchTagAlways'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'lepture/vim-jinja'
Plugin 'rhysd/vim-clang-format'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mhinz/vim-signify'

Plugin 'Shougo/vimproc.vim'          " Force install a dependency of tsuquyomi.
Plugin 'leafgarland/typescript-vim'  " enables TypeScript syntax-highlighting.
Plugin 'Quramy/tsuquyomi'            " enables TypeScript auto-completion.

call vundle#end()
filetype plugin indent on

syntax on
syntax enable

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" autoreload on change
set autoread

set backspace=indent,eol,start

" show line numbers
set number

set clipboard=unnamedplus

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" add geojson syntx highlighting
augroup filetypedetect
  au! BufRead,BufNewFile *.geojson setfiletype json
augroup END

autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript

" auto reload files on external change
set autoread

au CursorHold * checktime
"
"unite settings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async', 'ignore_pattern', '\(\.tmp\/\|node_modules\|bower_components\)')
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_grep_default_opts="-inH --exclude-dir=node_modules --exclude-dir=bower_components"
let g:unite_enable_start_insert=1
let g:unite_force_overwrite_statusline=1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_ignore_source_files = ['node_modules', 'bower_components']
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".git" --hidden -g ""'
endif

"unite shortcut leader T search files
nnoremap <leader>t :<C-u>Unite file_rec/async<cr>
"unite shortcut leader F search file contents
nnoremap <leader>f :<C-u>Unite grep:.<cr>



filetype plugin indent on

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"signify setup
let g:signify_vcs_list = [ 'perforce', 'git' ]

let g:signify_vcs_cmds = {
      \ 'perforce': 'p4 info >& /dev/null && env G4MULTIDIFF=0 P4DIFF=%d p4 diff -dU0 %f'
      \ }

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
" html checkers are not so useful
let g:syntastic_html_checkers=['']

let g:syntastic_quiet_messages = {
        \ "!level":  "errors",
        \ "type":    "style",
        \ "regex":   '.*',
        \ "file:p":  '.py' }

" column color indicator
set colorcolumn=80

"gvim edits
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

"airline

" always show airline
set laststatus=2

" remap sidebar to control l
map <C-l> :NERDTreeFind<cr>

" inc search config
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" gutter
let g:singify_vcs_list = ['git', 'perforce']
let g:signify_vcs_cmds = {
    \ 'perforce': 'p4 info >& /dev/null && env G4MULTIDIFF=0 P4DIFF=%d p4 diff -dU0 %f'
    \ }


" TypeScript plugin setup
nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>

if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['go'] = ['.', ':']

" ctrl p
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_mruf_relative = 1


" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_go_checkers = ['gofmt', 'golint', 'gotype', 'govet']
let g:syntastic_check_on_wq = 0
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

"signify setup
let g:signify_vcs_list = [ 'perforce', 'git' ]

let g:signify_vcs_cmds = {
      \ 'perforce': 'p4 info >& /dev/null && env G4MULTIDIFF=0 P4DIFF=%d p4 diff -dU0 %f'
      \ }


set term=xterm-256color

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up>   :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
