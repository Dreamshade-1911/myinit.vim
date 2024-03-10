require("leap").add_default_mappings()

require("ibl").setup {
    indent = {
        char = "▏",
    },
}

require("indent-o-matic").setup {
    max_lines = 2048,
    standard_widths = { 2, 4, 8 },
    skip_multine = true,
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
