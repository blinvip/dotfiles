" configure from sensible.vim
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"Title terminal windows base on vim filename
set title

"Line width for commits
autocmd Filetype gitcommit setlocal spell textwidth=72


" Fold configure
set foldmethod=indent " Folding based on indentation.
set foldlevelstart=10 " Fold only long blocks of code.
set foldnestmax=10 " Folds can be nested, this ensures max 10 nested folds.

" Splitting Panes
set splitright " Open a new vertical split on the right
set splitbelow " Open a new vertical split below.

" Turn off swap files and backups.
set noswapfile
set nobackup
set nowritebackup

" Hybrid number
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" configure tab spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set autoindent

set backspace=indent,eol,start
set complete-=i

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
nmap <leader>h :nohlsearch<cr>

set laststatus=2
set ruler
set wildmenu
set wildmode=full

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Set statusline mode
set noshowmode

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" Vim custom configure
" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

set background=dark
"for comments in virtual block mode
set virtualedit+=block


imap jk <esc>
imap kj <esc>
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>

let mapleader = "\<Space>"
nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap 0 ^

" noh - no highlight
" map <esc> :noh <CR>

"netrw confing
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
nnoremap <leader>nw :Lexplore %:p:h<CR>
nnoremap <Leader>nh :Lexplore<CR>

" vtr to tmux
nnoremap <leader>osr :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<cr>
noremap <C-f> :VtrSendLinesToRunner<cr>
noremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>vs :VtrSendCommandToRunner<cr>
nnoremap <leader>fc :VtrFlushCommand<cr>
nnoremap <leader>vk :VtrKillRunner<cr>
nnoremap <leader>fr :VtrFocusRunner<cr>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd -<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Git next conflict
nnoremap <leader>gnc :GitNextConflict<cr>

" Trim whitespace
nnoremap <leader>cs :StripWhitespace<cr>

" Indent the whole file
nnoremap <leader>i mmgg=G`m<cr>

" Paste
nnoremap <leader>p :set paste<cr>o<esc>"*]p:set nopaste<cr>

" Coc extensions
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-tailwindcss',
      \ 'coc-elixir',
      \ 'coc-svelte',
      \ 'coc-html',
      \ 'coc-yaml',
      \ 'coc-vimlsp',
      \ 'coc-svg',
      \ 'coc-lists',
      \ 'coc-json',
      \ 'coc-yank',
      \ 'coc-highlight',
      \ 'coc-solargraph',
      \ ]
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! s:RestartCoc() abort
  silent! CocRestart
  echohl String | echom 'Restarting COC...' | echohl None
endfunction
command! RestartCoc call s:RestartCoc()
nnoremap <leader>re :RestartCoc<cr>

" lightline configuration
let g:lightline = {
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
        \ 'colorscheme': 'wombat',
        \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'gitbranch', 'conflicted', 'readonly', 'filename', 'modified' ] ],
          \   'right': [ [ 'lineinfo' ],
          \              [ 'percent' ] ]
          \ },
          \ 'inactive': {
            \ 'left': [ [ 'filename', 'conflicted' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ] ]
            \  },
            \  'component_function': {
              \  'gitbranch': 'FugitiveHead',
              \  'conflicted': 'ConflictedVersion'
              \ },
              \  'component': {
                \  'lineinfo': '%3l:%-2v%<',
                \ },
                \ }

let g:sessions_dir = '~/vim-sessions'

" Remaps for Sessions
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
nnoremap <Leader>sp :Obsession<CR>

" Our custom TabLine function
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  let s .= '%=' " Right-align after this

  if exists('g:this_obsession')
    let s .= '%#diffadd#' " Use the "DiffAdd" color if in a session
  endif

  " add vim-obsession status if available
  if exists(':Obsession')
    let s .= "%{ObsessionStatus()}"
    if exists('v:this_session') && v:this_session != ''
      let s:obsession_string = v:this_session
      let s:obsession_parts = split(s:obsession_string, '/')
      let s:obsession_filename = s:obsession_parts[-1]
      let s .= ' ' . s:obsession_filename . ' '
      let s .= '%*' " Restore default color
    endif
  endif
  return s
endfunction

" Required for MyTabLine()
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
Plug 'christoomey/vim-tmux-runner'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-runner'
Plug 'junegunn/fzf'
Plug 'inkarkat/vim-replacewithregister'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'christianrondeau/vim-base64'
Plug 'jlanzarotta/bufexplorer'
Plug 'christoomey/vim-conflicted'
Plug 'itchyny/lightline.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

call plug#end()
" autocmd User VimConflicted call s:setupConflicted()
colorscheme jellybeans
