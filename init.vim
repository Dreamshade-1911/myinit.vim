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
Plug 'Darazaki/indent-o-matic'
Plug 'djoshea/vim-autoread'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'posva/vim-vue'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bfrg/vim-cpp-modern'
Plug 'rluba/jai.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'Tetralux/odin.vim'
Plug 'ggandor/leap.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ziglang/zig.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'arecarn/vim-crunch'

" List ends here. plugins become visible to vim after this call.
call plug#end()

colorscheme nord
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', g:airline_symbols.space.':%c%V'])
let g:airline#extensions#coc#enabled = 1

" If the argument passed is a folder, set it as cwd.
if argc() == 1 && isdirectory(argv(0))
    tcd `=argv(0)`
endif

if exists("g:neovide")
    let g:neovide_floating_blur_amount_x = 4.0
    let g:neovide_floating_blur_amount_y = 4.0
    let g:neovide_scroll_animation_length = 0.3
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_refresh_rate = 144
    let g:neovide_refresh_rate_idle = 10
    let g:neovide_cursor_animate_in_insert_mode = v:true
    let g:neovide_cursor_animate_command_line = v:true
    let g:neovide_remember_window_size = v:true
    set winblend=50
    set pumblend=50
elseif exists("g:nvui")
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
    NvuiSnapshotLimit 128
    NvuiIMEDisable
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat+=%f:%l:%c:%m
endif

set guifont=FiraMono\ Nerd\ Font:h11
set guicursor=i-c-ci-sm-o:hor50,n-r-v-ve-cr-ve:block
set guicursor+=a:-blinkwait500-blinkon800-blinkoff200
set cursorline
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
set signcolumn=number
set ignorecase
set smartcase
set path+=**
set nofoldenable
set synmaxcol=1000
set nobuflisted
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set fillchars=eob:\ " Comment so we don't have trailing space.
set wildignore+=tmp,.tmp,*.swp,*.zip,*.exe,*.obj,.vscode,.vs,.git,node_modules,bin,bin_client,bin_server,build,dist,data,*.png,*.jpeg,*.jpg,*.svg,*.bmp,package-lock.json,yarn.lock,*.pdb,*.map,third_party,.nyc_output,obj,Packages,ProjectSettings,UserSettings,Library,Logs


" Custom grep
augroup GrepQuickFix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr botright cwindow 18
augroup END
function! CustomGrep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr CustomGrep(<f-args>)


" General remaps
map ç <C-c>
nmap ç a
nmap Ç 0^
imap ç <Esc>
imap Ç <C-o>
vmap Ç 0^
nnoremap ) ^
vnoremap ) ^
tnoremap ç <C-\><C-n>
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
nnoremap <F1> :set ignorecase! ignorecase?<CR>
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

nnoremap <silent> <F2> @:<CR>
nnoremap <silent> <F8> :call ToggleQuickFix()<CR>
nnoremap <silent> <F9> <Cmd>cprev<CR>
inoremap <silent> <F9> <Cmd>cprev<CR>
nnoremap <silent> <F10> <Cmd>cnext<CR>
inoremap <silent> <F10> <Cmd>cnext<CR>
nnoremap <silent> <F11> <Cmd>Cmd make<CR>
inoremap <silent> <F11> <Cmd>Cmd make<CR>
nnoremap <silent> <F12> <Cmd>Cmd make build_and_run<CR>
inoremap <silent> <F12> <Cmd>Cmd make build_and_run<CR>

" indentation jumping
" noremap <silent> <C-[> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
" noremap <silent> <C-]> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

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
nnoremap <Leader>u :UndotreeToggle<CR>

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


" Terminal Buffer stuff
function! NewVerticalTerminal()
    exec "vert lefta sp +term"
endfunction
function! NewHorizontalTerminal()
    exec "sb +term"
endfunction
function! NewRightVerticalTerminal()
    exec "vert sp +term"
endfunction

command! VTerm call NewVerticalTerminal()
command! HTerm call NewHorizontalTerminal()
command! RVTerm call NewRightVerticalTerminal()

function! TimerVertTerm(timer_id)
    call NewVerticalTerminal()
    exec "wincmd p"
endfunction

function! NewTerminalEntered()
    exec "setlocal nonumber | vert resize 130 | set wfw"
    exec "keepalt file dreamterm::" . tabpagenr() . "::" . t:session_tab_term_index
    let t:session_tab_term_index += 1
endfunction

augroup TabTerm
    autocmd! UIEnter * call timer_start(50, "TimerVertTerm")
    autocmd! TermOpen * call NewTerminalEntered()
augroup END

function! MyTermToggle(tnr)
    let l:is_in_term = stridx(bufname(), "dreamterm::")

    if a:tnr == 0
        let l:search_term = "dreamterm::" . tabpagenr()
    else
        let l:search_term = "dreamterm::" . tabpagenr() . "::" . a:tnr
    endif

    if stridx(bufname(), l:search_term) != -1
        call win_gotoid(t:last_toggled_nonterm_winid)
        return
    endif

    for bufn in tabpagebuflist()
        let l:buffname = nvim_buf_get_name(bufn)
        let l:buffwinid = bufwinid(l:buffname)

        if l:buffwinid == -1
            continue
        endif

        if stridx(l:buffname, l:search_term) != -1
            if l:is_in_term == -1
                let t:last_toggled_nonterm_winid = win_getid()
            endif
            call win_gotoid(l:buffwinid)
            startinsert!
            return
        endif
    endfor

    if l:is_in_term == -1
        let t:last_toggled_nonterm_winid = win_getid()
    endif
endfunction

nnoremap <C-'> <Cmd>call MyTermToggle(0)<CR>
inoremap <C-'> <Cmd>call MyTermToggle(0)<CR>
tnoremap <C-'> <Cmd>call MyTermToggle(0)<CR>

nnoremap <C-1> <Cmd>call MyTermToggle(1)<CR>
inoremap <C-1> <Cmd>call MyTermToggle(1)<CR>
tnoremap <C-1> <Cmd>call MyTermToggle(1)<CR>

nnoremap <C-2> <Cmd>call MyTermToggle(2)<CR>
inoremap <C-2> <Cmd>call MyTermToggle(2)<CR>
tnoremap <C-2> <Cmd>call MyTermToggle(2)<CR>

nnoremap <C-3> <Cmd>call MyTermToggle(3)<CR>
inoremap <C-3> <Cmd>call MyTermToggle(3)<CR>
tnoremap <C-3> <Cmd>call MyTermToggle(3)<CR>

function SendToFirstTerm(args)
    for chan in nvim_list_chans()
        if chan["mode"] != "terminal"
            continue
        endif

        let l:buffn = chan["buffer"]
        let l:buffname = nvim_buf_get_name(l:buffn)

        let l:search_term = "dreamterm::" . tabpagenr()
        if stridx(l:buffname, l:search_term) != -1
            call chansend(chan["id"], a:args . "\<CR>")
            break
        endif
    endfor
endfunction
command! -nargs=1 -complete=shellcmd Cmd call SendToFirstTerm(<q-args>)


" Session-tab things
function! MyTabLabel(n)
    return fnamemodify(getcwd(-1, a:n), ":t")
endfunction

" Tabline
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif
        let s ..= '%' .. (i + 1) .. 'T'
        let s ..= '  %{MyTabLabel(' .. (i + 1) .. ')}  '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction
:set tabline=%!MyTabLine()

let t:session_tab_term_index = 1
function! NewSessionTabEntered()
    let t:session_tab_term_index = 1
    let t:last_toggled_term_winid = 1
    let t:last_toggled_nonterm_winid = win_getid()
endfunction

augroup SessionTab
    autocmd! TabNew * call NewSessionTabEntered()
augroup END

function! NewSessionTab(path)
    exec "$tabnew ".a:path
    if isdirectory(a:path)
        exec "tcd ".a:path
    endif
    exec timer_start(50, "TimerVertTerm")
endfunction
command! -nargs=1 -complete=dir Tab call NewSessionTab(<q-args>)

nnoremap <silent> <C-Tab> :tabn<CR>
inoremap <silent> <C-Tab> <ESC>:tabn<CR>
vnoremap <silent> <C-Tab> <ESC>:tabn<CR>
nnoremap <silent> <C-S-Tab> :tabp<CR>
inoremap <silent> <C-S-Tab> <ESC>:tabp<CR>
vnoremap <silent> <C-S-Tab> <ESC>:tabp<CR>
nnoremap <silent> <Leader>1 1gt
vnoremap <silent> <Leader>1 <ESC>1gt
nnoremap <silent> <Leader>2 2gt
vnoremap <silent> <Leader>2 <ESC>2gt
nnoremap <silent> <Leader>3 3gt
vnoremap <silent> <Leader>3 <ESC>3gt
nnoremap <silent> <Leader>4 4gt
vnoremap <silent> <Leader>4 <ESC>4gt
nnoremap <silent> <Leader>Q :tabc<CR>
vnoremap <silent> <Leader>Q <ESC>:tabc<CR>


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

" CD Here command
command! CdHere tcd %:p:h


" General plugin settings
let g:plug_window = "vertical new"
let g:ctrlp_cmd = "CtrlPLastMode"
let g:ctrlp_map = "<C-p>"
let g:ctrlp_working_path_mode = "wra"
let g:ctrlp_user_command = [".git", "cd %s && git ls-files -co --exclude-standard"]
let g:ctrlp_use_caching = 0
let g:ctrlp_by_filename = 0
let g:vue_pre_processors = "detect_on_enter"
let g:netrw_cygwin = 0
let g:netrw_fastbrowse = 0
let g:cpp_attributes_highlight = 1
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
let g:zig_fmt_autosave = 0
set signcolumn=no
hi! link GitGutterAddLineNr DiffAdd
hi! link GitGutterChangeLineNr DiffChange
hi! link GitGutterDeleteLineNr DiffDelete
hi! link GitGutterChangeDeleteLineNr DiffChangeDelete

" Setup CoC
let g:coc_config_home = stdpath('config')

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

" Enable comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

" Custom easy align delimiters
let g:easy_align_delimiters = {
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ }

" Call lua init
exec "source " . stdpath('config') . "/lua_init.lua"
