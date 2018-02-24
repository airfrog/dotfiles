set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Vim utilities
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" Various Syntax files
Plugin 'justinmk/vim-syntax-extra'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kana/vim-filetype-haskell'
Plugin 'tpope/vim-markdown'
Plugin 'rust-lang/rust.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'fatih/vim-go'

" Python stuff
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'

" C++ stuff
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set hlsearch
set incsearch
set backspace=eol,indent,start
set smartcase
set number
if version >= 703
    set colorcolumn=80
endif
set guifont=Anonymous\ Pro:h12

filetype plugin indent on
syntax enable
colorscheme Molokai

map <Leader>y "+y
map <Leader>p "+p

" Easy toggle of numbers and folding
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set laststatus=2
set statusline=%f\ %h%m%r\ %=%-24([%Y,%{strlen(&fenc)?&fenc:'none'},%{&ff}]%)%-24(C:%-3c\ L:%-11([%l/%L]%)%)%P

nnoremap <Leader>no :nohl<CR>

" Turn on python syntax highlighting for everything
let python_highlight_all=1
let python_highlight_space_errors=0

" Open the corresponding .C/.T/.h file
" Thanks to Eli Gwynn for this function
function! OpenMatching()
    let path=expand("%:h")
    let pattern="'".expand("%:t:r").".\*'"
    let cur=expand("%:t")
    let cmd="find ".path." -maxdepth 1 -name ".pattern." -and -not -name ".cur
    let result=system(cmd)
    if v:shell_error
        echom "Error: [".result."] (".len(result).")"
        echom "Command was: [".cmd."]"
    elseif len(result)
        execute ":args ".result
    endif
endfun
nnoremap <Leader>s :call OpenMatching()<CR>

function! QFGGrep(path)
    " let needle = s:get_visual_selection()
    let needle = expand("<cword>")
    execute "silent botright Ggrep -i ".needle." ".a:path
    cwindow
endfunction
nnoremap <Leader>gg :call QFGGrep(expand("%:p:h/"))<CR>
nnoremap <Leader>ga :call QFGGrep(GitRoot())<CR>

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Go syntax options
let g:go_highlight_functions = 1
let g:go_highlight_types = 1

" NerdTREE settings
map <C-n> :NERDTreeToggle<CR>
" automatically close the file if NERDTree is the only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autoopen NERDTree for blank vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
