" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc


" vim-plug
call plug#begin()
Plug 'tpope/vim-fugitive'                 " Git
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '/opt/fzf' " Fuzzy search. fzf needs to be installed first (https://github.com/junegunn/fzf#using-git)
Plug 'junegunn/fzf.vim'
" PlugUpgrade " Upgrade vim-plug itself
" PlugUpdate " Install or update plugins
call plug#end()

" Configure plugins

let g:airline_theme='simple'
let g:airline#extensions#ale#enabled = 1

" exit to normal mode with 'jj' (insert mode and terminal mode)
inoremap jj <ESC>
tnoremap jj <C-\><C-n>
set number " show line numbers
set numberwidth=5

" show context around current cursor position
set scrolloff=8
set sidescrolloff=16

set laststatus=2 " always show all statuslines
set termguicolors " terminal true colors
set synmaxcol=512 " don't syntax highlight long lines

set wildignorecase " case insensitive tab completion

" wildignore prevents things from showing up in cmd completion
" It's for things you'd NEVER open in Vim, like caches and binary files

" Binary
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Cache
set wildignore+=.sass-cache
set wildignore+=npm-debug.log
" Compiled
set wildignore+=*.min.*,*-min.*
" Temp/System
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock


