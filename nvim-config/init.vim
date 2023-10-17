" nvim config with lsp support
"
" Author : <Nishanth Shetty> nishanthspshetty@gmail.com
"This is optional if have .vimrc in your path or VIMINIT set (default).
"If you are loading this in vim with -u flag, uncomment this line to set the
"following flag,
"not required for neovim -- set nocompatible

"encoding displayed.
set encoding=UTF-8

"encoding written to file.
"set filecoding=UTF-8

set tabstop=4
set termguicolors

set expandtab
set shiftwidth=4
"set spell spelllang=en_us

"required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" === Lets make vim look cool. ===
Plugin 'morhetz/gruvbox'
"

" === Making vim more like IDE === 
"Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plugin 'junegunn/fzf.vim'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'preservim/tagbar'
Plugin 'tpope/vim-obsession' 
Plugin 'rhysd/vim-clang-format'
Plugin 'fatih/vim-go'
" requires
Plugin 'nvim-lualine/lualine.nvim'
Plugin 'kyazdani42/nvim-web-devicons' " for file icons
Plugin 'kyazdani42/nvim-tree.lua'

" == that one plugin to add intellisense

" === Git plugins
"Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin  'stsewd/fzf-checkout.vim'

Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/lsp_extensions.nvim'

" completion plugins
Plugin 'hrsh7th/nvim-cmp' 
Plugin 'hrsh7th/cmp-buffer' 
Plugin 'hrsh7th/cmp-path' 
Plugin 'hrsh7th/cmp-cmdline' 
Plugin 'hrsh7th/cmp-nvim-lsp' 
Plugin 'saadparwaiz1/cmp_luasnip'
" snippets
Plugin 'onsails/lspkind.nvim'
Plugin  'L3MON4D3/LuaSnip'
Plugin 'rafamadriz/friendly-snippets'

Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'sindrets/diffview.nvim'
Plugin 'numToStr/Comment.nvim'

Plugin 'filipdutescu/renamer.nvim' , { 'branch': 'master' }
Plugin 'simrat39/rust-tools.nvim'

Plugin 'mhartington/formatter.nvim'
Plugin 'mhanberg/elixir.nvim'
Plugin 'elixir-editors/vim-elixir'

" debugger
Plugin 'mfussenegger/nvim-dap'
Plugin 'rcarriga/nvim-dap-ui'
Plugin 'nvim-telescope/telescope-dap.nvim'
Plugin 'leoluz/nvim-dap-go'
Plugin 'theHamsta/nvim-dap-virtual-text'

Plugin 'stevearc/dressing.nvim'

Plugin 'folke/noice.nvim'
Plugin 'MunifTanjim/nui.nvim'
Plugin 'rcarriga/nvim-notify'

call vundle#end()            

"turn back filetype plugin and indentation on
filetype plugin indent on   


" --- basic vim settings ---

"source curret vimrc without restart
nnoremap <Leader>sv :source $MYVIMRC<CR>

set backspace=indent,eol,start
set ruler
set number
" relative number set rnu
set showcmd
set incsearch
set hlsearch
set cursorline
set mouse=a
set splitright "vertical splits the buffer to right.
set splitbelow "split below the current buffer for h split
"code snippet folding config
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
syntax on
let g:tmux_navigator_disable_when_zoomed = 1


" [[tab config]]
function! OpenCurrentAsNewTab()
    let l:currentPos = getcurpos()
    tabedit %
    call setpos(".", l:currentPos)
endfunction
"open current buffer as new tab
nmap t% :call OpenCurrentAsNewTab()<CR>
nmap td :tabclose<CR>
nmap tn :tabNext<CR>

"split mapping Ctrl-a (conflicts with tmux) horizontal split, Ctrl-S vertical split.
"nmap <C-a> :sp<CR> disabling for ---^^
nmap <C-S> :vsp<CR>

"buffer navigation
noremap ,n :bn<CR>
noremap ,p :bp<CR>

"remap arrow keys to move the line up and down 
no <up> :m .-2<CR>==
no <down> :m .+1<CR>==
no <left> <NOP>
no <right> <NOP>

vno <down> <NOP>
vno <up> <NOP>
vno <left> <NOP>

"window command for navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <Enter> o<ESC>
nmap <C-Enter> O<ESC>

"=================Plugin configs==============

"Nerdtree mappings

""Open/close NERDTree Tabs with \t
"nmap <silent> <leader>t :NERDTreeTabsToggle<CR> 
"noremap <silent> <leader>nf :NERDTreeFind<CR>
""To have NERDTree always open on startup
"let g:nerdtree_tabs_open_on_console_startup = 1
"
"let g:NERDTreeGitStatusIndicatorMapCustom = {
"                \ 'Modified'  :'✹',
"                \ 'Staged'    :'✚',
"                \ 'Untracked' :'✭',
"                \ 'Renamed'   :'➜',
"                \ 'Unmerged'  :'═',
"                \ 'Deleted'   :'✖',
"                \ 'Dirty'     :'✗',
"                \ 'Ignored'   :'☒',
"                \ 'Clean'     :'✔︎',
"                \ 'Unknown'   :'?',
"		\ }
"let g:NERDTreeGitStatusShowClean = 1
"" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" ============================================
"
" vim-tree config
nnoremap <silent> <leader>t :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>



" Theme config
"Toggle this to "light" for light colorscheme
let g:gruvbox_contrast_dark = 'hard'
"
""Uncomment the next line if your terminal is not configured for solarized
""let g:solarized_termcolors=256
" let g:gruvbox_invert_selection='0'
set background=dark
colorscheme  gruvbox

set laststatus=2

" FZF fuzzy finder mapping
"noremap <leader>zf :Files<CR>
"noremap <silent><C-f> :Files<CR>
"noremap <silent><space>l :Lines<CR>

nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

"set list
"set listchars=tab:▸\ ,eol:¬



"Fugitive configuration
noremap <leader>gc :GCheckout<CR>
noremap <leader>gs :G<CR>

"let g:python3_host_prog='/Users/nishanth/.pyenv/shims/python3'


" === Go/vim-go 
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

":w<CR>:vsplit <bar> terminal go run %<CR>
function! ReuseVimGoTerm(cmd) abort
   if has('nvim') 
    for w in nvim_list_wins()
        if "goterm" == nvim_buf_get_option(nvim_win_get_buf(w), 'filetype')
            call nvim_win_close(w, v:true)
            break
        endif
    endfor
    endif
    execute a:cmd
endfunction

"let g:go_term_enabled = 1
"let g:go_term_mode = "silent keepalt  vsplit"
"let g:go_def_reuse_buffer = 1
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>gr :call ReuseVimGoTerm('GoRun')<CR>
"au FileType go nmap <leader>r  :w<CR>:vsplit <bar> terminal go run %<CR>
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt :call ReuseVimGoTerm('GoTest')<CR>
"au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

" ============== easymotion
"map <Leader> <Plug>(easymotion-prefix)


" rainbow
let g:rainbow_active = 1

"tagbar 
nmap <space>t :TagbarToggle<CR>

function! CloseRustOutIfOpen()
	if bufwinnr('rust.out') >0 
		bdelete rust.out
	endif
endfunction


function! Redir(cmd)
	redir => output
    	silent! execute(a:cmd )
	redir END
	call CloseRustOutIfOpen()
	let output = split(output, "\n")
	vnew rust.out
	let w:scratch = 1
	setlocal buftype=nofile filetype=rust_out bufhidden=wipe noswapfile
	call setline(1, output)
	wincmd h
endfunction

command! -nargs=1 Redir call Redir(<f-args>)

au FileType rust nmap <silent> <leader>rr  :call Redir('RustRun')<CR><CR>
au FileType rust nmap <silent> <leader>rd  :call CloseRustOutIfOpen()<CR>
" let cargo  do some magic on source
au FileType rust nmap <silent> <leader>cr :Cargo run<CR>
au FileType rust nmap <silent> <leader>ct :Cargo test<CR>
au FileType rust nmap <silent> <leader>cc :Cargo check<CR>

let g:clang_format#code_style="google" "google, llvm, mozilla, chromium available

"shoud be cpp-11 providing any other format will fail clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

let g:syntastic_cpp_compiler_options = ' -std=c++2a'


" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc,proto,json nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc,proto,json vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc,proto map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
autocmd FileType c,cpp ClangFormatAutoEnable
autocmd FileType asm set ft=nasm

" Yaml file config
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
augroup END


" neovim lua config import
" 
lua require("init")


"debugger mapping
"
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

