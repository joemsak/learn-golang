" Note: first install neobundle with this command:
" curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
"
" Note: It is imperative that your version of vim has lua support
" for the autocompletion engine to work
"
" Note: you will need gocode, godef, goimports, etc. installed
" You can also run :GoInstallBinaries to do it for you

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle "scrooloose/syntastic"
NeoBundle "fatih/vim-go"
NeoBundle "Shougo/neosnippet.vim"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "honza/vim-snippets"
NeoBundleLazy "Shougo/neocomplete.vim", {"autoload":{"insert":1}, "vim_version":'7.3.885'}

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax on

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

" use gofmt compatible tab settings
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" get all the errors from syntastic
autocmd FileType go let g:syntastic_aggregate_errors = 1
autocmd FileType go let g:syntastic_go_checkers = ["go", "govet", "golint"]

" mappings for vim-go
autocmd FileType go nmap <leader>d <plug>(go-doc)
autocmd FileType go nmap <leader>r <plug>(go-run)
autocmd FileType go nmap <leader>b <plug>(go-build)
autocmd FileType go nmap <leader>t <plug>(go-test)
autocmd FileType go nmap <leader>ds <plug>(go-def-split)
autocmd FileType go nmap <leader>dv <plug>(go-def-vertical)
autocmd FileType go nmap <leader>dt <plug>(go-def-tab)
autocmd FileType go nmap gd <plug>(go-def-split)

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" neosnippet
let g:neosnippet#snippets_directory="~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets"
let g:neosnippet#enable_snipmate_compatibility=1

imap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<c-n>" : "\<tab>")
smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : ""
smap <expr> <s-tab> pumvisible() ? "\<c-p>" : ""

let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:neosnippet#snippets_directory .= "," . globpath(&rtp, "gosnippets/snippets")
