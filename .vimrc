" Do not make Vim more Vi-compatible
set nocompatible

" Plugins ------------------------------------------------------------------------------------------

" Disable filetype detection required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
if has("win16") || has("win32")
    set rtp+=~\.vim_runtime\bundle\Vundle.vim
    call vundle#begin('~\.vim_runtime\plugins')
else
    set rtp+=~/.vim_runtime/bundle/Vundle.vim
    call vundle#begin('~/.vim_runtime/plugins')
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'NLKNguyen/papercolor-theme'
" Set `background` based on system settings, needs a colorscheme that supports both light and
" dark backgrounds.
Plugin 'vimpostor/vim-lumen'
" Lightline plugin provides an improved status line
Plugin 'itchyny/lightline.vim'
" vim-gitbranch provides name of current git branch to the lightline plugin
Plugin 'itchyny/vim-gitbranch'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'ctrlpvim/ctrlp.vim'
" Quickly and easily switch between buffers
Plugin 'jlanzarotta/bufexplorer'
" Distraction-free writing in Vim.
Plugin 'junegunn/goyo.vim'
" Use latex from Vim
Plugin 'lervag/vimtex'
" Insert or delete brackets, parens, and quotes in pair
Plugin 'LunarWatcher/auto-pairs'
" Syntax file for PlantUML
Plugin 'aklt/plantuml-syntax'


" All Plugins must be added before the following line
call vundle#end()            " required

" Enable filetype plugins after Vundle lines
filetype plugin indent on

" Tabs ---------------------------------------------------------------------------------------------

" Number of spaces that a <Tab> in the file counts for
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.
set smarttab

" Misc editor settings -----------------------------------------------------------------------------

" Forward slash is used when expanding file names.
set shellslash

set colorcolumn=80,100,120

set guifont=Fira_Code_Retina:h12:cANSI:qDRAFT

set encoding=utf-8

" Do not ring the bell (beep or screen flash) for error messages
set noeb
" When no beep or flash is wanted, use:
set vb
set t_vb=

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

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" Enable syntax highlighting
syntax enable 

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Status line --------------------------------------------------------------------------------------

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Search -------------------------------------------------------------------------------------------

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" For regular expressions turn magic on
set magic

" Wrapping and indentation -------------------------------------------------------------------------

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

" Improvements for visual mode ---------------------------------------------------------------------

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Color Scheme -------------------------------------------------------------------------------------

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

" Lightline ----------------------------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], ['filetype', 'fileencoding', 'fileformat'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

" Goyo ---------------------------------------------------------------------------------------------
nnoremap <silent> <Leader>g :Goyo<CR>
let g:goyo_width = 120
let g:goyo_height = 85
let g:goyo_linenr = 1 

" Vimtex -------------------------------------------------------------------------------------------

nnoremap <leader>lb :cclose<CR>
nnoremap <leader>ll :VimtexCompile<CR>
nnoremap <leader>lc :VimtexClean<CR>
nnoremap <leader>lC :VimtexClean!<CR>

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" --------------------------------------------------------------------------------------------------
"
let @i = '0i## [ ] o+0'
let @o = '0i### [ ] o+0'
let @p = '0xi#### [ ] o+0'

" Control font size by Ctrl+Up and Ctrl+Down -------------------------------------------------------

nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

" Change indentation settings for Markdown ---------------------------------------------------------
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 

" Configure blinking cursor for Neovide ------------------------------------------------------------

if exists("g:neovide")
    set guicursor=n:block-blinkwait350-blinkon350-blinkoff350,i:ver25-blinkwait350-blinkon350-blinkoff350
endif
