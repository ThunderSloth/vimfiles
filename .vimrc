""""""""""""""""""""""""""""""""""""""""
"              GENERAL                 "
""""""""""""""""""""""""""""""""""""""""
syntax on
set relativenumber
set spell

set smartindent
set expandtab

""""""""""""""""""""""""""""""""""""""""
"              PYTHON                  "
""""""""""""""""""""""""""""""""""""""""
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal colorcolumn=88
 
""""""""""""""""""""""""""""""""""""""""
"               JAVA                   "
""""""""""""""""""""""""""""""""""""""""
autocmd FileType java setlocal shiftwidth=2
autocmd FileType java setlocal softtabstop=2
autocmd FileType java setlocal tabstop=2
autocmd FileType java setlocal colorcolumn=100

""""""""""""""""""""""""""""""""""""""""
"              DISPLAY                 "
""""""""""""""""""""""""""""""""""""""""
set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE 
hi CursorColumn cterm=NONE
set fillchars+=vert:\   

colorscheme iceberg
""""""""""""""""""""""""""""""""""""""""
"            SKELETONS                 "
""""""""""""""""""""""""""""""""""""""""
augroup templates
    au!
    " read in template files
    autocmd BufNewFile *.* silent! execute '0r $HOME/vimfiles/templates/skeleton.'.expand("<afile>:e")
    " parse special text in the templates after the read
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

""""""""""""""""""""""""""""""""""""""""
"             MAPPINGS                 "
""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\\"
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>
nnoremap <leader>f :call RunFixer()<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" F12: clear screen, compile and run code
augroup RunCodeF12
    autocmd!
    autocmd FileType python nnoremap <buffer> <F12> :w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F12> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
    autocmd FileType java nnoremap <buffer> <F12> :w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
    autocmd FileType java imap <buffer> <F12> <esc>:w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
augroup END

" F11: currently tied to system-wide mapping for something
" F10: run, without compile and clear screen
augroup RunCodeF10
    autocmd!
    autocmd FileType python nnoremap <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType java nnoremap <buffer> <F10> :w<CR>:!java <c-r>=shellescape(expand('%'), 1)<CR><CR>
    autocmd FileType java imap <buffer> <F10> <Esc>:w<CR>:!java <c-r>=shellescape(expand('%'), 1)<CR><CR>
augroup END

""""""""""""""""""""""""""""""""""""""""
"              PLUGINS                 "
""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" Plugin configurations
     Plug 'itchyny/lightline.vim'
     Plug 'preservim/nerdtree'
     Plug 'ervandew/supertab'
call plug#end()

"highlight Directory ctermfg=cyan
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
""""""""""""""""""""""""""""""""""""""""
"             FUNCTIONS                "
""""""""""""""""""""""""""""""""""""""""
function! RunFixer()
    w    
    if &filetype ==# 'java'
        silent !java -jar ~/google-java-format-1.18.1-all-deps.jar -i %
    elseif &filetype ==# 'python'
        silent !black %
    " Add more file type checks and fixer commands as needed
    else
        echo "No fixer defined for this file type"
    endif
    " Reload the file to reflect the changes made by the fixer
    e
    redraw!
endfunction
