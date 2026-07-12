vim.o.compatible = false
vim.o.termguicolors = true
vim.cmd("filetype plugin on")
vim.cmd("syntax enable")

-- If the argument passed is a folder, set it as cwd and open it through oil.
if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    vim.cmd("cd " .. vim.fn.argv(0))
    vim.cmd("tcd " .. vim.fn.argv(0))
    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
            vim.schedule(function() vim.cmd("Oil .") end)
        end,
    })
elseif vim.fn.argc() == 1 then
    vim.cmd("cd %:h")
    vim.cmd("tcd %:h")
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
vim.o.guifont = "FiraMono Nerd Font:h12"
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
vim.o.modeline = false
vim.o.synmaxcol = 1000
vim.o.buflisted = false
vim.o.splitbelow = true
vim.opt.fillchars:append({ vert = " ", eob = " " })
vim.o.sessionoptions = "blank,curdir,folds,help,tabpages,resize,winsize,winpos,terminal"
vim.opt.wildignore:append({
    "data", "tmp", ".tmp", "*.swp", "*.zip", "*.exe", "*.obj", ".vscode", ".vs", ".git",
    "node_modules", "bin", "build", "dist", "*.png", "*.jpeg", "*.jpg", "*.svg",
    "*.bmp", "package-lock.json", "yarn.lock", "*.pdb", "*.map", "third_party", "deps",
    ".nyc_output", "obj", "Packages", "ProjectSettings", "UserSettings", "Library", "Logs",
    ".ttf"
})
-- Windows' default shellpipe ('2>&1| tee') is fragile; native redirection is reliable.
if vim.fn.has("win32") == 1 then vim.o.shellpipe = ">%s 2>&1" end

vim.cmd([[cnoreabbrev grep silent grep]])
vim.cmd([[cnoreabbrev S Subvert]])
vim.cmd([[cnoreabbrev %S %Subvert]])

-- Open QuickFix window on grepping
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    command = "botright cwindow 18",
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "l*",
    command = "botright lwindow 18",
})

-- vim-dispatch's async :Make opens the quickfix on completion but (unlike built-in :make)
-- doesn't jump to the first error. Do it ourselves, but only when there's a real error, and
-- deferred so it runs after dispatch's call stack unwinds (jumping mid-event would clobber the
-- buffer-local makeprg/errorformat dispatch restores afterwards).
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "make",
    callback = function()
        for _, e in ipairs(vim.fn.getqflist()) do
            if e.valid == 1 then
                vim.schedule(function() pcall(vim.cmd, "cfirst") end)
                return
            end
        end
    end,
})

-- Enable comments in JSON files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    command = [[syntax match Comment +\/\/.\+$+]],
})

vim.filetype.add({
    extension = {
        hlsl = "hlsl", hlsli = "hlsl",
        fx = "hlsl", fxh = "hlsl",
        cginc = "hlsl", compute = "hlsl",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "hlsl",
    callback = function()
        vim.bo.cindent = true
        vim.bo.commentstring = "// %s"
    end,
})

-- Odin error format
vim.opt.errorformat:append("%A%f(%l:%c) %m,%Z%s%p^%.%#")

local function expand_brackets()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexed

  local pairs_map = { ["("] = ")", ["{"] = "}", ["["] = "]" }

  -- Search backward from cursor for the nearest adjacent open-close pair
  local found_open = nil
  for p = col - 1, 0, -1 do
    local ch = line:sub(p + 1, p + 1)       -- char at position p
    local next_ch = line:sub(p + 2, p + 2)  -- char at position p+1
    if pairs_map[ch] and pairs_map[ch] == next_ch then
      found_open = ch
      break
    end
  end

  if found_open then
    local keys = vim.api.nvim_replace_termcodes(
      "<ESC>F" .. found_open .. "a<CR><ESC>O", true, false, true
    )
    vim.api.nvim_feedkeys(keys, "n", false)
  end
end

-- General remaps
local map = vim.keymap.set
map("n", ")", "^")
map("v", ")", "^")
map("i", "<C-u>", "<ESC>viwUea")
map("i", "<C-CR>", "<ESC>O")
map("i", "<S-CR>", expand_brackets)
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

-- Run my build scripts if present, otherwise fallback to default make.
local function run_build(cmd)
    local win = vim.fn.has("win32") == 1
    local script = win and "build.bat" or "build.sh"
    local suffix = cmd ~= "" and " " .. cmd or ""
    local saved = vim.o.makeprg
    if vim.fn.filereadable(script) == 1 then
        vim.o.makeprg = win and ".\\build.bat" or "./build.sh"
    end
    vim.cmd("Make" .. suffix)
    vim.o.makeprg = saved
end
map({ "n", "i" }, "<F11>", function() run_build("") end, { silent = true })
map({ "n", "i" }, "<F12>", function() run_build("dev") end, { silent = true })

-- Leader keybinds
map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
map("n", "<Leader><Leader>", ":source $MYVIMRC<CR>", { silent = true })
map("n", "<Leader>'", ":e $MYVIMRC<CR>", { silent = true })
map("n", '<Leader>"', ":vs $MYVIMRC<CR>", { silent = true })
map("n", "<Leader>e", ":Oil %:h<CR>", { silent = true })
map("n", "<Leader>E", ":vs %:h<CR>", { silent = true })
map("n", "<Leader>.", ":Oil .<CR>", { silent = true })
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
local function move_window(dir)
    return function()
        local nnp = require("no-neck-pain")
        local state = require("no-neck-pain.state")
        local was_on = state and state.enabled

        if was_on then nnp.disable() end
        vim.cmd("wincmd " .. dir)
        if was_on then nnp.enable() end
    end
end
map("n", "<Leader>H", move_window("H"))
map("n", "<Leader>J", move_window("J"))
map("n", "<Leader>K", move_window("K"))
map("n", "<Leader>L", move_window("L"))

-- Paste and re-indent keymaps
local function paste(cmd)
  return function()
    local reg = vim.v.register
    local count = vim.v.count1
    -- Do the actual paste, honoring register + count (e.g. "a3p still works)
    vim.cmd('normal! "' .. reg .. count .. cmd)
    -- Re-indent only linewise pastes
    if vim.fn.getregtype(reg):sub(1, 1) == 'V' then
      vim.cmd('normal! `[=`]')
    end
  end
end
vim.keymap.set('n', 'p', paste('p'), { desc = 'Paste below + auto-indent' })
vim.keymap.set('n', 'P', paste('P'), { desc = 'Paste above + auto-indent' })

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

-- Commands
vim.api.nvim_create_user_command("Retab", "set expandtab | %retab!", {})

-- General plugin settings
vim.g.ctrlp_cmd = "CtrlPLastMode"
vim.g.ctrlp_map = "<C-p>"
vim.g.ctrlp_working_path_mode = "ra"
vim.g.ctrlp_show_hidden = 1
vim.g.ctrlp_use_caching = 0
vim.g.ctrlp_by_filename = 0
vim.g.ctrlp_root_markers = { "package.json", "makefile", "build.bat", "build.sh" }
vim.g.ctrlp_clear_cache_on_exit = 1
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --color=never"
    vim.opt.grepformat = "%f:%l:%c:%m"
    vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
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

-- LSP keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "LSP goto definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP hover" })

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

-- Colors for lualine.
local colors = {
    darkg     = "#091B1F",
    lightg    = "#132C30",
    vibrantg  = "#55C08E",
    black     = "#101010",
    green     = "#27CCAE",
    lightblue = "#82DDD9",
}
local lualine_theme = {
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

require("lazy").setup({
    spec = {
        -- Non-lazy first
        { "tpope/vim-fugitive", lazy = false },
        { "junegunn/vim-easy-align", lazy = false },
        { "airblade/vim-gitgutter", lazy = false },
        { "djoshea/vim-autoread", lazy = false },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            lazy = false,
            opts = { indent = { char = "▏" } },
        },
        { "ctrlpvim/ctrlp.vim", lazy = false },
        {
            "neovim/nvim-lspconfig",
            lazy = false,
            dependencies = {
                "mason-org/mason.nvim",
                "mason-org/mason-lspconfig.nvim",
                "saghen/blink.cmp",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "ts_ls", "vue_ls", "gopls", "html",
                        "cssls", "yamlls", "vimls",
                    },
                })

                vim.lsp.config("*", {
                    capabilities = require("blink.cmp").get_lsp_capabilities(),
                })

                vim.lsp.config("ols", {
                    cmd = { "ols" },
                    filetypes = { "odin" },
                    root_markers = { "ols.json", "build.bat", "build.sh", "makefile", ".git" },
                })
                vim.lsp.enable("ols")

                local vue_plugin = vim.fn.expand(
                    "$MASON/packages/vue-language-server/node_modules/@vue/language-server")
                vim.lsp.config("ts_ls", {
                    filetypes = { "javascript", "typescript", "vue" },
                    init_options = {
                        plugins = {
                            { name = "@vue/typescript-plugin", location = vue_plugin, languages = { "vue" } },
                        },
                    },
                })
            end,
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            lazy = false,
            opts = {
                keymap = {
                    preset = "none",
                    ["<S-Tab>"] = { "select_and_accept", "show", "fallback" },
                    ["<Up>"]    = { "select_prev", "fallback" },
                    ["<Down>"]  = { "select_next", "fallback" },
                    ["<C-e>"]   = { "hide", "fallback" },
                },
                completion = {
                    menu = { auto_show = true },
                    documentation = { auto_show = false },
                    accept = { auto_brackets = { enabled = false } },
                },
                signature = {
                    enabled = true,
                    window = { show_documentation = true },
                },
            },
        },
        {
            "shortcuts/no-neck-pain.nvim",
            lazy = false,
            opts = {
                width = 150,
                autocmds = {
                    enableOnVimEnter = true,
                },
                integrations = {
                    undotree = { position = "left" },
                },
            },
        },
        { "tpope/vim-sleuth", lazy = false },
        { "https://codeberg.org/andyg/leap.nvim", lazy = false },
        { "OXY2DEV/markview.nvim", lazy = false },
        {
            'stevearc/oil.nvim',
            -- Optional dependencies
            dependencies = { { "nvim-mini/mini.icons", opts = {} } },
            -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
            -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
            lazy = false,
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {
                default_file_explorer = true,
                view_options = {
                    show_hidden = true,
                },
                keymaps = {
                    ["<C-p>"] = false,
                    ["<Leader>p"] = "actions.preview",
                },
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            lazy = false,
            opts = {
                icons_enabled = false,
                options = {
                    theme = lualine_theme,
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
                    lualine_b = { "branch" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "fileformat" },
                    lualine_y = { "filetype", "progress" },
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
            },
        },

        -- Lazy plugins
        { "tpope/vim-abolish" },
        { "tpope/vim-commentary" },
        { "tpope/vim-dispatch" },
        { "mbbill/undotree" },
        { "editorconfig/editorconfig-vim" },
        { "Tetralux/odin.vim" },
        { "tikhomirov/vim-glsl" },
        { "beyondmarc/hlsl.vim", ft = "hlsl" },
        { "rluba/jai.vim" },
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true, notify = false },
})

vim.opt.shadafile = "NONE"

---------------------------------------------------------------------------
-- Plugin configs
---------------------------------------------------------------------------
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

vim.cmd("source " .. vim.fn.stdpath("config") .. "/dreamshade_theme.vim")
