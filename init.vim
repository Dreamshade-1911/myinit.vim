set nocompatible
set termguicolors
filetype plugin on
syntax enable

" If the argument passed is a folder, set it as cwd.
if argc() == 1 && isdirectory(argv(0))
    cd `=argv(0)`
    tcd `=argv(0)`
elseif argc() == 1
    cd %:h
    tcd %:h
endif

function! RunAcrylic(win_name)
    if has("win32") && executable("acrylic")
        let g:acrylic_win_name = a:win_name
        augroup AcrylicNeovide
            autocmd! UIEnter * call system("acrylic " . g:acrylic_win_name)
        augroup END
    endif
endfunction

if exists("g:neovide")
    let g:neovide_padding_left = 5
    let g:neovide_padding_right = 5
    let g:neovide_padding_top = 5
    let g:neovide_padding_bottom = 0
    let g:neovide_refresh_rate = 144
    let g:neovide_refresh_rate_idle = 14
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_scroll_animation_far_lines = 9999
    let g:neovide_scroll_animation_length = 0.1
    let g:neovide_cursor_animate_in_insert_mode = v:true
    let g:neovide_cursor_animate_command_line = v:true
    let g:neovide_cursor_animation_length = 0.1
    let g:neovide_cursor_trail_size = 0.5
    let g:neovide_remember_window_size = v:true
    let g:neovide_window_blurred = v:true
    let g:neovide_floating_blur_amount_x = 5.0
    let g:neovide_floating_blur_amount_y = 5.0
    let g:neovide_floating_corner_radius = 6.0
    let g:neovide_opacity = 0.8
    let g:neovide_title_background_color = "#061214"
    let g:neovide_title_text_color = "#DBCAA4"
    call RunAcrylic("Neovide")
elseif exists("g:nvui")
    NvuiCursorHideWhileTyping 1
    NvuiOpacity 1
    NvuiTitlebarBg #091B1F
    NvuiTitlebarFontSize 11
    NvuiCursorAnimationDuration 0.1
    NvuiScrollAnimationDuration 0.2
    NvuiMoveAnimationDuration 0.2
    NvuiCursorFrametime 6.944
    NvuiScrollFrametime 6.944
    NvuiMoveAnimationFrametime 6.944
    NvuiSnapshotLimit 128
    NvuiIMEDisable
endif

set guifont=FiraMono\ Nerd\ Font:h11
set guicursor=i-c-ci-sm-o:hor50,n-r-v-ve-cr-ve:block
set guicursor+=a:-blinkwait500-blinkon800-blinkoff300
set cursorline
set tabstop=8
set shiftwidth=4
set softtabstop=-1
set expandtab
set autoread
set showmatch
set autoindent
set wildmode=longest,list
set timeoutlen=500
set scrolloff=26
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
set signcolumn=no
set ignorecase
set smartcase
set path+=**
set nofoldenable
set synmaxcol=1000
set nobuflisted
set splitbelow
set fillchars+=vert:\ " Comment so we don't have trailing space.
set fillchars+=eob:\ " Comment
set sessionoptions=blank,curdir,folds,help,tabpages,resize,winsize,winpos,terminal
set wildignore+=tmp,.tmp,*.swp,*.zip,*.exe,*.obj,.vscode,.vs,.git,node_modules,bin,build,dist,*.png,*.jpeg,*.jpg,*.svg,*.bmp,package-lock.json,yarn.lock,*.pdb,*.map,third_party,.nyc_output,obj,Packages,ProjectSettings,UserSettings,Library,Logs


" Silent grep command
:command! -nargs=+ Grep execute ':silent grep '.<q-args> | execute ':redraw!'

" Open QuickFix window on grepping
autocmd QuickFixCmdPost [^l]* botright cwindow 18
autocmd QuickFixCmdPost    l* botright lwindow 18


" Enable comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+


" Odin error format
set errorformat+=%A%f(%l:%c)\ %m,%Z%s%p^%.%#


" General remaps
nnoremap ) ^
vnoremap ) ^
inoremap <C-u> <ESC>viwUea
inoremap <S-CR> <ESC>O
inoremap <C-CR> <ESC>F{a<CR><ESC>O
inoremap <C-BS> <ESC>diwi
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <C-Left> <Cmd>vertical resize -15<CR>
nnoremap <silent> <C-Right> <Cmd>vertical resize +15<CR>
noremap <expr> j v:count ? "j" : "gj"
noremap <expr> k v:count ? "k" : "gk"
" Clear last search and reset syntax highlighting
nnoremap <silent> <C-l> :let @/ = ""\|:mod\|:syntax sync fromstart<CR>
nnoremap <F1> <Cmd>set ignorecase! ignorecase?<CR>
nnoremap <PageDown> <C-d>
inoremap <PageDown> <Esc><C-d>
vnoremap <PageDown> <C-d>
tnoremap <PageDown> <C-d>
nnoremap <PageUp> <C-u>
inoremap <PageUp> <Esc><C-u>
vnoremap <PageUp> <C-u>
tnoremap <PageUp> <C-u>
nnoremap <C-j> ddp
inoremap <C-j> <Esc>ddpi
nnoremap <C-k> ddkP
inoremap <C-k> <Esc>ddkPi

function! ToggleQuickFix()
    if empty(filter(getwininfo(), "v:val.quickfix"))
        botright cwindow 18
    else
        cclose
    endif
endfunction
nnoremap <silent> <F8> :call ToggleQuickFix()<CR>

nnoremap <silent> <F2> @:<CR>
nnoremap <silent> <F5> <Cmd>NoNeckPain<CR>
inoremap <silent> <F5> <Cmd>NoNeckPain<CR>
vnoremap <silent> <F5> <Cmd>NoNeckPain<CR>
tnoremap <silent> <F5> <Cmd>NoNeckPain<CR>
nnoremap <silent> <F9> <Cmd>cprev<CR>
inoremap <silent> <F9> <Cmd>cprev<CR>
nnoremap <silent> <F10> <Cmd>cnext<CR>
inoremap <silent> <F10> <Cmd>cnext<CR>
nnoremap <silent> <F11> <Cmd>Make build<CR>
inoremap <silent> <F11> <Cmd>Make build<CR>
nnoremap <silent> <F12> <Cmd>vert Start make<CR>
inoremap <silent> <F12> <Cmd>vert Start make<CR>

" Leader keybinds
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<CR>
nnoremap <silent> <Leader>' :e $MYVIMRC<CR>
nnoremap <silent> <Leader>" :vs $MYVIMRC<CR>
nnoremap <silent> <Leader>e :e %:h<CR>
nnoremap <silent> <Leader>E :vs %:h<CR>
nnoremap <silent> <Leader>. :e .<CR>
nnoremap <silent> <Leader>p pkdd
nnoremap <Leader>0 "0p
nnoremap <Leader>) "0P
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>u :UndotreeToggle<CR>

nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
xmap <Leader>gs <Plug>(GitGutterStageHunk)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Moving between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Moving windows
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

" Commands
command! Cdhere tcd %:p:h

" Custom grep
" augroup GrepQuickFix | autocmd! QuickFixCmdPost cgetexpr botright cwindow 18
" function! CustomGrep(...)
"     return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
" endfunction
" command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr CustomGrep(<f-args>)

" Show SynGroup under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name')..' -> '..synIDattr(synIDtrans(l:s), 'name')
endfunction
command! SynGroup call SynGroup()


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


" General plugin settings
let g:ctrlp_cmd = "CtrlPLastMode"
let g:ctrlp_map = "<C-p>"
let g:ctrlp_working_path_mode = "ra"
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_root_markers = ["package.json", "makefile"]
let g:ctrlp_clear_cache_on_exit = 1
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --color=never
    set grepformat+=%f:%l:%c:%m
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif
let g:vue_pre_processors = "detect_on_enter"
let g:netrw_cygwin = 0
let g:netrw_fastbrowse = 0
let g:cpp_attributes_highlight = 1
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
let g:zig_fmt_autosave = 0
" let g:undotree_WindowLayout = 3

" Custom easy align delimiters
let g:easy_align_delimiters = {
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ }

" Setup CoC
let g:coc_config_home = stdpath('config')
let g:coc_global_extensions = ['coc-vimlsp', 'coc-go', 'coc-git', 'coc-glslx', 'coc-html-css-support', 'coc-html', 'coc-css', 'coc-yaml', 'coc-tsserver', '@yaegassy/coc-volar']

inoremap <silent> <expr><S-TAB> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Cmd>vsp<CR><Plug>(coc-definition)
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

exec "source "..stdpath('config').."/lua_init.lua"
exec "source "..stdpath('config').."/dreamshade_theme.vim"
