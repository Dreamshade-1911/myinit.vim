require("leap").add_default_mappings()
require("ibl").setup()

function TerminalOnOpen(terminal)
    if terminal.id == 1 then
        vim.cmd("wincmd H | vert resize 120")
    end
end

require("toggleterm").setup{
    on_open = TerminalOnOpen,
    start_in_insert = true,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = false,
    insert_mappings = true,
    autochdir = true,
    persist_size = true,
    persist_mode = false,
    direction = "vertical",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_ops = {
        border = "curved",
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}
