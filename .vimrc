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
Plugin 'kien/ctrlp.vim'

" Various Syntax files
Plugin 'kchmck/vim-coffee-script'
Plugin 'kana/vim-filetype-haskell'

" Python stuff
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'

" C++ stuff
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

filetype plugin indent on
syntax enable

map <Leader>y "+y
map <Leader>p "+p

" Easy toggle of numbers and folding
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set laststatus=2
set statusline=%f\ %h%m%r\ %=%-24([%Y,%{strlen(&fenc)?&fenc:'none'},%{&ff}]%)%-24(C:%-3c\ L:%-11([%l/%L]%)%)%P

nnoremap <Leader>no :nohl<CR>

" Open the corresponding .C/.T/.h file
function! OpenMatching()
    let path=expand("%:h")
    let pattern=expand("%:t:r").".\*"
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

