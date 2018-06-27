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
"Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
"jsx react
Plugin 'mxw/vim-jsx'
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
set hlsearch
set is
set backspace=2
set ruler
set showmode
let python_highlight_all=1
syntax on
colorscheme peachpuff
hi SpellBad ctermfg=118 ctermbg=124
hi SpellCap ctermfg=118 ctermbg=124 

let g:ycm_autoclose_preview_window_after_completion=1
" map \g to got to definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" map \y to get Doc
map <leader>y  :YcmCompleter GetDoc<CR>
" use the python in $PATH, work with virtualenv
let g:ycm_python_binary_path='python'
" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
" Unnecessarary white space
highlight BadWhitespace ctermbg=red guibg=darkred

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8
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
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
"ignore line too long
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E265'
"Apply JSX syntax for .js
let g:jsx_ext_required = 0
