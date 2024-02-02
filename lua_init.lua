require("leap").add_default_mappings()
require("ibl").setup()
require("indent-o-matic").setup {
    max_lines = 2048,
    standard_widths = { 2, 4, 8 },
    skip_multine = true,
}

