" Do not make Vim more Vi-compatible
set nocompatible

" Forward slash is used when expanding file names.
set shellslash

set colorcolumn=80,100,120

set guifont=Fira_Code_Retina:h9:cANSI:qDRAFT

set encoding=utf-8

" Number of spaces that a <Tab> in the file counts for
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
set smarttab

" Do not ring the bell (beep or screen flash) for error messages
set noeb
" When no beep or flash is wanted, use:
set vb t_vb=

" Disable folding i.e in Markdown
set nofoldenable

" precede each line with its line number
set number

" Sets how many lines of history VIM has to remember
set history=500

" Strings to use in 'list' mode and for the |:list| command.  It is a
" comma-separated list of string settings.
if has('gui_running')
  set list listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
else
  set list listchars=tab:->,eol:§,nbsp:.,trail:.,extends:>,precedes:<
endif

" Remove parts of GUI
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "remove scrollbar

" Disable filetype detection required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=C:\code\knobs\runtime\bundle\Vundle.vim
call vundle#begin('C:\code\knobs\runtime\plugins')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'NLKNguyen/papercolor-theme'
" Set `background` based on system settings, needs a colorscheme that supports both light and
" dark backgrounds.
Plugin 'vimpostor/vim-lumen'

" All Plugins must be added before the following line
call vundle#end()            " required

" Enable filetype plugins after Vundle lines
filetype plugin indent on

" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
let mapleader = ","

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" When 'wildmenu' is on, command-line completion operates in an enhanced
" mode.  On pressing 'wildchar' (usually <Tab>) to invoke completion,
" the possible matches are shown just above the command line, with the
" first match highlighted (overwriting the status line, if there is one)
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 

" Enable syntax highlighting
syntax enable 

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" When on, lines longer than the width of the window will wrap and
" displaying continues on the next line.
set wrap
" If on, Vim will wrap long lines at a character in 'breakat' rather
" than at the last character that fits on the screen.  Unlike
set linebreak
" String to put at the start of lines that have been wrapped.
set showbreak=>
" Every wrapped line will continue visually indented (same amount of
" space as the beginning of that line), thus preserving horizontal blocks
" of text.
set breakindent
" Maximum width of text that is being inserted.  A longer line will be
" broken after white space to get this width.  A zero value disables
" this.
set textwidth=120
" Copy indent from current line when starting a new line (typing <CR>
" in Insert mode or when using the "o" or "O" command).  If you do not
set autoindent
" Do smart autoindenting when starting a new line.  Works for C-like
" programs, but can also be used for other languages.  'cindent' does
set smartindent

if has('win32')
" Set background based on Windows system settings
    if system("powershell.exe Get-ItemProperty -Path
        \ \" HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\"
        \ -Name AppsUseLightTheme | findstr AppsUse ") == "AppsUseLightTheme : 0\n"
    set background=dark
    else
    set background=light
    endif
endif

colorscheme papercolor

