set runtimepath+="/root/.config/nvim"

call plug#begin()
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
" Plug 'cpiger/NeoDebug'
" Plug 'rust-lang/rust.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'preservim/nerdtree'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'puremourning/vimspector'
" Plug 'timonv/vim-cargo'
Plug 'lervag/vimtex'
call plug#end()

" Editor Settings
set fenc=utf-8
set showcmd
set list listchars=tab:\>\_
set cinoptions=l1

let g:rustfmt_autosave = 1

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" file
au BufNewFile,BufRead *.zcfg setf zsh

set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase
set hlsearch

filetype plugin indent on

" Visual Settings
set relativenumber
set number
set cmdheight=2

set updatetime=300
set shortmess+=c
set signcolumn=yes

syntax on
set smartindent

" colorscheme
colorscheme molokai
set t_Co=256

" key settings

noremap x "_x

noremap <C-n><C-n> :NERDTreeToggle<CR>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=3 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

map <F1> :NERDTreeToggle<CR>

imap <silent><script><expr> <Right> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

inoremap <silent> jj <ESC>
