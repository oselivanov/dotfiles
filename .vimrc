" Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

" Hi stranger. If you here by the accident and know how to do some things
" you can see in this file better, do not hesistate to write me few words by
" email! :)

" TODO(oleg): Switch to vundle.
" Setup pathogen.
call pathogen#infect()

" Setup MatchIt to match not only ({[ ]})
runtime macros/matchit.vim

" Editor defaults.
syntax enable
set history=1000
set timeoutlen=500
set ttimeoutlen=0
set wrap
set expandtab
set shiftwidth=2
set number
set hlsearch
set ignorecase
set smartcase
set scrolloff=10
set colorcolumn=81
set wildmode=list,full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*/*.pyc,*/*.jpg,*/*.png,*/*.gif
set backspace=indent,eol,start
set nofoldenable

" Makes vim more responsive in iTerm2.
set ttyfast
set lazyredraw

" Setup smart indent and fix its issue.
set autoindent
set smartindent
" Fix smartindent for hash key (#).
inoremap # X<BS>#

" One line commnand area.
set cmdheight=1
set shortmess=atI

" Disable swap 'features'.
set nobackup
set nowritebackup
set noswapfile

" Linux settings.
"let g:solarized_termcolors = 16
"set t_Co=16
" Mac settings.
set background=light
colorscheme solarized
let g:solarized_visibility="high"
let g:solarized_contrast="high"
" TODO(oleg): Use conditional setup.

" Save only few things.
set sessionoptions=blank,buffers,curdir,tabpages,winsize
" Hide buffers instead of closing.
set hidden

" Use system clipboard ("sudo aptitude install vim-gnome" required for Ubuntu).
set clipboard=unnamed


" Fix navigation through the wrapped lines.
nnoremap j gj
nnoremap k gk

" Disable moving cursor back after returning to the command mode.
inoremap <Esc> <Esc>g`^

" Remove last search highlight.
nnoremap <Esc> :noh<Cr>
nnoremap c :nunmap c<Cr>

" Use plain old regex without any magic.
" Hint - do the replaces using :%s//to/g
nnoremap / /\v

" Use control h/l to navigate in command mode (pretty useful for file renaming).
cnoremap <c-h> <left>
cnoremap <c-l> <right>

" TODO(oleg): Make 0 jumps from first non-blank to line start and back.
nnoremap 0 ^
nnoremap ^ 0

nnoremap > >>
nnoremap < <<

" Word walking by default, for char walking I'm using space.
nnoremap h b
nnoremap l w
nnoremap L e
nnoremap H b
vnoremap h b
vnoremap l w
vnoremap L e
vnoremap H b

" Fast buffer switching.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Tab management.
nnoremap tn :tabnew<cr>
nnoremap tl :tabnext<cr>
nnoremap th :tabprev<cr>

" Split management.
nmap <c-w>v <nop>
nmap <c-w>s <nop>
imap <c-w>v <nop>
imap <c-w>s <nop>
vmap <c-w>v <nop>
vmap <c-w>s <nop>
nmap wj :set splitbelow<cr>:split<cr>
nmap wk :set nosplitbelow<cr>:split<cr>
nmap wl :set splitright<cr>:vsplit<cr>
nmap wh :set nosplitright<cr>:vsplit<cr>
nmap wx <c-w>x

" Start the find and replace command across the entire file.
vnoremap <leader>r <Esc>:%smagic/<c-r>=GetVisual()<cr>//g<left><left>

" Function to switch between source and header files.
nnoremap <c-y> :call SwitchSourceHeader()<CR>


" Turn on filetype.
filetype on
filetype plugin on

" Cursor line highlighting only in insert mode.
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" Auto strip file contents before saving for selected filetypes.
autocmd FileType python,javascript,haskell,c,cpp,php,haxe,vim,apache,html,xhtml,xml,css,less,ruby,eruby,htmldjango,sh autocmd BufWritePre <buffer> silent :%s/\s\+$//e

" Setup filetypes for stuff I'm using.
autocmd BufNewFile,BufRead wscript setfiletype python
autocmd BufNewFile,BufRead *.cc setfiletype cpp
autocmd BufNewFile,BufRead *.hx setfiletype haxe
autocmd BufNewFile,BufRead *.flagfile setfiletype dosini

autocmd FileType python setlocal ts=4 sts=4 sw=4 et
autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 et
autocmd FileType ruby setlocal iskeyword+=\$ ts=2 sts=2 sw=2 et
autocmd FileType eruby setlocal iskeyword+=\> iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType haskell setlocal ts=4 sts=4 sw=4 et
autocmd FileType cabal setlocal ts=4 sts=4 sw=4 et
autocmd FileType erlang setlocal ts=4 sts=4 sw=4 et
autocmd FileType objc setlocal ts=2 sts=2 sw=2 et
autocmd FileType haxe setlocal ts=2 sts=2 sw=2 et
autocmd FileType cpp setlocal ts=2 sts=2 sw=2 et
autocmd FileType c setlocal ts=2 sts=2 sw=2 et
autocmd FileType php setlocal iskeyword+=\$ ts=2 sts=2 sw=2 et
autocmd FileType lua setlocal ts=2 sts=2 sw=2 et
autocmd FileType lisp setlocal iskeyword+=\- ts=2 sts=2 sw=2 et

autocmd FileType javascript setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType coffee setlocal ts=4 sts=4 sw=4 et
autocmd FileType html setlocal iskeyword+=\> iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 et
autocmd FileType xml setlocal ts=2 sts=2 sw=2 et
autocmd FileType css setlocal iskeyword+=\- ts=2 sts=2 sw=2 et

autocmd FileType vim setlocal ts=4 sts=4 sw=4 et
autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
autocmd FileType sh setlocal ts=2 sts=2 sw=2 et

" Airline settings.
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_min_count=2

" Hack to disable parenteses highlight.
let loaded_matchparen=1

" CtrlP plugin settings.
let g:ctrlp_map = '<c-p>'
let g:ctrlp_regexp=1
let g:ctrlp_by_filename=1
let g:ctrlp_max_height=3
let g:ctrlp_working_path_mode=2
let g:ctrlp_by_filename=0
let g:ctrlp_use_caching=0
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_files=5000
let g:ctrlp_follow_symlinks=1
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files -cmo --directory | sort | uniq | grep -v "\.\(gif\|jpg\|png\|mp3\|avi\|ogv\)$"'],
      \ },
    \ 'fallback': 'find %s -type f -maxdepth 1',
    \ }
let g:ctrlp_custom_ignore = '\.(jpg\|png\|gif\|mp3\|avi\|ogv\|pyc)$'

" Setup netrw.
let g:bufExplorerShowRelativePath=1
let g:netrw_banner=0

" Syntactic setup.
let g:syntastic_python_checkers=['flake8']
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_python_flake8_args='--ignore=E126,E128,E131 --max-line-length=80'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'


" This function is used for lightweight sessions - see homebin/vvim for details.
function! CloseInactiveAndHiddenBuffers()
  let l:buffers = range(1, bufnr('$'))

  let l:currentTab = tabpagenr()
  execute 'tabfirst'
  try
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1
      execute 'tabnext'

      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    if len(l:buffers)
      execute 'silent! bwipeout' join(l:buffers)
    endif
  finally
    execute 'tabfirst'
    execute 'tabnext' . l:currentTab
  endtry
endfunction

" Function to save current session on exit.
function! SaveSession(name)
  let name = a:name
  silent! call mkdir('~/.vim/sessions')
  exe "mksession! ~/.vim/sessions/" . name
endfun

function! SwitchSourceHeader()
  " TODO(oleg): Change this hackish approach.
  if expand ("%:e") == "less" || expand ("%:e") == "css"
    let fn = substitute(expand("%:t:r"), "-", "_", "g")
    execute "silent! find app/assets/javascripts/store/widgets/" . fn . ".js"
    execute "silent! find app/assets/javascripts/store/" . fn . ".js"
  elseif expand ("%:e") == "js"
    let fn = substitute(expand("%:t:r"), "_", "-", "g")
    execute "silent! find app/assets/stylesheets/store/widgets/" . fn . ".less"
    execute "silent! find app/assets/stylesheets/store/widgets/" . fn . ".css"
    execute "silent! find app/assets/stylesheets/store/" . fn . ".less"
    execute "silent! find app/assets/stylesheets/store/" . fn . ".css"
  elseif (expand ("%:e") == "m" || expand ("%:e") == "cc" ||
      \ expand ("%:e") == "cpp" || expand ("%:e") == "c")
    silent! find %:t:r.h
    silent! find %:t:r.hpp
  elseif expand ("%:e") == "h" || expand ("%:e") == "hpp"
    silent! find %:t:r.cc
    silent! find %:t:r.m
    silent! find %:t:r.c
    silent! find %:t:r.cpp
  endif
endfunction

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool.
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
" This function passed the visual block through a string escape function.
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard.
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register.
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back.
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  " Escape any special characters in the selection.
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction
