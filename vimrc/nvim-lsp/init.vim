"vimrc/nvim init config
" Author : <Nishanth Shetty> nishanthspshetty@gmail.com
" 
" Should work on both mac and linux environment.

"This is optional if have .vimrc in your path or VIMINIT set (default).
"If you are loading this in vim with -u flag, uncomment this line to set the
"following flag,
set nocompatible

"encoding displayed.
set encoding=UTF-8

"encoding written to file.
"set filecoding=UTF-8

set termguicolors

set tabstop=4
set expandtab
set shiftwidth=4
"required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" === Lets make vim look cool. ===
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" === Making vim more like IDE === 
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-syntastic/syntastic'
Plugin 'luochen1990/rainbow'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'preservim/tagbar'
Plugin 'tpope/vim-obsession' 
Plugin 'rhysd/vim-clang-format'
Plugin 'fatih/vim-go'

" == that one plugin to add intellisense

" === Git plugins
"Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin  'stsewd/fzf-checkout.vim'

Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/lsp_extensions.nvim'
Plugin 'hrsh7th/nvim-cmp' 
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'saadparwaiz1/cmp_luasnip'
Plugin  'L3MON4D3/LuaSnip'

Plugin 'puremourning/vimspector'

call vundle#end()            

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls= 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_declarations = 1

"turn back filetype plugin and indentation on
filetype plugin indent on   


" --- basic vim settings ---
set backspace=indent,eol,start
set ruler
set number
set rnu
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

"split mapping Ctrl-a (confliucts with tmux) horizontal split, Ctrl-S vertical split.
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

"=================Plugin configs==============

"Nerdtree mappings

"Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR> 
noremap <silent> <leader>nf :NERDTreeFind<CR>
"To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
		\ }
let g:NERDTreeGitStatusShowClean = 1
" ============================================


" Theme config
"Toggle this to "light" for light colorscheme
let g:gruvbox_contrast_dark = 'hard'

"Uncomment the next line if your terminal is not configured for solarized
"let g:solarized_termcolors=256
 let g:gruvbox_invert_selection='0'
 set background=dark
colorscheme  gruvbox

set laststatus=2
"Show PASTE if in paste mode
let g:airline_detect_paste=1
"Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
"Use the solarized theme for the Airline status bar
let g:airline_theme='gruvbox'

" FZF fuzzy finder mapping
noremap <leader>zf :Files<CR>

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



"Fugitive configuration
noremap <leader>gc :GCheckout<CR>
noremap <leader>gs :G<CR>

"let g:python3_host_prog='/Users/nishanth/.pyenv/shims/python3'

" === airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

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
nmap <F8> :TagbarToggle<CR>

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
" Run with :!
let g:rust_shell_command_runner = '!'

" Run with :terminal
let g:rust_shell_command_runner = 'terminal'

" Run with :noautocmd new | terminal (useful on Neovim)
let g:rust_shell_command_runner = 'noautocmd new | terminal'
" let rust auto format on save
let g:rustfmt_autosave = 1

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


" neovim lsp settings
" 


lua require("lsconf")

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
\ lua require'lsp_extensions'.inlay_hints{ prefix = ' ->', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

"autocmd BufWritePre *.go lua goimports(1000)
"autocmd BufWritePre *.go lua vim.lsp.buf.formatting()



"viminspector 
let g:vimspector_enable_mappings = 'HUMAN'
nmap <F5> <Plug>VimspectorContinue

nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]
