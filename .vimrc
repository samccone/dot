set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on

let g:solarized_termcolors=256

syntax enable
set background=dark
colorscheme solarized

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" autoreload on change
set autoread

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|node_modules\|public\|bower_components\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

set backspace=indent,eol,start

" show line numbers
set number
" remove git column background color
highlight SignColumn ctermbg=none
" remove line number background color
highlight LineNR ctermbg=none

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

let g:unite_enable_start_insert=1
let g:unite_force_overwrite_statusline=1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_ignore_source_files = ['node_modules', 'bower_components']
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".git" --hidden -g ""'
endif

"unite shortcut leader T
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=file file_rec/async:!<cr>

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
