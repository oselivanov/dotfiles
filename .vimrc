" Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

" Hi stranger. If you here by the accident and know how to do some things
" you can see in this file better, do not hesitate to send me a note by the
" email! :)

if (match(system('hostname'), 'oleg-MacBook-Pro') >= 0)
  let g:i_am_home = 1
endif

" TODO(oleg): Switch to vundle.
" Setup pathogen.
call pathogen#infect()

" Setup MatchIt to match not only ({[ ]})
runtime macros/matchit.vim

" Editor defaults.
syntax on
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
set colorcolumn=101
set wildmode=list,full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*/*.pyc,*/*.jpg,*/*.png,*/*.gif
set backspace=indent,eol,start
set nofoldenable
let skip_defaults_vim=1
set viminfo=

" Makes vim more responsive in iTerm2.
set ttyfast
set lazyredraw

" Set better leader.
let mapleader=","

" Turn mouse support on to prevent terminal from receiving events.
set mouse=a

" Unbind mouse wheel events.
nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>

imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>

nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>

" Setup smart indent and fix its issue.
set autoindent
set smartindent
" Fix smartindent for hash key (#).
inoremap # X<BS>#

" Set spelling correction.
set spell
nmap <leader>f 1z=
nmap <leader>F z=

" One line command area.
set cmdheight=1
set shortmess=atI

" Disable swap 'features'.
set nobackup
set nowritebackup
set noswapfile

" Linux settings.
"let g:soarized_termcolors = 16
"set t_Co=16
" Mac settings.
set background=dark
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

" Restore second layout after leaving insert mode.
let g:kls_insertEnterRestoresLast = 1

" Fix navigation through the wrapped lines.
nnoremap j gj
nnoremap k gk

" Disable moving cursor back after returning to the command mode.
"inoremap <Esc> <Esc>g`^

" Remove last search highlight.
" DEBUG: Conflicts with neovim.
" nnoremap <Esc> :noh<Cr>
nnoremap c :nunmap c<Cr>c<Esc>

" Use plain old regex without any magic.
" Hint - do the replaces using :%s//to/g
nnoremap / /\v

" Use * to just highlight occurences, disable jumpimg to the next one.
nnoremap * #*

" Common typo correction.
nnoremap q: :q

" Don't select newline character when using $
vnoremap $ $h

" Use control h/l to navigate in command mode (pretty useful for file renaming).
cnoremap <c-h> <left>
cnoremap <c-l> <right>

" TODO(oleg): Make 0 jumps from first non-blank to line start and back.
nnoremap 0 ^
nnoremap ^ 0

nnoremap > >>
nnoremap < <<

" Working w/ words by default, not w/ characters.
nnoremap h b
nnoremap l e
vnoremap h b
vnoremap l e
nnoremap x "_x

" Tab management.
nnoremap tn :tabnew<cr>
nnoremap tl :tabnext<cr>
nnoremap th :tabprev<cr>
nnoremap t< :tabmove -1<cr>
nnoremap t> :tabmove +1<cr>

" Fast buffer switching and split management.
nnoremap wj <c-w>j
nnoremap wk <c-w>k
nnoremap wh <c-w>h
nnoremap wl <c-w>l
nmap wx <c-w>x
nnoremap wo :call MyOpen()<cr>
nmap wJ :set splitbelow<cr>:split<cr>:call MyOpen()<cr>
nmap wK :set nosplitbelow<cr>:split<cr>:call MyOpen()<cr>
nmap wL :set splitright<cr>:vsplit<cr>:call MyOpen()<cr>
nmap wH :set nosplitright<cr>:vsplit<cr>:call MyOpen()<cr>
"nmap <c-l> <c-w>=:redraw!<cr>
nnoremap <c-l> <c-w>=:call SmartResize()<cr>
" :resize 1000<cr>
nmap <c-w>v <nop>
nmap <c-w>s <nop>
imap <c-w>v <nop>
imap <c-w>s <nop>
vmap <c-w>v <nop>
vmap <c-w>s <nop>
" autocmd FileType nerdtree silent! nmap <buffer> <cr> e
autocmd FileType nerdtree silent! nmap <buffer> l o
autocmd FileType nerdtree silent! nmap <buffer> h o
let NERDTreeShowHidden=1

" Start the find and replace command across the entire file.
vnoremap <leader>r <Esc>:%smagic/<c-r>=GetVisual()<cr>//g<left><left>

" Function to switch between source and header files.
nnoremap <c-y> :call SwitchSourceHeader()<CR>

" Compile latex.
nnoremap <leader>l :call LatexToPdf()<CR>


" Turn on filetype.
filetype on
filetype plugin on

" Cursor line highlighting only in insert mode.
"autocmd BufEnter * resize 1000
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" Setup filetypes for stuff I'm using.
autocmd BufNewFile,BufRead wscript set ft=python
autocmd BufNewFile,BufRead *.ipy set ft=python
autocmd BufNewFile,BufRead *.cc set ft=cpp
autocmd BufNewFile,BufRead *.hx set ft=haxe
autocmd BufNewFile,BufRead *.flagfile set ft=dosini
autocmd BufNewFile,BufRead *.sls set ft=yaml
autocmd BufNewFile,BufRead *.template set ft=json
autocmd BufNewFile,BufRead *.policy set ft=json
autocmd BufNewFile,BufRead *.j2 set ft=jinja2
autocmd BufNewFile,BufRead Saltfile set ft=yaml
autocmd BufNewFile,BufRead roster set ft=yaml
autocmd BufNewFile,BufRead Vagrantfile set ft=ruby

" Auto strip file contents before saving.
" Fortunatelly I don't use whitespace programming language :)
function! MyStripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * silent :call MyStripTrailingWhitespaces()
" autocmd FileType * autocmd BufWritePre <buffer> silent :%s/\s\+$//e

autocmd FileType python setlocal ts=4 sts=4 sw=4 et
autocmd FileType htmldjango setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType jinja2 setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType ruby setlocal iskeyword+=\$ ts=2 sts=2 sw=2 et
autocmd FileType eruby setlocal iskeyword+=\> iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType haskell setlocal ts=4 sts=4 sw=4 et
autocmd FileType cabal setlocal ts=4 sts=4 sw=4 et
autocmd FileType erlang setlocal ts=4 sts=4 sw=4 et
autocmd FileType objc setlocal ts=2 sts=2 sw=2 et
autocmd FileType haxe setlocal ts=2 sts=2 sw=2 et
autocmd FileType cpp setlocal ts=2 sts=2 sw=2 et
autocmd FileType c setlocal ts=2 sts=2 sw=2 et
autocmd FileType glsl setlocal ts=2 sts=2 sw=2 et
autocmd FileType php setlocal iskeyword+=\$ ts=2 sts=2 sw=2 et
autocmd FileType lua setlocal ts=2 sts=2 sw=2 et
autocmd FileType lisp setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType asm setlocal iskeyword+=\- ts=4 sts=4 sw=4 et
autocmd FileType cfg setlocal iskeyword+=\- ts=2 sts=2 sw=2 et

autocmd FileType javascript setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType coffee setlocal ts=4 sts=4 sw=4 et
autocmd FileType html setlocal iskeyword+=\- ts=2 sts=2 sw=2 et
autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 et
autocmd FileType xml setlocal ts=2 sts=2 sw=2 et
autocmd FileType css setlocal iskeyword+=\- ts=2 sts=2 sw=2 et

autocmd FileType vim setlocal ts=2 sts=2 sw=2 et
autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
autocmd FileType make setlocal ts=8 sts=8 sw=8 noet
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
autocmd FileType sh setlocal ts=2 sts=2 sw=2 et
autocmd FileType tex setlocal ts=2 sts=2 sw=2 et tw=79 fo=taw21 "spelllang=en,ru_yo
autocmd FileType text setlocal ts=2 sts=2 sw=2 et tw=79 "spelllang=en,ru_yo

" Markdown preview on write.
let vim_markdown_preview_toggle=2

" Airline settings.
set laststatus=2
if exists("g:i_am_home")
  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#show_buffers=0
  let g:airline#extensions#tabline#tab_min_count=2
  let g:airline_section_x=''
  let g:airline_section_y=''
endif

" Hack to disable parenteses highlight.
let loaded_matchparen=1

" CtrlP plugin settings.
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_regexp=1
" let g:ctrlp_by_filename=1
" let g:ctrlp_max_height=3
" let g:ctrlp_working_path_mode=2
" let g:ctrlp_by_filename=0
" let g:ctrlp_use_caching=0
" let g:ctrlp_clear_cache_on_exit=1
" let g:ctrlp_max_files=5000
" let g:ctrlp_show_hidden=1
" let g:ctrlp_follow_symlinks=1
" let g:ctrlp_user_command = " {
"     \ 'types': {
"       \ 1: ['.git', 'cd %s && git ls-files -cmo --directory | sort | uniq | grep -v "\.\(pyc\|gif\|jpg\|png\|mp3\|avi\|ogv\)$"'],
"       \ },
"     \ 'fallback': 'find -L %s -type f -maxdepth 1',
"     \ }

" Setup NERDTree.
let g:NERDTreeMinimalUI = 1
let g:bufExplorerShowRelativePath=1

" Disable netrw.
let g:loaded_netrwPlugin = 1
" let g:netrw_banner=0
" let g:netrw_list_hide= '.*\.\(pyc\|obj\|o\)$'
" let g:netrw_sort_sequence='[\/]$'

" Syntastic setup.
if exists("g:i_am_home")
  let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': [] }
  nnoremap <leader>f :SyntasticCheck<CR>
  let g:syntastic_check_on_open = 0
  let g:syntastic_python_checkers=['flake8', 'black']
  let g:syntastic_python_flake8_args='--ignore=E203,E266,E501,W503 --max-line-length=90'
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '-std=c++11'
endif

function MyOpen()
  if bufname('%') == ''
    :e .
  else
    :e %:p:h
  endif
endfunction

function SmartResize()
  let col = execute('set columns')
  let new_col = float2nr(str2float(substitute(col, 'columns=', '', '')) * 0.57 + 0.5)
  execute 'vertical resize ' . string(new_col)
  execute 'redraw!'
  echom 'new buffer width is ' . new_col
endfunction

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

" Some code with make possible to run CtrlP from within zsh with <c-p> keystroke
" and close it if you hit <Esc> when CtrlP opened in that vim for the first
" time.
" This snippet doesn't work with mainline ctrlp.vim, small patch should be
" applied.
function! CtrlPExitFunc()
  if !g:ctrlp_file_accepted && g:ctrlp_first_time
    normal! ZZZZ
  endif
  let g:ctrlp_first_time = 0
endfunction
function! CtrlPWithEsc()
  let g:ctrlp_first_time = 1
  let g:ctrlp_buffer_func = {
    \ 'exit':  'CtrlPExitFunc',
    \ }
  CtrlP()
endfunction
command CtrlPWithEsc call CtrlPWithEsc()

function! LatexToPdf()
  silent !/usr/texbin/pdflatex %
  redraw!
endfunction
