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

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
