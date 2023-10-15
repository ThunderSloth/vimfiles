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

colorscheme slate
augroup SwitchModes
    autocmd InsertEnter * :colorscheme darkblue
    autocmd InsertLeave * :colorscheme slate
augroup END

let g:mapleader = "\\"
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>

augroup templates
au!
" read in template files
autocmd BufNewFile *.* silent! execute '0r $HOME/vimfiles/templates/skeleton.'.expand("<afile>:e")

" parse special text in the templates after the read
autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" F12: clear screen, compile and run code
augroup RunCodeF12
    autocmd!
    autocmd FileType python nnoremap <buffer> <F12> :w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F12> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
    autocmd FileType java nnoremap <buffer> <F12> :w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
    autocmd FileType java imap <buffer> <F12> <esc>:w<CR>:exec '!clear;javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
augroup END

" F11: does not work for some reason
" F10: compile and run, without clear screen
augroup RunCodeF10
    autocmd!
    autocmd FileType python nnoremap <buffer> <F10>:echo "F11 was pressed"<CR> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType java nnoremap <buffer> <F10> :w<CR>:exec '!javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
    autocmd FileType java imap <buffer> <F10> <esc>:w<CR>:exec '!javac' shellescape(expand('%'), 1) '&& java' shellescape(expand('%:r'), 1)<cr>
augroup END
