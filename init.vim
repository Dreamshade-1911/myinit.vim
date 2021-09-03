" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'arcticicestudio/nord-vim'
Plug 'Yggdroot/indentLine'
Plug 'justinmk/vim-sneak'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'roryokane/detectindent'
Plug 'djoshea/vim-autoread'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" List ends here. plugins become visible to vim after this call.
call plug#end()

syntax on
set termguicolors
colorscheme nord
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
let g:airline_powerline_fonts = 1
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" exec "source " . stdpath('config') . "/cppsyntax.vim"

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
set scroll=22
let g:detectindent_preferred_indent = 4
augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END
set wildignore+=tmp,.tmp,*.swp,*.zip,*.exe,*.obj,.vscode,.vs,node_modules,bin,bin_client,bin_server,build,dist

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Setup custom build script
function! CustomBuildCommand()
   if executable('build.bat')
      set makeprg=build.bat
   endif
endfunction

augroup CustomBuildScript
   autocmd!
   autocmd DirChanged * call CustomBuildCommand()
augroup END
call CustomBuildCommand()

" General remaps
map ç <C-c>
nmap ç a
imap ç <Esc>
imap Ç <C-o>

" Clear last search highlighting with Ctrl+l and redraw
nnoremap <silent> <C-l> :let @/ = ""\|:mod<CR>

" Leader keybinds
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <Leader><Leader> :source $myvimrc<CR>
nnoremap <silent> <Leader>' :e $myvimrc<CR>
nnoremap <silent> <Leader>s :vs<CR><C-w>l
nnoremap <silent> <Leader>S <C-w>L
nnoremap <silent> <Leader>q <C-w>c
nnoremap <silent> <Leader>p :e %:h<CR>
nnoremap <silent> <Leader>P :cd %:h<CR>
nnoremap <silent> <Leader>e :make\|redraw\|botright cwindow<CR>
nnoremap <silent> <Leader>E :copen<CR>
nnoremap <silent> <Leader>w :w<CR>

" OS Copy buffer
nnoremap <silent> <Leader>c "*y
nnoremap <silent> <Leader>v "*p
vnoremap <silent> <Leader>c "*y

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Setup gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
set signcolumn=no
hi! link GitGutterAddLineNr DiffAdd
hi! link GitGutterChangeLineNr DiffChange
hi! link GitGutterDeleteLineNr DiffDelete
hi! link GitGutterChangeDeleteLineNr DiffChangeDelete

" Change a few colors on the theme
" hi Comment guifg=#258661
" hi String guifg=#2EB8A6

" Setup lua plugins configs
lua << EOF
require('telescope').setup{
   defaults = {
      file_ignore_patterns = { "node_modules", ".git", "tmp", ".tmp", "*.obj", "*.exe", ".pdb", "bin", "bin_client", "bin_server", "build", "dist" };
   }
}
EOF

