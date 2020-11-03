" Install vim-plug if not present (bootstrapping a new vim)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup PlugBootstrap
    autocmd!

    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.vim/plugged')
" git gutters!
Plug 'airblade/vim-gitgutter'

" A dark color theme
Plug 'morhetz/gruvbox'
Plug 'rafalbromirski/vim-aurora'

" Comments!
Plug 'tpope/vim-commentary'

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" Open CtrlP with <c-p>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Ignore directories
set wildignore+=*/tmp/*,*/node_modules/*,*/coverage/*
" Dont crawl parent directories
let g:ctrlp_working_path_mode = 'ra'
" CtrlP to show hidden files
let g:ctrlp_show_hidden = 1

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git status in airline
Plug 'tpope/vim-fugitive'

" Improve JSON highlighting
Plug 'leshill/vim-json'

" Autoimport statements for JS
Plug 'Galooshi/vim-import-js', {'do': 'npm i -g import-js'}

" Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \    'extends' : 'jsx',
      \  },
      \}
let g:user_emmet_mode ='a'

" Close buffer without closing vim
Plug 'qpkorr/vim-bufkill'
noremap <leader>w :BD<CR>

" All in one syntax highlighting
Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_flow = 1

" Per project editor config
Plug 'editorconfig/editorconfig-vim'

" Autoclose quotes etc
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'

" Logstash files syntax highlighting
Plug 'robbles/logstash.vim'

" Better Postgres syntax highlighting
Plug 'exu/pgsql.vim'
" Consider all .sql files as Postgres files
let g:sql_type_default = 'pgsql'

Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
" Edit UltiSnips in a vertical split
let g:UltiSnipsEditSplit = "vertical"
" Store snippets where I can find them
let g:UltiSnipsSnippetDirectories = ["~/.vim/UltiSnips", "UltiSnips"]
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<leader-tab>""

" Preview substitutions
Plug 'osyo-manga/vim-over'

" Support PostCSS
Plug 'stephenway/postcss.vim'

" Integrate rubocop with vim
Plug 'ngmy/vim-rubocop'

" Show line indents
Plug 'Yggdroot/indentLine'
" each indent level has a different character
let g:indentLine_char_list = ['▏', '|', '¦', '┆', '┊']

" Autocompletion
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all'  }
nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
nnoremap <buffer> <silent> <leader>oi :YcmCompleter OrganizeImports<CR>

" Prettier formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install'  }
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 0
" Requiring the pragma is annoying
let g:prettier#autoformat_require_pragma = 0

" Scroll position in status line
Plug 'ojroques/vim-scrollstatus'
" and add it to vim-airline
let g:airline_section_x = '%{ScrollStatus()}'

Plug 'vim-latex/vim-latex'
" grep will sometimes skip displaying the file name if you search in a singe
" file. This will confuse Latex-Suite. Set your grep program to always
" generate a file-name.
set grepprg=grep\ -nH\ $*

" Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex'
" instead of 'tex', which results in vim-latex not being loaded. The following
" changes the default filetype back to 'tex'.
let g:tex_flavor = 'latex'

" Highlighting for npmrc, npmignore, npm-debug.log
Plug 'rhysd/npm-filetypes.vim'

" Handle Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Run goimports on save
let g:go_fmt_command = "goimports"

" unix commands to vim commands
Plug 'tpope/vim-eunuch'

" Zeal integration
Plug 'KabbAmine/zeavim.vim'

" Unicode search
Plug 'chrisbra/unicode.vim'

call plug#end()





" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Dont highligh matching parens, it's distracting
let g:loaded_matchparen = 1

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup undofile swapfile
" Keep 50 lines of command line history
set history=50
" Show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" Do incremental searching
set incsearch

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors and switch on
" highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
set autoindent

augroup RestoreCursorPosition
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Count lines
set number

" Enable relative line numbering
set relativenumber

" Clear search highlight with Ctrl-l
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Show suggestions above the command line when hitting <Tab>
set wildmenu

" See https://old.reddit.com/r/vim/wiki/tabstop
" Visual representation for a \t character, 8 to make it be the same on screen
" and on paper
set tabstop=8
" Width when indenting lines with >>
set shiftwidth=2
" When pressing <Tab>, insert that many blanks
set softtabstop=2
set expandtab
set smarttab

" Mark the line limit
set colorcolumn=80

" Enable visual bell and disable audible bell
set visualbell
set noerrorbells

" Use dark background color schemes
set background=dark

" Crontab workaround as per
" http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

colorscheme aurora
" Fix colors with tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Always show vim-airline
set laststatus=2

" Enable 256 colors in vim
set t_Co=256


" write with sudo using :w!!
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" always have cursor in the middle of the window
set scrolloff=9999

augroup AutoRead
  autocmd!

  " Triger `autoread` when files changes on disk
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None "
augroup END

" Folding confuses me
set nofoldenable
