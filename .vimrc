  " configure from sensible.vim
  if has('autocmd')
      filetype plugin indent on
  endif
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif

  " Use :help 'option' to see the documentation for the given option.

  " Tab configure for 4 space
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set smarttab
  set autoindent
  set smartindent

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
  colorscheme desert
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
    map <esc> :noh <CR>

  "netrw confing
  let g:netrw_keepdir = 0
  let g:netrw_winsize = 30
  let g:netrw_banner = 0
  nnoremap <leader>nw :Lexplore %:p:h<CR>
  nnoremap <Leader>nh :Lexplore<CR>

  " vtr to tmux
  nnoremap <leader>osr :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<cr>
  nnoremap <leader>sl :VtrSendLinesToRunner<cr>
  noremap <leader>va :VtrAttachToPane<cr>
  nnoremap <leader>sc :VtrSendCommandToRunner<cr>
  nnoremap <leader>kc :VtrFlushCommand<cr>
  nnoremap <leader>ksr :VtrKillRunner<cr>
  nnoremap <leader>fr :VtrFocusRunner<cr>

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " zoom a vim pane, <C-w>= to re-balance
  nnoremap <leader>- :wincmd -<cr>:wincmd \|<cr>
  nnoremap <leader>= :wincmd =<cr>
  
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
  call plug#end()



























