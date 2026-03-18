vim.o.compatible = false
vim.o.termguicolors = true
vim.cmd("filetype plugin on")
vim.cmd("syntax enable")

-- If the argument passed is a folder, set it as cwd.
if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    vim.cmd("cd " .. vim.fn.argv(0))
    vim.cmd("tcd " .. vim.fn.argv(0))
elseif vim.fn.argc() == 1 then
    vim.cmd("cd %:h")
    vim.cmd("tcd %:h")
end

-- Acrylic transparency helper (Windows only)
local function run_acrylic(win_name)
    if vim.fn.has("win32") == 1 and vim.fn.executable("acrylic") == 1 then
        vim.api.nvim_create_autocmd("UIEnter", {
            once = true,
            callback = function()
                vim.fn.system("acrylic " .. win_name)
            end,
        })
    end
end

-- GUI-specific settings
if vim.g.neovide then
    vim.g.neovide_padding_left = 5
    vim.g.neovide_padding_right = 5
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_refresh_rate_idle = 14
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_scroll_animation_far_lines = 9999
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_animation_length = 0.1
    vim.g.neovide_cursor_trail_size = 0.5
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 5.0
    vim.g.neovide_floating_blur_amount_y = 5.0
    vim.g.neovide_floating_corner_radius = 6.0
    vim.g.neovide_opacity = 0.8
    vim.g.neovide_title_background_color = "#061214"
    vim.g.neovide_title_text_color = "#DBCAA4"
    run_acrylic("Neovide")
elseif vim.g.nvui then
    vim.cmd([[
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
    ]])
end

-- General options
vim.o.guifont = "FiraMono Nerd Font:h11"
vim.o.guicursor = "i-c-ci-sm-o:hor50,n-r-v-ve-cr-ve:block,a:-blinkwait500-blinkon800-blinkoff300"
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.autoread = true
vim.o.showmatch = true
vim.o.autoindent = true
vim.o.wildmode = "longest,list"
vim.o.timeoutlen = 500
vim.o.scrolloff = 26
vim.o.number = true
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.backspace = "indent,eol,start"
vim.o.encoding = "utf-8"
vim.o.splitright = true
vim.o.wildmenu = true
vim.o.clipboard = "unnamed,unnamedplus"
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 500
vim.opt.shortmess:append("c")
vim.o.signcolumn = "no"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.path:append("**")
vim.o.foldenable = false
vim.o.synmaxcol = 1000
vim.o.buflisted = false
vim.o.splitbelow = true
vim.opt.fillchars:append({ vert = " ", eob = " " })
vim.o.sessionoptions = "blank,curdir,folds,help,tabpages,resize,winsize,winpos,terminal"
vim.opt.wildignore:append({
    "tmp", ".tmp", "*.swp", "*.zip", "*.exe", "*.obj", ".vscode", ".vs", ".git",
    "node_modules", "bin", "build", "dist", "*.png", "*.jpeg", "*.jpg", "*.svg",
    "*.bmp", "package-lock.json", "yarn.lock", "*.pdb", "*.map", "third_party",
    ".nyc_output", "obj", "Packages", "ProjectSettings", "UserSettings", "Library", "Logs",
})

-- Abbreviate "silent grep" as "grep"
vim.cmd([[cnoreabbrev grep silent grep]])

-- Open QuickFix window on grepping
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    command = "botright cwindow 18",
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "l*",
    command = "botright lwindow 18",
})

-- Enable comments in JSON files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    command = [[syntax match Comment +\/\/.\+$+]],
})

-- Odin error format
vim.opt.errorformat:append("%A%f(%l:%c) %m,%Z%s%p^%.%#")

-- General remaps
local map = vim.keymap.set
map("n", ")", "^")
map("v", ")", "^")
map("i", "<C-u>", "<ESC>viwUea")
map("i", "<S-CR>", "<ESC>O")
map("i", "<C-CR>", "<ESC>F{a<CR><ESC>O")
map("i", "<C-BS>", "<ESC>diwi")
map("t", "<Esc>", "<C-\\><C-n>")
map("n", "<C-Left>", "<Cmd>vertical resize -15<CR>", { silent = true })
map("n", "<C-Right>", "<Cmd>vertical resize +15<CR>", { silent = true })
map({ "n", "v", "o" }, "j", function() return vim.v.count > 0 and "j" or "gj" end, { expr = true })
map({ "n", "v", "o" }, "k", function() return vim.v.count > 0 and "k" or "gk" end, { expr = true })
-- Clear last search and reset syntax highlighting
map("n", "<C-l>", ':let @/ = ""|:mod|:syntax sync fromstart<CR>', { silent = true })
map("n", "<F1>", "<Cmd>set ignorecase! ignorecase?<CR>")
map("n", "<PageDown>", "<C-d>")
map("i", "<PageDown>", "<Esc><C-d>")
map("v", "<PageDown>", "<C-d>")
map("t", "<PageDown>", "<C-d>")
map("n", "<PageUp>", "<C-u>")
map("i", "<PageUp>", "<Esc><C-u>")
map("v", "<PageUp>", "<C-u>")
map("t", "<PageUp>", "<C-u>")
map("n", "<C-j>", "ddp")
map("i", "<C-j>", "<Esc>ddpi")
map("n", "<C-k>", "ddkP")
map("i", "<C-k>", "<Esc>ddkPi")

-- Toggle QuickFix
local function toggle_quickfix()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("botright cwindow 18")
end
map("n", "<F8>", toggle_quickfix, { silent = true })

map("n", "<F2>", "@:<CR>", { silent = true })
map({ "n", "i", "v", "t" }, "<F5>", "<Cmd>NoNeckPain<CR>", { silent = true })
map({ "n", "i" }, "<F9>", "<Cmd>cprev<CR>", { silent = true })
map({ "n", "i" }, "<F10>", "<Cmd>cnext<CR>", { silent = true })
map({ "n", "i" }, "<F11>", "<Cmd>Make build<CR>", { silent = true })
map({ "n", "i" }, "<F12>", "<Cmd>vert Start make<CR>", { silent = true })

-- Leader keybinds
map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
map("n", "<Leader><Leader>", ":source $MYVIMRC<CR>", { silent = true })
map("n", "<Leader>'", ":e $MYVIMRC<CR>", { silent = true })
map("n", '<Leader>"', ":vs $MYVIMRC<CR>", { silent = true })
map("n", "<Leader>e", ":e %:h<CR>", { silent = true })
map("n", "<Leader>E", ":vs %:h<CR>", { silent = true })
map("n", "<Leader>.", ":e .<CR>", { silent = true })
map("n", "<Leader>p", "pkdd", { silent = true })
map("n", "<Leader>0", '"0p')
map("n", "<Leader>)", '"0P')
map("n", "<Leader>w", ":w<CR>", { silent = true })
map("n", "<Leader>q", ":q<CR>", { silent = true })
map("n", "<Leader>u", ":UndotreeToggle<CR>", { silent = true })

map("n", "<Leader>gp", "<Plug>(GitGutterPreviewHunk)")
map("n", "<Leader>gu", "<Plug>(GitGutterUndoHunk)")
map({ "n", "x" }, "<Leader>gs", "<Plug>(GitGutterStageHunk)")

map({ "x", "n" }, "ga", "<Plug>(EasyAlign)")

-- Moving between windows
map("n", "<Leader>h", "<C-w>h")
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")
map("n", "<Leader>l", "<C-w>l")

-- Moving windows
map("n", "<Leader>H", "<C-w>H")
map("n", "<Leader>J", "<C-w>J")
map("n", "<Leader>K", "<C-w>K")
map("n", "<Leader>L", "<C-w>L")

-- Commands
vim.api.nvim_create_user_command("Cdhere", "tcd %:p:h", {})

-- Show SynGroup under cursor
vim.api.nvim_create_user_command("SynGroup", function()
    local s = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
    print(vim.fn.synIDattr(s, "name") .. " -> " .. vim.fn.synIDattr(vim.fn.synIDtrans(s), "name"))
end, {})

-- Increase and decrease font size
map("n", "<C-Up>", function()
    vim.o.guifont = vim.o.guifont:gsub(":h(%d+)", function(size)
        return ":h" .. (tonumber(size) + 1)
    end)
end, { silent = true })
map("n", "<C-Down>", function()
    vim.o.guifont = vim.o.guifont:gsub(":h(%d+)", function(size)
        return ":h" .. (tonumber(size) - 1)
    end)
end, { silent = true })

-- General plugin settings
vim.g.ctrlp_cmd = "CtrlPLastMode"
vim.g.ctrlp_map = "<C-p>"
vim.g.ctrlp_working_path_mode = "ra"
vim.g.ctrlp_show_hidden = 1
vim.g.ctrlp_use_caching = 0
vim.g.ctrlp_by_filename = 0
vim.g.ctrlp_root_markers = { "package.json", "makefile" }
vim.g.ctrlp_clear_cache_on_exit = 1
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --color=never"
    vim.opt.grepformat = "%f:%l:%c:%m"
    vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    vim.g.ctrlp_use_caching = 0
end
vim.g.vue_pre_processors = "detect_on_enter"
vim.g.netrw_cygwin = 0
vim.g.netrw_fastbrowse = 0
vim.g.cpp_attributes_highlight = 1
vim.g.gitgutter_enabled = 1
vim.g.gitgutter_signs = 0
vim.g.gitgutter_highlight_linenrs = 1
vim.g.zig_fmt_autosave = 0

-- Custom easy align delimiters
vim.g.easy_align_delimiters = {
    [">"] = { pattern = ">>\\|=>\\|>" },
    ["/"] = {
        pattern = "//\\+\\|/\\*\\|\\*/",
        delimiter_align = "l",
        ignore_groups = { "!Comment" },
    },
    ["]"] = {
        pattern = "[[\\]]",
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
    },
    [")"] = {
        pattern = "[()]",
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
    },
    d = { pattern = "-\\=\\d\\+\\(\\.\\d\\+\\)\\=,\\=" },
}

-- Setup CoC
vim.g.coc_config_home = vim.fn.stdpath("config")
vim.g.coc_global_extensions = {
    "coc-vimlsp", "coc-go", "coc-git", "coc-glslx",
    "coc-html-css-support", "coc-html", "coc-css",
    "coc-yaml", "coc-tsserver", "@yaegassy/coc-volar",
}

map("i", "<S-TAB>", function()
    if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#confirm"]()
    else
        return vim.fn["coc#refresh"]()
    end
end, { silent = true, expr = true })

map("n", "K", function()
    if vim.fn.CocAction("hasProvider", "hover") then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_feedkeys("K", "in", false)
    end
end, { silent = true })

-- GoTo code navigation
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gD", "<Cmd>vsp<CR><Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Symbol renaming
map("n", "<leader>r", "<Plug>(coc-rename)")

-- Formatting selected code
map({ "x", "n" }, "<F3>", "<Plug>(coc-format-selected)")

-- Function and class text objects
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)")
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)")
map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)")
map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)")

-- Scroll float windows/popups
map({ "n", "v" }, "<C-f>", function()
    if vim.fn["coc#float#has_scroll"]() == 1 then
        return vim.fn["coc#float#scroll"](1)
    else
        return "<C-f>"
    end
end, { silent = true, nowait = true, expr = true })
map({ "n", "v" }, "<C-b>", function()
    if vim.fn["coc#float#has_scroll"]() == 1 then
        return vim.fn["coc#float#scroll"](0)
    else
        return "<C-b>"
    end
end, { silent = true, nowait = true, expr = true })
map("i", "<C-f>", function()
    if vim.fn["coc#float#has_scroll"]() == 1 then
        return "<C-r>=coc#float#scroll(1)<CR>"
    else
        return "<Right>"
    end
end, { silent = true, nowait = true, expr = true })
map("i", "<C-b>", function()
    if vim.fn["coc#float#has_scroll"]() == 1 then
        return "<C-r>=coc#float#scroll(0)<CR>"
    else
        return "<Left>"
    end
end, { silent = true, nowait = true, expr = true })

-- Format command
vim.api.nvim_create_user_command("Format", function()
    vim.fn.CocAction("format")
end, {})

---------------------------------------------------------------------------
-- Bootstrap lazy.nvim
---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { "arcticicestudio/nord-vim", lazy = false, priority = 1000 },
        { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false },
        { "tpope/vim-fugitive", lazy = false },
        { "junegunn/vim-easy-align", lazy = false },
        { "airblade/vim-gitgutter", lazy = false },
        { "djoshea/vim-autoread", lazy = false },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", lazy = false },
        { "ctrlpvim/ctrlp.vim", lazy = false },
        { "neoclide/coc.nvim", lazy = false, build = "npm ci" },
        { "shortcuts/no-neck-pain.nvim", lazy = false },
        { "tpope/vim-sleuth", lazy = false },
        { "tpope/vim-abolish" },
        { "tpope/vim-commentary" },
        { "tpope/vim-dispatch" },
        { "rmagatti/auto-session" },
        { "mbbill/undotree" },
        { "ggandor/leap.nvim" },
        { "editorconfig/editorconfig-vim" },
        { "Tetralux/odin.vim" },
        { "tikhomirov/vim-glsl" },
        { "rluba/jai.vim" },
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
        -- This garbage is not working.
        -- { "kokusenz/delta.lua" },
        -- { "kokusenz/deltaview.nvim" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true, notify = false },
})

vim.opt.shadafile = "NONE"

---------------------------------------------------------------------------
-- Plugin configs
---------------------------------------------------------------------------
require("auto-session").setup({
    enabled = true,
    root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_save = true,
    auto_restore = true,
    auto_create = false,
    suppressed_dirs = nil,
    allowed_dirs = nil,
    auto_restore_last_session = false,
    use_git_branch = false,
    lazy_support = false,
    bypass_save_filetypes = nil,
    close_unsupported_windows = true,
    args_allow_single_directory = true,
    args_allow_files_auto_save = false,
    continue_restore_on_error = true,
    show_auto_restore_notif = false,
    cwd_change_handling = true,
    lsp_stop_on_restore = false,
    log_level = "error",
    session_lens = {
        load_on_setup = false,
        theme_conf = {},
        previewer = false,
        mappings = {},
        session_control = {
            control_dir = vim.fn.stdpath("data") .. "/auto_session/",
            control_filename = "session_control.json",
        },
        post_restore_cmds = { "NoNeckPain" },
    },
})

require("leap").add_default_mappings()

require("ibl").setup({
    indent = { char = "▏" },
})

require("no-neck-pain").setup({
    width = 150,
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
    },
    integrations = {
        undotree = { position = "left" },
    },
})

local colors = {
    darkg     = "#091B1F",
    lightg    = "#132C30",
    vibrantg  = "#55C08E",
    black     = "#101010",
    green     = "#27CCAE",
    lightblue = "#82DDD9",
}
local theme = {
    normal = {
        a = { bg = colors.vibrantg, fg = colors.black },
        b = { bg = colors.lightg, fg = colors.lightblue },
        c = { bg = colors.darkg, fg = colors.lightblue },
    },
    inactive = {
        a = { bg = colors.darkg, fg = colors.green },
        b = { bg = colors.darkg, fg = colors.green },
        c = { bg = colors.darkg, fg = colors.green },
    },
}
require("lualine").setup({
    icons_enabled = false,
    options = {
        theme = theme,
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "fileformat" },
        lualine_y = { "g:coc_status", "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
    },
    inactive_sections = {
        lualine_a = { { "filename", path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
})

---------------------------------------------------------------------------
-- Source colorscheme (kept as VimScript)
---------------------------------------------------------------------------
vim.cmd("source " .. vim.fn.stdpath("config") .. "/dreamshade_theme.vim")
