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
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-syntastic/syntastic'
Plugin 'luochen1990/rainbow'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'preservim/tagbar'

" == that one plugin to add intellisense
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" === Git plugins
"Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin  'stsewd/fzf-checkout.vim'

Plugin 'SirVer/ultisnips'
" Language plugins
Plugin 'fatih/vim-go'
Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim'
Plugin 'rhysd/vim-clang-format'
"Plugin 'Olical/conjure', {'tag': 'v4.11.0'}
Plugin 'cespare/vim-toml'
Plugin 'tpope/vim-fireplace'

Plugin 'guns/vim-sexp',    {'for': 'clojure'}
Plugin 'liquidz/vim-iced', {'for': 'clojure'}
Plugin 'liquidz/vim-iced-coc-source', {'for': 'clojure'}

Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'puremourning/vimspector'



Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/lsp_extensions.nvim'

call vundle#end()            

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

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

let g:python3_host_prog='/Users/nishanth/.pyenv/shims/python3'

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

let g:go_term_enabled = 1
let g:go_term_mode = "silent keepalt  vsplit"
let g:go_def_reuse_buffer = 1
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

"=====================================================
"---- COC mappings
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" to track the coc extension I use
let g:coc_global_extensions = [ 'coc-go', 'coc-rust-analyzer', 'coc-json', 'coc-solargraph', 'coc-tsserver', 'coc-vimlsp', 'coc-python']

" ============== easymotion
map <Leader> <Plug>(easymotion-prefix)


" rainbow
let g:rainbow_active = 1

"tagbar 
nmap <F8> :TagbarToggle<CR>

"Rust racer config
set hidden
if has('macunix')
	let g:racer_cmd = "/Users/nishanth/.cargo/bin/racer"
else
	let g:racer_cmd = "/home/nishanth/.cargo/bin/racer"
endif


""let g:racer_experimental_completer = 1
"let g:racer_insert_paren = 1
"augroup Racer
"    autocmd!
"    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
"    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
"    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
"    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
"    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
"    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
"augroup END

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

"let g:LanguageClient_serverCommands = {
"\ 'rust': ['rust-analyzer'],
"\ }


autocmd CursorHold * silent call CocActionAsync('highlight')
" UtilSnips config
" remap completion from Tab to F2, dont mess with coc completion
let g:UltiSnipsExpandTrigger="<F2>"


" C- Lang format config
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
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
autocmd FileType c,cpp ClangFormatAutoEnable
autocmd FileType asm set ft=nasm

" Yaml file config
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" clojure config
let g:iced_enable_default_key_mappings = v:true 

autocmd FileType clojure nmap ccc :IcedConnect<cr>
autocmd FileType clojure nmap cqp :IcedEval<space>
autocmd FileType clojure nmap cpr :IcedRequireAll<cr>
autocmd FileType clojure nmap cpp :IcedEvalOuterTopList<cr>
" autocmd FileType clojure nmap <buffer> cp <Plug>(iced_eval)
autocmd FileType clojure nmap <buffer> cp <Plug>(iced_eval_and_print)
" autocmd FileType clojure nmap <buffer> ct <Plug>(iced_eval_and_tap)
" autocmd FileType clojure nmap <buffer> c! <Plug>(iced_print_last)
autocmd FileType clojure nmap <buffer> c! <Plug>(iced_eval_and_tap)
" this has potential to override "change till m" - might need a different
" mapping, or get kaocha working
autocmd FileType clojure nmap <buffer> ctm :IcedEval (require 'midje.repl)(midje.repl/load-facts *ns*)<cr>

autocmd FileType clojure nmap <buffer> gd    :IcedDefJump<cr>
" add namespace
autocmd FileType clojure nmap <buffer> <leader>an :IcedAddNs<cr>
autocmd FileType clojure nmap <buffer> <leader>am :IcedAddMissing<cr>



" to get the rust inlay type hints

" lua <<EOF
" 	local nvim_lsp = require'lspconfig'
"     nvim_lsp.rust_analyzer.setup {
"     --on_attach = on_attach;
"     }
"     
" EOF
" augroup rustlay
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
" \ lua require'lsp_extensions'.inlay_hints{ prefix ='➜', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}, only_current_line = true }
" augroup END
