syntax on
set relativenumber
set spell

" Python settings
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal colorcolumn=79
 
" Java settings
autocmd FileType java setlocal shiftwidth=2
autocmd FileType java setlocal softtabstop=2
autocmd FileType java setlocal tabstop=2
autocmd FileType java setlocal colorcolumn=100

set smartindent
set expandtab

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
" F10: run, without compile and clear screen
augroup RunCodeF10
    autocmd!
    autocmd FileType python nnoremap <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType java nnoremap <buffer> <F10> :w<CR>:!java <c-r>=shellescape(expand('%'), 1)<CR><CR>
    autocmd FileType java imap <buffer> <F10> <Esc>:w<CR>:!java <c-r>=shellescape(expand('%'), 1)<CR><CR>
augroup END
call plug#begin('~/.vim/plugged')
" Plugin configurations
    Plug 'vim-syntastic/syntastic'
call plug#end()
" ALE: reasonable defaults from webinstall.dev/vim-ale
source ~/.vim/plugins/ale.vim
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath =  '/Users/elibell/checkstyle/checkstyle-10.12.4-all.jar'
let g:syntastic_java_checkstyle_conf_file = '/Users/elibell/checkstyle/global-checkstyle.xml'
let g:syntastic_check_on_open = 1
let g:ale_linters = {
    \ 'java': ['checkstyle'],
    \ }
