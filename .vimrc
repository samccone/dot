set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on

syntax enable

colorscheme pencil
set background=light

let g:pencil_gutter_color = 1
let g:pencil_terminal_italics = 1

let g:airline_theme = 'pencil'

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

set clipboard=unnamed

" show trailing whitespace chars
set list
set listchars=tab:>>,trail:.,extends:#,nbsp:.

" auto remove whitespace on buffer save
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" add geojson syntx highlighting
augroup filetypedetect
  au! BufRead,BufNewFile *.geojson setfiletype json
augroup END

" auto reload files on external change
set autoread

au CursorHold * checktime

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


" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

filetype plugin indent on

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"control p
set runtimepath^=~/.vim/bundle/ctrlp.vim

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/*,bower_components/*
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" always show airline
set laststatus=2

" remap sidebar to control l
map <C-l> :NERDTreeToggle<cr>
