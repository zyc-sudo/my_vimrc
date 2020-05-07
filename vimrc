set updatetime=100
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

"Tree
Plugin 'scrooloose/nerdtree'
"Indent guid
Plugin 'nathanaelkane/vim-indent-guides'
"auto complete
Plugin 'Valloric/YouCompleteMe'
"Folding
Plugin 'tmhedberg/SimpylFold'
"Python auto indent
Plugin 'vim-scripts/indentpython.vim'
"error highlight
Plugin 'scrooloose/syntastic'
"Python standard
Plugin 'nvie/vim-flake8'
"Git
Plugin 'tpope/vim-fugitive'
" Bottom bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Vim surround
Plugin 'tpope/vim-surround'
" tmux
Bundle 'christoomey/vim-tmux-navigator'
" Multiple cursors
Plugin 'terryma/vim-multiple-cursors'
" Vim gitgutter
Plugin 'airblade/vim-gitgutter'
" Color
Plugin 'morhetz/gruvbox'
" AutoPEP8 fix
Plugin 'tell-k/vim-autopep8'
" Repeat .
Plugin 'tpope/vim-repeat'
" go
Plugin 'fatih/vim-go'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set nu
set background=dark
colorscheme gruvbox
set hlsearch
set is
set backspace=2
set ruler
set showmode
set pastetoggle=<F3>
let python_highlight_all=1
syntax on
"hi SpellBad ctermfg=118 ctermbg=124
"hi SpellCap ctermfg=118 ctermbg=124 

let g:ycm_autoclose_preview_window_after_completion=1
" map \g to got to definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" map \y to get Doc
map <leader>y  :YcmCompleter GetDoc<CR>
" use the python in $PATH, work with virtualenv
let g:ycm_python_binary_path='python3'
" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
" Unnecessarary white space
highlight BadWhitespace ctermbg=red guibg=darkred

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=200 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set autoindent |
    \ set fileformat=unix |

function! StartUp()
	if 0 == argc()
		NERDTree
	end
endfunction

autocmd VimEnter * call StartUp()
" YCM
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
"ignore line too long
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E265'
let g:syntastic_python_checkers=['python']
"Apply JSX syntax for .js
let g:jsx_ext_required = 0
"Repeat.vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
au BufNewFile,BufRead Jenkinsfile setf groovy

" go
let g:go_def_mode = 'gopls'
" map \t to 
map <leader>t  : GoDebugTest <CR>
" map \d to 
map <leader>d  : GoDebugStart <CR>
" map \x to 
map <leader>x  : GoDebugStop <CR>

" Don't clear the clipboard on quiting
autocmd VimLeave * call system("xsel -ib", getreg('+'))
" vim-go debugger
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }
