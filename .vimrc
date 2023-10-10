syntax on
"set number "in case I want to see line number on current line and relative on the others
set relativenumber
set spell

set tabstop=4
set shiftwidth=4
set expandtab
set si "smart indent

set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE 
hi CursorColumn cterm=NONE

colo slate "colorscheme

let g:mapleader = "\\"
nnoremap <Leader>o o<ESC>k
nnoremap <Leader>O O<ESC>j

augroup templates
au!
" read in template files
autocmd BufNewFile *.* silent! execute '0r $HOME/vimfiles/templates/skeleton.'.expand("<afile>:e")

" parse special text in the templates after the read
autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" Augroup for running code with F12
augroup RunCodeF12
autocmd!
autocmd FileType python nnoremap <buffer> <F12> :w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F12> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
autocmd FileType java nnoremap <buffer> <F12> :w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
autocmd FileType java imap <buffer> <F12> <esc>:w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
augroup END
