syntax on
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'phaazon/hop.nvim'
Plug 'steelsojka/pears.nvim'
" List ends here. plugins become visible to vim after this call.
call plug#end()

lua << EOF
require "hop".setup()
require "pears".setup()
EOF

colorscheme nord
let g:airline_powerline_fonts = 1
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% '])

if get(g:, 'nvui', 0)
    hi Normal guibg=#1B1E23
    NvuiCursorHideWhileTyping 1
    " NvuiOpacity 1
    NvuiTitlebarBg #22272e
    NvuiTitlebarFontSize 10.5
    NvuiCursorAnimationDuration 0.1
endif

set guifont=Cousine\ for\ Powerline:h11
set guicursor+=a:-blinkwait500-blinkon800-blinkoff200
set guicursor+=o-i-r-c-ci-cr:-ver25
set cursorline
set showmatch
set expandtab
set autoindent
set wildmode=longest,list
set timeoutlen=500
set scrolloff=20
set number
set noswapfile
set mouse=a
set backspace=indent,eol,start
set encoding=utf-8
set splitright
set scroll=18
set filetype
set fileformat=dos
set wildmenu
set clipboard=unnamed
set hidden
set nobackup
set nowritebackup
set updatetime=500
set shortmess+=c
set signcolumn=number
set ignorecase
set smartcase

let g:detectindent_preferred_indent = 4
augroup DetectIndent
     autocmd!
     autocmd BufReadPost *  DetectIndent
augroup END
set wildignore+=tmp,.tmp,*.swp,*.zip,*.exe,*.obj,.vscode,.vs,.git,node_modules,bin,bin_client,bin_server,build,dist,data,*.png,*.jpeg,*.jpg,*.svg,*.bmp,package-lock.json,*.pdb,*.map

" Setup custom build script
function! CustomBuildCommand()
    if executable('build.sh') && executable('sudo')
        set makeprg=build.sh
    elseif executable('build.bat') && executable('cmd')
        set makeprg=build.bat
    endif
endfunction

augroup CustomBuildScript
    autocmd!
    autocmd DirChanged * call CustomBuildCommand()
augroup END
call CustomBuildCommand()

" Sane grep
augroup GrepQuickFix
    autocmd!
    autocmd QuickFixCmdPost [^l]* botright cwindow
    autocmd QuickFixCmdPost l* botright cwindow
augroup END
function! CustomGrep(str)
    execute 'vimgrep /\C'.a:str.'/j **/*'
endfunction
command! -nargs=* Grep call CustomGrep("<args>")

" General remaps
map ç <C-c>
nmap ç a
nmap Ç ^
imap ç <Esc>
imap Ç <C-o>
vmap Ç ^

" Clear last search highlighting with Ctrl+l and redraw
nnoremap <silent> <C-l> :let @/ = ""\|:mod<CR>

" Output the current syntax group
nnoremap <F11> :TSHighlightCapturesUnderCursor<CR>
nnoremap <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Leader keybinds
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <Leader><Leader> :source $myvimrc<CR>
nnoremap <silent> <Leader>' :e $myvimrc<CR>
nnoremap <silent> <Leader>" :vs $myvimrc<CR>
nnoremap <silent> <Leader>s :vs<CR><C-w>l
nnoremap <silent> <Leader>S <C-w>L
nnoremap <silent> <Leader>q <C-w>c
nnoremap <silent> <Leader>p :e %:h<CR>
nnoremap <silent> <Leader>P :vs %:h<CR>
nnoremap <silent> <Leader>1 "1p
nnoremap <silent> <Leader>! "1P
nnoremap <silent> <Leader>w :w<CR>
nnoremap <Leader>f :e **/
nnoremap <Leader>F :vs **/
nnoremap <silent> <F8> :cnext<CR>
nnoremap <silent> <F7> :cprevious<CR>
nnoremap <silent> <F4> @:<CR>
nnoremap <F1> :set ignorecase! ignorecase?<CR>
nnoremap s :HopWord<CR>
nnoremap S :HopLine<CR>
imap <S-CR> <ESC>O
imap <C-CR> <CR><ESC>kA

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

nnoremap <silent> <F9> :make!\|redraw\|botright cwindow<CR>
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        botright cwindow
    else
        cclose
    endif
endfunction
nnoremap <silent> <S-F9> :call ToggleQuickFix()<CR>

nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
xmap <Leader>gs <Plug>(GitGutterStageHunk)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" General plugin settings
let g:indent_blankline_show_trailing_blankline_indent = v:false

" Setup gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
set signcolumn=no
hi! link GitGutterAddLineNr DiffAdd
hi! link GitGutterChangeLineNr DiffChange
hi! link GitGutterDeleteLineNr DiffDelete
hi! link GitGutterChangeDeleteLineNr DiffChangeDelete

" Setup CoC
let g:coc_config_home = stdpath('config')
nnoremap <silent> <Leader>u :call CocActionAsync('doHover')<CR>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <F10> <Plug>(coc-format-selected)
nmap <F10> <Plug>(coc-format-selected)

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
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

