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

" Do not ring the bell (beep or screen flash) for error messages
set noeb
" When no beep or flash is wanted, use:
set vb t_vb=

" Disable folding i.e in Markdown
set nofoldenable

" precede each line with its line number
set number

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

" Set background based on Windows system settings
if system("powershell.exe Get-ItemProperty -Path
    \ \" HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\"
    \ -Name AppsUseLightTheme | findstr AppsUse ") == "AppsUseLightTheme : 0\n"
   set background=dark
else
   set background=light
endif

colorscheme papercolor

filetype plugin indent on    " required

