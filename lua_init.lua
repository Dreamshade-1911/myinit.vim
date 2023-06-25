require('leap').add_default_mappings()

function TerminalOnOpen(terminal)
    vim.cmd("startinsert!")
end
require("toggleterm").setup{
    on_open = TerminalOnOpen,
    size = 25,
    open_mapping = [[<C-'>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    autochdir = true,
    persist_size = true,
    persist_mode = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_ops = {
        border = "curved",
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

