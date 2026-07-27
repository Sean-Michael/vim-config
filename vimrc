" =============================================================================
"  ~/.vimrc — Comfy IDE-ish setup for Python / TypeScript / Markdown
"  Theme: Nord  ·  Plugin manager: vim-plug  ·  LSP/completion: coc.nvim
" =============================================================================
"  First-time setup:
"    1. Install vim-plug:
"         curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    2. Drop this file at ~/.vimrc
"    3. Open vim and run :PlugInstall
"    4. Then run :CocInstall coc-pyright coc-tsserver coc-json coc-html
"                            coc-css coc-eslint coc-prettier coc-markdownlint
" =============================================================================

" -----------------------------------------------------------------------------
" Bootstrap & sanity
" -----------------------------------------------------------------------------
set nocompatible              " no vi compat — modern vim behavior
filetype off

" Make sure vim-plug exists; if not, hint at the install command on startup.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !echo "vim-plug not found. See top of ~/.vimrc for install command."
endif

" -----------------------------------------------------------------------------
" Plugins (managed by vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" --- Look & feel
Plug 'arcticicestudio/nord-vim'         " Nord colorscheme
Plug 'vim-airline/vim-airline'          " status line
Plug 'vim-airline/vim-airline-themes'   " airline themes (incl. nord)
Plug 'ryanoasis/vim-devicons'           " filetype icons (needs a Nerd Font)
Plug 'Yggdroot/indentLine'              " thin vertical guides on indents

" --- Core editing UX
Plug 'tpope/vim-sensible'               " baseline sane defaults
Plug 'tpope/vim-surround'               " cs'\" csw( ds( etc.
Plug 'tpope/vim-commentary'             " gc / gcc to (un)comment
Plug 'tpope/vim-repeat'                 " . repeats plugin actions too
Plug 'jiangmiao/auto-pairs'             " auto-close brackets/quotes
Plug 'editorconfig/editorconfig-vim'    " honors .editorconfig

" --- Navigation
Plug 'preservim/nerdtree'               " file explorer side panel
Plug 'preservim/nerdtree-git-plugin'    " git status in NERDTree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                 " :Files :Rg :Buffers :GFiles

" --- Git
Plug 'tpope/vim-fugitive'               " :Git blame, :Git status, etc.
Plug 'airblade/vim-gitgutter'           " +/-/~ in the sign column

" --- Language / syntax / LSP
Plug 'sheerun/vim-polyglot'             " syntax for ~600 languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP + autocomplete

" --- Markdown
Plug 'preservim/vim-markdown'           " richer .md syntax + folding
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

filetype plugin indent on

" -----------------------------------------------------------------------------
" General settings
" -----------------------------------------------------------------------------
syntax on
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set number relativenumber                " hybrid line numbers
set cursorline                           " highlight current line
set scrolloff=8 sidescrolloff=8          " keep cursor away from edges
set wrap linebreak                       " soft wrap at word boundaries
set nofoldenable                         " don't fold by default — annoying
set signcolumn=yes                       " always show gutter (no jitter)

set hidden                               " let buffers stay loaded in bg
set mouse=a                              " mouse works everywhere
set clipboard=unnamed                    " yank → system clipboard (macOS)
set updatetime=300                       " snappier coc / gitgutter
set timeoutlen=500                       " faster which-key feel
set shortmess+=c                         " quieter completion messages

set splitright splitbelow                " new splits open right/below
set undofile                             " persistent undo
set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" Search
set ignorecase smartcase
set incsearch hlsearch

" Indentation defaults — language ftplugins below override per-filetype
set expandtab smarttab
set shiftwidth=4 tabstop=4 softtabstop=4
set autoindent smartindent

" Performance
set lazyredraw
set ttyfast
set synmaxcol=300

" Make undo/backup/swap dirs exist
silent !mkdir -p ~/.vim/undo ~/.vim/backup ~/.vim/swap

" -----------------------------------------------------------------------------
" Colors — Nord Light (easy on the eyes in bright rooms, high contrast)
"   The light scheme lives at ~/.vim/colors/nord-light.vim (self-contained).
"   To go back to dark Nord: set background=dark | colorscheme nord
" -----------------------------------------------------------------------------
if (has("termguicolors"))
  set termguicolors
endif
set background=light
silent! colorscheme nord-light

" Subtle tweaks layered on top of the scheme
augroup nord_overrides
  autocmd!
  " Keep the current-line number obvious without shouting
  autocmd ColorScheme nord-light highlight CursorLineNr guifg=#3B5C86 gui=bold
  " Let the sign/gutter column blend into the background (no jitter/edges)
  autocmd ColorScheme nord-light highlight SignColumn guibg=NONE
  autocmd ColorScheme nord-light highlight GitGutterAdd    guibg=NONE
  autocmd ColorScheme nord-light highlight GitGutterChange guibg=NONE
  autocmd ColorScheme nord-light highlight GitGutterDelete guibg=NONE
augroup END

" -----------------------------------------------------------------------------
" Airline (statusline)
" -----------------------------------------------------------------------------
let g:airline_theme = 'sol'   " light statusline to match nord-light (was 'nord')
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1

" -----------------------------------------------------------------------------
" Leader & general keymaps
" -----------------------------------------------------------------------------
let mapleader = " "        " <Space> as leader

" Quality of life
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>x :x<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Move between splits with Ctrl-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer nav
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" Keep cursor centered on big jumps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Stay in visual when indenting
vnoremap < <gv
vnoremap > >gv

" Yank to system clipboard (explicit)
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.DS_Store$', 'node_modules', '\.git$']
let NERDTreeWinSize = 32

" Close vim if NERDTree is the last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" -----------------------------------------------------------------------------
" fzf
" -----------------------------------------------------------------------------
nnoremap <silent> <C-p>      :Files<CR>
nnoremap <silent> <leader>p  :Files<CR>
nnoremap <silent> <leader>b  :Buffers<CR>
nnoremap <silent> <leader>g  :GFiles<CR>
nnoremap <silent> <leader>r  :Rg<CR>
nnoremap <silent> <leader>/  :BLines<CR>

let g:fzf_layout = { 'down': '40%' }

" Use ripgrep if available — respects .gitignore, faster
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
endif

" -----------------------------------------------------------------------------
" Git (fugitive + gitgutter)
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gd :Gdiffsplit<CR>
nnoremap <silent> <leader>gl :Git log --oneline<CR>

let g:gitgutter_sign_added              = '┃'
let g:gitgutter_sign_modified           = '┃'
let g:gitgutter_sign_removed            = '_'
let g:gitgutter_sign_modified_removed   = '┃'

" -----------------------------------------------------------------------------
" coc.nvim (LSP, completion, diagnostics)
" -----------------------------------------------------------------------------
" Recommended global extensions — install with :CocInstall <name>
let g:coc_global_extensions = [
      \ 'coc-pyright',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-markdownlint',
      \ ]

" Tab to navigate completion menu / trigger snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion manually
inoremap <silent><expr> <C-Space> coc#refresh()

" Goto navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Hover docs
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Diagnostics nav
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Rename, format, code actions
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>fm <Plug>(coc-format)
xmap <leader>fm <Plug>(coc-format-selected)

" Highlight symbol & references on cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" -----------------------------------------------------------------------------
" indentLine
" -----------------------------------------------------------------------------
let g:indentLine_char = '│'
let g:indentLine_color_gui = '#C4CCDA'   " faint slate — visible on light bg, not distracting
let g:indentLine_fileTypeExclude = ['markdown', 'json', 'help', 'startify', 'nerdtree']

" -----------------------------------------------------------------------------
" Filetype-specific tweaks
" -----------------------------------------------------------------------------
augroup filetype_settings
  autocmd!
  " Python — PEP8-ish
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        \ textwidth=88 colorcolumn=89

  " TypeScript / JavaScript / JSON / HTML / CSS — 2 spaces
  autocmd FileType typescript,typescriptreact,javascript,javascriptreact,json,html,css,scss,yaml
        \ setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

  " Markdown — soft wrap, spell, no auto-pairs being annoying
  autocmd FileType markdown setlocal wrap linebreak spell spelllang=en_us
        \ shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=2

  " Auto-trim trailing whitespace on save (skip markdown — 2 trailing = <br>)
  autocmd BufWritePre * if &filetype !~# '^\(markdown\|diff\)$' |
        \ let b:_p = winsaveview() | %s/\s\+$//e | call winrestview(b:_p) | endif
augroup END

" Markdown plugin tweaks
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_fenced_languages = ['python=python', 'ts=typescript', 'js=javascript', 'bash=sh']
let g:mkdp_auto_close = 0

" Markdown preview shortcut
nmap <leader>mp <Plug>MarkdownPreviewToggle

" -----------------------------------------------------------------------------
" Quality of life: jump to last position when reopening a file
" -----------------------------------------------------------------------------
augroup remember_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" | endif
augroup END

" =============================================================================
"  End of .vimrc
" =============================================================================
