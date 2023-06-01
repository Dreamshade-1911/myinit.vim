set nocompatible
filetype plugin on
syntax enable
set termguicolors
exec "source " . stdpath('config') . "/dreamshade_theme.vim"

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'roryokane/detectindent'
Plug 'djoshea/vim-autoread'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'phaazon/hop.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'posva/vim-vue'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'bfrg/vim-cpp-modern'
Plug 'rluba/jai.vim'
" List ends here. plugins become visible to vim after this call.
call plug#end()

colorscheme nord
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_z = airline#section#create(["windowswap", "%3p%% "])

if get(g:, "nvui", 0)
    NvuiCursorHideWhileTyping 1
    NvuiOpacity 1
    NvuiTitlebarBg #22272e
    NvuiTitlebarFontSize 11
    NvuiCursorAnimationDuration 0.15
    NvuiScrollAnimationDuration 0.3
    NvuiMoveAnimationDuration 0.3
    NvuiCursorFrametime 6.95
    NvuiScrollFrametime 6.95
    NvuiMoveAnimationFrametime 6.95
    NvuiSnapshotLimit 64
    NvuiIMEDisable
endif

set guifont=Cousine\ NFM:h11
set guicursor=i-c-ci-sm-o:hor50,n-r-v-ve-cr-ve:block
set guicursor+=a:-blinkwait500-blinkon800-blinkoff200
set cursorline
set autoread
set showmatch
set expandtab
set autoindent
set wildmode=longest,list
set timeoutlen=500
set scrolloff=22
set number
set noswapfile
set mouse=a
set backspace=indent,eol,start
set encoding=utf-8
set splitright
set filetype
set wildmenu
set clipboard=unnamed,unnamedplus
set hidden
set nobackup
set nowritebackup
set updatetime=500
set shortmess+=c
set signcolumn=number
set ignorecase
set smartcase
set path+=**
set nofoldenable
set shiftwidth=4
set synmaxcol=1000

" Enable comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:detectindent_preferred_indent = 4
augroup DetectIndent
     autocmd!
     autocmd BufReadPost * DetectIndent
augroup END
set wildignore+=tmp,.tmp,*.swp,*.zip,*.exe,*.obj,.vscode,.vs,.git,node_modules,bin,bin_client,bin_server,build,dist,data,*.png,*.jpeg,*.jpg,*.svg,*.bmp,package-lock.json,yarn.lock,*.pdb,*.map,third_party,.nyc_output,obj,Packages,ProjectSettings,UserSettings,Library,Logs

" Custom commands
command! CdHere cd %:p:h

" Quick recursive grep
augroup GrepQuickFix
    autocmd!
    autocmd QuickFixCmdPost [^l]* botright cwindow 18
    autocmd QuickFixCmdPost l* botright cwindow 18
augroup END
function! CustomGrep(str)
    if isdirectory("src")
        execute "vimgrep /\\C".a:str."/j src/**"
    elseif isdirectory("scripts")
        execute "vimgrep /\\C".a:str."/j scripts/**"
    elseif isdirectory("app")
        execute "vimgrep /\\C".a:str."/j app/**"
    else
        execute "vimgrep /\\C".a:str."/j **/*"
    endif
endfunction
command! -nargs=* Grep call CustomGrep("<args>")

" Simple scratch buffer
function! Scratch()
    vnew
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
endfunction

" General remaps
" map ç <C-c>
" nmap ç a
" nmap Ç 0^
" imap ç <Esc>
" imap Ç <C-o>
" vmap Ç 0^
nnoremap ) ^
vnoremap ) ^
tnoremap ç <C-\><C-n>
nnoremap s :HopWord<CR>
nnoremap S :HopLine<CR>
inoremap <C-u> <esc>viwUea
inoremap <S-CR> <ESC>O
inoremap <C-CR> <ESC>F{a<CR><ESC>O
inoremap <S-TAB> <C-n>
inoremap <C-TAB> <C-p>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-Left> :vertical resize -15<CR>
nnoremap <C-Right> :vertical resize +15<CR>
noremap <expr> j v:count ? "j" : "gj"
noremap <expr> k v:count ? "k" : "gk"
nnoremap <F1> :set ignorecase! ignorecase?<CR>
nnoremap <silent> <F4> @:<CR>
nnoremap <silent> <F5> :call Scratch()<CR>
nnoremap <silent> <C-9> :cprevious<CR>
nnoremap <silent> <C-0> :cnext<CR>
" Clear last search and reset syntax highlighting
nnoremap <silent> <C-l> :let @/ = ""\|:mod\|:syntax sync fromstart<CR>

" Prevent netrw from remapping Ctrl+l
function! NetrwMapping()
    nnoremap <buffer> <C-l> <C-w>l
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! ToggleQuickFix()
    if empty(filter(getwininfo(), "v:val.quickfix"))
        botright cwindow 18
    else
        cclose
    endif
endfunction
nnoremap <silent> <C-8> :call ToggleQuickFix()<CR>

" Increase and decrease font size bindings
nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

" Output the current syntax group
nnoremap <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Leader keybinds
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<CR>
nnoremap <silent> <Leader>' :e $MYVIMRC<CR>
nnoremap <silent> <Leader>" :vs $MYVIMRC<CR>
nnoremap <silent> <Leader>s :vs<CR><C-w>l
nnoremap <silent> <Leader>S <C-w>L
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>p :e %:h<CR>
nnoremap <silent> <Leader>P :vs %:h<CR>
nnoremap <silent> <Leader>0 "0p
nnoremap <silent> <Leader>) "0P
nnoremap <silent> <Leader>w :w<CR>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
xmap <Leader>gs <Plug>(GitGutterStageHunk)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" General plugin settings
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:ctrlp_cmd = "CtrlPLastMode"
let g:ctrlp_map = "<C-p>"
let g:ctrlp_working_path_mode = "wra"
let g:ctrlp_user_command = [".git", "cd %s && git ls-files -co --exclude-standard"]
let g:ctrlp_use_caching = 0
let g:vue_pre_processors = "detect_on_enter"
let g:netrw_cygwin = 0
let g:ctrlp_by_filename = 1
let g:gutentags_cache_dir = stdpath('data') . "/ctags"
let g:cpp_attributes_highlight = 1

" Setup gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
set signcolumn=no
hi! link GitGutterAddLineNr DiffAdd
hi! link GitGutterChangeLineNr DiffChange
hi! link GitGutterDeleteLineNr DiffDelete
hi! link GitGutterChangeDeleteLineNr DiffChangeDelete

" Setup ToggleTerm
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><C-'> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-'> will open terminal 2
nnoremap <silent><C-'> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><C-'> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent><C-1> <Cmd>exe "1ToggleTerm"<CR>
inoremap <silent><C-1> <Esc><Cmd>exe "1ToggleTerm"<CR>
nnoremap <silent><C-2> <Cmd>exe "2ToggleTerm"<CR>
inoremap <silent><C-2> <Esc><Cmd>exe "2ToggleTerm"<CR>
nnoremap <silent><C-3> <Cmd>exe "3ToggleTerm"<CR>
inoremap <silent><C-3> <Esc><Cmd>exe "3ToggleTerm"<CR>

" Build and run bindings
nnoremap <silent><C--> <Cmd>make<CR>
nnoremap <silent><F9> <Cmd>exe '1TermExec cmd="build"'<CR><C-w>ji
inoremap <silent><F9> <Esc><Cmd>exe '1TermExec cmd="build"'<CR><C-w>ji
nnoremap <silent><F10> <Cmd>exe '1TermExec cmd="run"'<CR><C-w>ji
inoremap <silent><F10> <Esc><Cmd>exe '1TermExec cmd="run"'<CR><C-w>ji
nnoremap <silent><F11> <Cmd>exe '1TermExec cmd="build && run"'<CR><C-w>ji
inoremap <silent><F11> <Esc><Cmd>exe '1TermExec cmd="build && run"'<CR><C-w>ji

" Setup CoC
let g:coc_config_home = stdpath('config')

inoremap <silent> <expr><S-TAB> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
nnoremap <silent> <C-h> :call CocActionAsync('doHover')<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <F3> <Plug>(coc-format-selected)
nmap <F3> <Plug>(coc-format-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has("nvim-0.4.0") || has("patch-8.2.0750")
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction("format")

" Call lua init
exec "source " . stdpath('config') . "/lua_init.lua"
