-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = "<Space>"
-- vim.g.maplocalleader = "<Space>"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            "arcticicestudio/nord-vim",
            lazy = false,
            priority = 1000,
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            lazy = false,
        },
        {
            "tpope/vim-fugitive",
            lazy = false,
        },
        {
            "junegunn/vim-easy-align",
            lazy = false,
        },
        {
            "airblade/vim-gitgutter",
            lazy = false,
        },
        {
            "djoshea/vim-autoread",
            lazy = false,
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            lazy = false,
        },
        {
            "ctrlpvim/ctrlp.vim",
            lazy = false,
        },
        {
            "neoclide/coc.nvim",
            lazy = false,
            build = "npm ci",
        },
        {
            "shortcuts/no-neck-pain.nvim",
            lazy = false,
        },
        {
            "tpope/vim-sleuth",
            lazy = false,
        },
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
        {
            "yetone/avante.nvim",
            -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
            -- ⚠️ must add this setting! ! !
            build = function()
                -- conditionally use the correct build system for the current OS
                if vim.fn.has("win32") == 1 then
                    return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
                else
                    return "make"
                end
            end,
            event = "VeryLazy",
            version = false, -- Never set this value to "*"! Never!
            ---@module 'avante'
            ---@type avante.Config
            opts = {
                -- add any opts here
                -- for example
                provider = "qwen3",
                auto_suggestions_provider = "qwen3",
                providers = {
                    qwen3 = {
                        __inherited_from = "openai",
                        api_key_name = "OS",
                        endpoint = "http://127.0.0.1:5001/v1",
                        model = "Qwen3-14B-Q4",
                    },
                },
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                --- The below dependencies are optional,
                "echasnovski/mini.pick", -- for file_selector provider mini.pick
                "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
                "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
                "ibhagwan/fzf-lua", -- for file_selector provider fzf
                "stevearc/dressing.nvim", -- for input provider dressing
                "folke/snacks.nvim", -- for input provider snacks
                "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
                {
                    -- support for image pasting
                    "HakonHarnes/img-clip.nvim",
                    event = "VeryLazy",
                    opts = {
                        -- recommended settings
                        default = {
                            embed_image_as_base64 = false,
                            prompt_for_file_name = false,
                            drag_and_drop = {
                              insert_mode = true,
                            },
                            -- required for Windows users
                            use_absolute_path = true,
                        },
                    },
                },
                {
                    -- Make sure to set this up properly if you have lazy=true
                    'MeanderingProgrammer/render-markdown.nvim',
                    opts = {
                        file_types = { "markdown", "Avante" },
                    },
                    ft = { "markdown", "Avante" },
                },
            },
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {
        colorscheme = { "habamax" },
    },
    -- automatically check for plugin updates
    checker = {
        enabled = true,
        notify = false,
    },
})

vim.opt.shadafile = "NONE"

require("auto-session").setup {
    enabled = true, -- Enables/disables auto creating, saving and restoring
    root_dir = vim.fn.stdpath "data" .. "/sessions/", -- Root dir where sessions will be stored
    auto_save = true, -- Enables/disables auto saving session on exit
    auto_restore = true, -- Enables/disables auto restoring session on start
    auto_create = false, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
    suppressed_dirs = nil, -- Suppress session restore/create in certain directories
    allowed_dirs = nil, -- Allow session restore/create in certain directories
    auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
    use_git_branch = false, -- Include git branch name in session name
    lazy_support = false, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
    bypass_save_filetypes = nil, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
    close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
    args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
    args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
    continue_restore_on_error = true, -- Keep loading the session even if there's an error
    show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
    cwd_change_handling = true, -- Follow cwd changes, saving a session before change and restoring after
    lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
    log_level = "error", -- Sets the log level of the plugin (debug, info, warn, error).

    session_lens = {
        load_on_setup = false, -- Initialize on startup (requires Telescope)
        theme_conf = { -- Pass through for Telescope theme options
            -- layout_config = { -- As one example, can change width/height of picker
            --   width = 0.8,    -- percent of window
            --   height = 0.5,
            -- },
        },
        previewer = false, -- File preview for session picker

        mappings = {
            -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
            -- delete_session = { "i", "<C-D>" },
            -- alternate_session = { "i", "<C-S>" },
            -- copy_session = { "i", "<C-Y>" },
        },

        session_control = {
            control_dir = vim.fn.stdpath "data" .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
            control_filename = "session_control.json", -- File name of the session control file
        },

        post_restore_cmds = { "NoNeckPain" },
    },
}

require("leap").add_default_mappings()

require("ibl").setup {
    indent = {
        char = "▏",
    },
}

-- require("indent-o-matic").setup {
--     max_lines = 2048,
--     standard_widths = { 2, 4, 8 },
--     skip_multine = true,
-- }

require("no-neck-pain").setup {
    width = 150,
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
    },
    integrations = {
        undotree = {
            position = "left",
        },
    },
}

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
        a = { bg = colors.vibrantg, fg = colors.black     },
        b = { bg = colors.lightg,   fg = colors.lightblue },
        c = { bg = colors.darkg,    fg = colors.lightblue },
    },
    inactive = {
        a = { bg = colors.darkg, fg = colors.green },
        b = { bg = colors.darkg, fg = colors.green },
        c = { bg = colors.darkg, fg = colors.green },
    },
}
require("lualine").setup {
    icons_enabled = false,
    options = {
        theme = theme,
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "branch" },
        lualine_c = {
            { "filename", path = 1 },
        },
        lualine_x = { "fileformat" },
        lualine_y = { "g:coc_status", "filetype", "progress" },
        lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = {
            { "filename", path = 1 }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
}
