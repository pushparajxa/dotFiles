"/* vim: set filetype=ansible : */
"When finds time read someother options from sensible.vim Configuration

" Pathogen first

"execute pathogen#infect()

" Move horizantally 
" --------------------
" Reference: https://thevaluable.dev/vim-commands-beginner/
" 
" f<character> - find a character after your cursor.
" F<character> - find a character before your cursor.
" t<character> - move to a character after your cursor.
" T<character> - move to a character before your cursor.

" After using one of the last four keystrokes, you can move on the 
" character you’ve chosen with ; to go forward, and , to go backward.

" Movement by sentence
" --------------------
" Referece: https://vim.works/2019/03/03/cursor-movement-in-vim/
"
" ( moves to the previous beginning of a sentence. ) moves to the next end.

 " Want to Delete everything to the end of the sentence? Combine d with the end of sentence movement d) 
 " Want to delete the rest of this sentence and the next one? That’s 2 sentences, so preface it with a 2: 2d)

 " See help sentence for the definition of a “sentence” in Vim.

" Movement by paragraph
" --------------------
" Referece: https://vim.works/2019/03/03/cursor-movement-in-vim/
"
" { moves to line above the paragraph, and } to the bottom.

" This can be combined with verbs and numbers just like sentence movement.

" See help paragraph for the definition of “paragraph” in Vim.


" Move Vertically
" --------------------
" Reference: https://thevaluable.dev/vim-commands-beginner/
"
" CTRL-e - scroll the window downwards.
" CTRL-u - move your cursor upward half a screen.
" CTRL-d - move your cursordownward half a screen.

" Search settings
" ----------------
" Referece: https://thevaluable.dev/vim-search-find-replace/
"
" /search\C ---> Case-sensitive search.
" /search\c ---> Case-insensitive search

" set ignorecase - All your searches will be case-insensitive.
" set smartcase - Your search will be case-sensitive if it contains an uppercase letter.
"  Be aware that ignorecase needs to be set for smartcase to work.
set ignorecase
set smartcase

" search for a word under cursor
" You can also use these two keystrokes in NORMAL mode to search the word under the cursor:

" * - Search forward.
" # - Search backward.

" Wrapping
" ------------
" Reference:
"
" In every other editor I’ve encountered, when you hit the end of a line, and then move your cursor one more character 
" to the right it will wrap around to the start of the next line. When you move it to the start and then go back one 
" more character it will wrap around to the end of the previous line.

" Vim does not do this, by default. Let’s fix that. Add the following line to your .vimrc

set whichwrap=<,>,h,l

" What exactly does that do? Well, whichwrap is a way to tell Vim which keys wrap.
" < and > (in this context) mean the left and right arrow keys. h, and l are our left 
" and right character motion commands. So, this command tells vim that <,>,h,l are the keys 
" which will wrap. The order isn’t important, and the reference docs don’t recommend including 
" h and l but I don’t like inconsistent behavior, so I include them.


" Basic Settings
" ------------------
set nocompatible
set backspace=indent,eol,start
filetype plugin indent on
set ft=ansible
set shell=/bin/zsh
set autoindent
set number
set encoding=utf-8
set incsearch
set hlsearch
"set spell spelllang=en_us
set scrolloff=10 "Number of lines below and above the cursor to be shown.
set autoread
"Enables mouse use in all modes
set mouse-=a
"Set this to the name of your terminal that suppots mouse codes.
set ttymouse=xterm2
"Send more characters for redraws
set ttyfast
"With this you can Yank and use to paste else where.https://github.com/mhinz/vim-galore
set clipboard=unnamed
"#################################
"Bracketed Paste Mode
"#################################
if !exists("g:bracketed_paste_tmux_wrap")
  let g:bracketed_paste_tmux_wrap = 1
endif

function! WrapForTmux(s)
  if !g:bracketed_paste_tmux_wrap || !exists('$TMUX') || system('tmux -V')[5] >= '2'
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_ti .= WrapForTmux("\<Esc>[?2004h")
let &t_te .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
"#################################
"End Bracketed Paste Mode
"#################################
"###NERDTREE###############
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden=1

map <F2> :NERDTreeToggle<CR>
"autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"###NERDTREE###############
"Synatx file for yaml files
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim
"#################################
" Plugin manager
"#################################
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Anisible plugin
Plug 'pearofducks/ansible-vim'

" Initialize plugin system
call plug#end()
"#################################
" End of Plugin manager
"#################################

