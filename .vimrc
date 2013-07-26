" Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

" Setup pathogen.
call pathogen#infect()

" Editor defaults.
syntax enable
set history=1000
set timeoutlen=250
set wrap
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=10
set wildmode=list,full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*/*.pyc,*/*.jpg,*/*.png,*/*.gif

" Expand keyword symbols list.
set iskeyword+=\$
set iskeyword+=\-

" One line commnand area.
set cmdheight=1
set shortmess=atI

" Disable swap 'features'.
set nobackup
set nowritebackup
set noswapfile

" Setup color scheme.
let g:solarized_termcolors = 16
set t_Co=16
"let g:solarized_contrast='high'
"let g:solarized_visibility='high'
colorscheme solarized
set background=dark
set colorcolumn=81

" Disable parenteses highlight.
let loaded_matchparen=1

" Use system clipboard ("sudo aptitude install vim-gnome" required for Ubuntu).
set clipboard=unnamed

" Turn on filetype.
filetype on
filetype plugin on

" Disable moving cursor back after returning to the command mode.
inoremap <Esc> <Esc>g`^

" Remove last search highlight.
nnoremap <Esc> :noh<Cr>
nnoremap c :nunmap c<Cr>

" Fast buffer switching.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <c-l> <c-n>

nmap <c-w>s :set splitbelow<cr>:split<cr>
nmap <c-w>v :set splitright<cr>:vsplit<cr>

" Setup MatchIt to match not only ({[ ]})
runtime macros/matchit.vim

" Zen-coding setup.
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

" Setup CtrlP plugin.
let g:ctrlp_map = '<c-p>'
let g:ctrlp_regexp=1
let g:ctrlp_by_filename=1
let g:ctrlp_max_height=3
let g:ctrlp_working_path_mode=2
let g:ctrlp_by_filename = 0
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_files=5000
" TODO(oleg): Add sorting by distance against current file.
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files -cmo --directory | sort | uniq | grep -v "\.\(gif\|jpg\|png\|mp3\|avi\|ogv\)$"'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
    \ }
let g:ctrlp_custom_ignore = '\.(jpg\|png\|gif\|mp3\|avi\|ogv)$'

" Setup netrw.
let g:bufExplorerShowRelativePath=1
let g:netrw_banner=0

" Function to switch between source and header files.
function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "m" || expand ("%:e") == "cc" ||
      \ expand ("%:e") == "cpp" || expand ("%:e") == "c")
    silent! find %:t:r.h
    silent! find %:t:r.hpp
  else
    silent! find %:t:r.cc
    silent! find %:t:r.m
    silent! find %:t:r.c
    silent! find %:t:r.cpp
  endif
endfunction
nnoremap <c-y> :call SwitchSourceHeader()<CR>

" Function for lightweight sessions - see homebin/vvim for details.
" Save only few things.
set sessionoptions=blank,buffers,curdir
" Hide buffers instead of closing.
set hidden

function! CloseInactiveAndHiddenBuffers()
  let i = 0
  let n = bufnr('$')
  while i < n
    let i = i + 1
    if bufloaded(i) == 0 || bufwinnr(i) < 0
      exe 'silent! bd ' . i
    endif
  endwhile
endfun

" Function to save current session on exit.
function! SaveSession(name)
  let name = a:name
  silent! call mkdir('~/vim/sessions')
  exe "mksession! ~/.vim/sessions/" . name
endfun

" Function to open a diff on top of commit message.
function! OpenDiff()
  exe "new"
  exe "setf diff"
  exe "silent :0 r !git diff -C -U0 --cached | grep -v \"^diff --git \" | grep -v \"^index \""
  exe "resize 40"
  exe "set ro"
  exe "goto 1"
  exe "autocmd BufHidden COMMIT_EDITMSG :qa"
endfun

function! Fold(num)
  return getline(num)=~'^\\s*def'?'>1':(getline(num+1)=~'^\\s*$'?'<1':'=')
endfun

" Auto-configure buffer settings toward its filetype.
if has("autocmd")
    " Cursor line highlighting only in insert mode.
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline

    " Setup filetypes for stuff I'm using.
    autocmd BufNewFile,BufRead *.cc setfiletype cpp
    autocmd BufNewFile,BufRead *.hx setfiletype haxe
    "autocmd BufNewFile,BufRead *.hx setlocal foldlevelstart=2 foldnestmax=3 foldminlines=2 foldmethod=indent
    autocmd BufNewFile,BufRead *.less setfiletype css
    autocmd BufNewFile,BufRead *.flagfile setfiletype dosini

    autocmd FileType python setlocal ts=4 sts=4 sw=4 et "foldlevelstart=1 foldnestmax=3 foldminlines=2 foldmethod=indent
    " foldexpr=Fold(v:lnum)
    "foldminlines=3 foldmethod=expr foldexpr=getline(v:lnum-1)=~'^\\s*def\ '?'>1':(getline(v:lnum+1)=~'^\\s*$'?'s1':'=')
    autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 et
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
    autocmd FileType eruby setlocal ts=2 sts=2 sw=2 et
    autocmd FileType haskell setlocal ts=2 sts=2 sw=2 et
    autocmd FileType erlang setlocal ts=4 sts=4 sw=4 et
    autocmd FileType objc setlocal ts=2 sts=2 sw=2 et
    autocmd FileType haxe setlocal ts=2 sts=2 sw=2 et
    autocmd FileType cpp setlocal ts=2 sts=2 sw=2 et
    autocmd FileType c setlocal ts=2 sts=2 sw=2 et
    autocmd FileType php setlocal ts=4 sts=4 sw=4 et
    autocmd FileType lua setlocal ts=2 sts=2 sw=2 et

    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 et
    autocmd FileType coffee setlocal ts=4 sts=4 sw=4 et
    autocmd FileType html setlocal ts=2 sts=2 sw=2 et
    autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 et
    autocmd FileType xml setlocal ts=2 sts=2 sw=2 et
    autocmd FileType css setlocal ts=2 sts=2 sw=2 et

	autocmd FileType vim setlocal ts=4 sts=4 sw=4 et
	autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et

    autocmd BufRead,BufNewFile COMMIT_EDITMSG call OpenDiff()

    " Auto-chop before saving for selected filetypes.
    autocmd FileType python,javascript,haskell,c,cpp,php,haxe,vim,apache,html,xhtml,xml,css,ruby,eruby,htmldjango autocmd BufWritePre <buffer> silent :%s/\s\+$//e
endif

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap r <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
