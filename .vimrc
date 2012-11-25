" Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

" Setup pathogen.
call pathogen#infect()

" Editor defaults.
syntax enable
set history=1000
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
colorscheme solarized
set background=dark
set colorcolumn=81
set t_Co=16
let g:solarized_termcolors=16

" Disable parenteses highlighting.
let loaded_matchparen=1

" Use system clipboard ("sudo aptitude install vim-gnome" required for Ubuntu).
set clipboard=unnamed

" Turn on filetype.
filetype on
filetype plugin on

" Disable moving cursor back after returning to the command mode.
inoremap <Esc> <Esc>g`^

" Lighting fast movements, disabled for the moment.
"nnoremap K 5k
"nnoremap J 5j
"vnoremap K 5k
"vnoremap J 5j

" Fast buffer switching.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Remove last search highlighting with <\>.
map \ :noh<cr>

" Setup MatchIt to match not only ({[ ]})
runtime macros/matchit.vim

" Zen-coding setup.
let g:user_zen_expandabbr_key = '<c-y>'
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
let g:ctrlp_custom_ignore = '\.jpg$\|\.png$\|\.gif$'
let g:ctrlp_max_files=5000
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
    \ }

" Setup netrw.
let g:bufExplorerShowRelativePath=1
let g:netrw_banner=0

" Function to switch between source and header files.
function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "m" || expand ("%:e") == "cc" ||
      expand ("%:e") == "cpp" || expand ("%:e") == "c")
    silent! find %:t:r.h
    silent! find %:t:r.hpp
  else
    silent! find %:t:r.cc
    silent! find %:t:r.m
    silent! find %:t:r.c
  endif
endfunction
nnoremap <c-r> :call SwitchSourceHeader()<CR>

" Function for lightweight sessions - see homebin/vvim for details.
" Save only few things.
set sessionoptions=blank,buffers,curdir
" Hide buffers instead of closing.
set hidden
" This function was stolen from the web.
function! CloseHiddenBuffers()
  " Figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      exe 'bd ' . b
    endif
  endfor
endfun
" Function to save current session on exit.
function! CleanAndSaveSession(name)
  call CloseHiddenBuffers()
  let name = a:name
  exe "mksession! ~/.vim/sessions/" . name
endfun

" Function to open a diff on top of commit message.
function! OpenDiff()
  exe "new"
  exe "setf diff"
  exe "silent :0 r !git diff -C -U0 --cached | grep -v \"^diff --git \" | grep -v \"^index \""
  exe "resize 50"
  exe "set ro"
  exe "goto 1"
  exe "autocmd BufHidden COMMIT_EDITMSG :qa"
endfun

" Auto-configure buffer settings toward its filetype.
if has("autocmd")
    " Cursor line highlighting only in insert mode.
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline

    " Setup filetypes for stuff I'm using.
    autocmd BufNewFile,BufRead *.cc setfiletype cpp
    autocmd BufNewFile,BufRead *.hx setfiletype haxe
    autocmd BufNewFile,BufRead *.less setfiletype css

    autocmd FileType python setlocal ts=4 sts=4 sw=4 et
    autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 et
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
    autocmd FileType eruby setlocal ts=2 sts=2 sw=2 et
    autocmd FileType haskell setlocal ts=2 sts=2 sw=2 et
    autocmd FileType objc setlocal ts=2 sts=2 sw=2 et
    autocmd FileType cpp setlocal ts=2 sts=2 sw=2 et
    autocmd FileType php setlocal ts=4 sts=4 sw=4 et
    autocmd FileType lua setlocal ts=2 sts=2 sw=2 et

    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 et
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
