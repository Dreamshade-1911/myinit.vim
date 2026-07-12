" Palette:
"   ident            #FFFFFF   keywords / control flow
"   normal           #DBCAA4   default foreground (sand)
"   define           #BCC7DA   preprocessor / namespaces
"   deselected       #101010   foreground on bright selections
"   dark_background  #061214   floats / GUI Normal bg
"   background       #091B1F   panels (statusline, pmenu, tabfill)
"   light_background #112D32   cursorline / folds / column
"   constant         #7EE6E1   numbers / specials (cyan)
"   string           #21C2A5   strings (teal)
"   type             #3EC984   types (green)
"   comment          #67B32E   comments (olive)
"   dim              #3E5A5E   line numbers / inactive chrome
"   red / yellow     #EE5555 / #E3B749   errors / warnings

hi clear
if exists("syntax_on")
    syntax reset
endif
set background=dark
let g:colors_name = "dreamshade"

" ----- Base -----------------------------------------------------------------
if exists("g:nvui") || exists("g:neovide")
    hi Normal       guifg=#DBCAA4 guibg=#061214
    hi NormalActive guibg=#091B1F
else
    hi Normal       guifg=#DBCAA4 guibg=NONE ctermbg=NONE
endif
hi NormalNC     guifg=#DBCAA4 guibg=NONE
hi NormalFloat  guifg=#DBCAA4 guibg=#061214
hi FloatBorder  guifg=#112D32 guibg=#061214
hi FloatTitle   guifg=#3EC984 guibg=#061214 gui=bold

" ----- UI chrome ------------------------------------------------------------
hi Cursor       guifg=#061214 guibg=#DBCAA4
hi CursorLine   guibg=#112D32 guifg=NONE ctermbg=NONE ctermfg=NONE
hi CursorLineNr guifg=#101010 guibg=#BCC7DA gui=bold ctermfg=NONE
hi LineNr       guifg=#3E5A5E guibg=NONE
hi LineNrAbove  guifg=#3E5A5E guibg=NONE
hi LineNrBelow  guifg=#3E5A5E guibg=NONE
hi SignColumn   guibg=NONE
hi FoldColumn   guifg=#3E5A5E guibg=NONE
hi Folded       guifg=#DBCAA4 guibg=#112D32
hi ColorColumn  guibg=#112D32
hi VertSplit    guifg=#112D32 guibg=#091B1F
hi WinSeparator guifg=#112D32 guibg=#091B1F
hi EndOfBuffer  guifg=#091B1F guibg=NONE
hi NonText      guifg=#3E5A5E guibg=NONE ctermbg=NONE
hi SpecialKey   guifg=#3E5A5E
hi Whitespace   guifg=#1F3A3E
hi Conceal      guifg=#3E5A5E
hi Directory    guifg=#3EC984
hi Title        guifg=#3EC984 gui=bold
hi MatchParen   guifg=#101010 guibg=#3EC984
hi IblIndent    guifg=#173238
hi IblScope     guifg=#3E5A5E

" ----- Statusline / Tabline -------------------------------------------------
hi StatusLine   guifg=#DBCAA4 guibg=#091B1F
hi StatusLineNC guifg=#3E5A5E guibg=#091B1F
hi TabLineFill  guibg=#091B1F
hi TabLine      guifg=#82DDD9 guibg=#112D32
hi TabLineSel   guifg=#101010 guibg=#3EC984

" ----- Completion popup -----------------------------------------------------
hi Pmenu              guifg=#DBCAA4 guibg=#091B1F
hi PmenuSel           guifg=#101010 guibg=#3EC984 gui=NONE
hi PmenuKind          guifg=#3EC984 guibg=#091B1F
hi PmenuExtra         guifg=#67B32E guibg=#091B1F
hi PmenuSbar          guibg=#112D32
hi PmenuThumb         guibg=#3EC984
hi! link WildMenu PmenuSel
hi BlinkCmpLabelMatch guifg=#7EE6E1 gui=bold
hi BlinkCmpDoc        guifg=#DBCAA4 guibg=#061214
hi BlinkCmpDocBorder  guifg=#112D32 guibg=#061214

" ----- Search / selection ---------------------------------------------------
hi Visual     guifg=#101010 guibg=#3EC984
hi VisualNOS  guifg=#101010 guibg=#3EC984
hi Search     guifg=#101010 guibg=#3EC984
hi Substitute guifg=#101010 guibg=#3EC984
hi IncSearch  guifg=#101010 guibg=#BCC7DA
hi CurSearch  guifg=#101010 guibg=#BCC7DA

" ----- Messages / errors ----------------------------------------------------
hi ErrorMsg   guifg=#EE5555 gui=bold
hi WarningMsg guifg=#E3B749
hi ModeMsg    guifg=#DBCAA4
hi MoreMsg    guifg=#3EC984
hi Question   guifg=#3EC984
hi Error      guifg=#FFFFFF guibg=#7A1F1F
hi Todo       guifg=#E3B749 gui=underline,bold
hi NoCheckin  guifg=#EE1010 gui=underline,bold
hi link ExtraWhitespace Error

" ----- Diffs ----------------------------------------------------------------
hi DiffAdd    guifg=#0E2E18 guibg=#88B68C
hi DiffChange guifg=#2E2708 guibg=#EDE198
hi DiffText   guifg=#2E2708 guibg=#CEB863
hi DiffDelete guifg=#3A1212 guibg=#F08484
hi! link DiffChangeDelete DiffDelete

" ----- Diagnostics ----------------------------------------------------------
hi DiagnosticError guifg=#EE5555
hi DiagnosticWarn  guifg=#E3B749
hi DiagnosticInfo  guifg=#7EE6E1
hi DiagnosticHint  guifg=#67B32E
hi DiagnosticOk    guifg=#3EC984
hi DiagnosticUnderlineError gui=undercurl guisp=#EE5555
hi DiagnosticUnderlineWarn  gui=undercurl guisp=#E3B749
hi DiagnosticUnderlineInfo  gui=undercurl guisp=#7EE6E1
hi DiagnosticUnderlineHint  gui=undercurl guisp=#67B32E

" ----- git (gitgutter) ------------------------------------------------------
hi GitGutterAdd          guifg=#3EC984
hi GitGutterChange       guifg=#E3B749
hi GitGutterDelete       guifg=#EE5555
hi GitGutterChangeDelete guifg=#E3B749
hi! link GitGutterAddLineNr          DiffAdd
hi! link GitGutterChangeLineNr       DiffChange
hi! link GitGutterDeleteLineNr       DiffDelete
hi! link GitGutterChangeDeleteLineNr DiffChangeDelete

" ----- leap.nvim ------------------------------------------------------------
hi LeapMatch          guifg=#101010 guibg=#7EE6E1 gui=bold
hi LeapLabelPrimary   guifg=#101010 guibg=#3EC984 gui=bold
hi LeapLabelSecondary guifg=#101010 guibg=#E3B749 gui=bold
hi LeapBackdrop       guifg=#3E5A5E

" ----- Syntax ---------------------------------------------------------------
hi Comment      guifg=#67B32E
hi Constant     guifg=#D8DEE9
hi String       guifg=#21C2A5
hi Character    guifg=#21C2A5
hi Number       guifg=#7EE6E1
hi Boolean      guifg=#7EE6E1
hi Float        guifg=#7EE6E1
hi Identifier   guifg=#DBCAA4 gui=NONE
hi Function     guifg=#DBCAA4
hi Statement    guifg=#FFFFFF gui=NONE
hi Conditional  guifg=#FFFFFF gui=NONE
hi Repeat       guifg=#FFFFFF gui=NONE
hi Label        guifg=#FFFFFF gui=NONE
hi Keyword      guifg=#FFFFFF gui=NONE
hi Exception    guifg=#FFFFFF gui=NONE
hi Operator     guifg=#DBCAA4
hi PreProc      guifg=#BCC7DA
hi Include      guifg=#BCC7DA
hi Define       guifg=#BCC7DA
hi Macro        guifg=#BCC7DA
hi PreCondit    guifg=#BCC7DA
hi Type         guifg=#3EC984
hi StorageClass guifg=#3EC984 gui=NONE
hi Structure    guifg=#3EC984 gui=NONE
hi Typedef      guifg=#3EC984
hi Special      guifg=#7EE6E1
hi SpecialChar  guifg=#7EE6E1
hi Tag          guifg=#3EC984
hi Delimiter    guifg=#DBCAA4
hi SpecialComment guifg=#67B32E gui=bold
hi Debug        guifg=#7EE6E1
hi Underlined   guifg=#7EE6E1 gui=underline
hi Ignore       guifg=#091B1F

" ----- Filetype-specific tweaks ---------------------------------------------
hi vimMapRhs                     guifg=#DBCAA4
hi vimFuncName                   guifg=#DBCAA4
hi vimUserFunc                   guifg=#DBCAA4
hi vimUserAttrbKey               guifg=#DBCAA4
hi vimNotation                   guifg=#3EC984
hi javaScript                    guifg=#DBCAA4
hi htmlTagN                      guifg=#DBCAA4
hi htmlTagName                   guifg=#DBCAA4
hi htmlTag                       guifg=#BCC7DA
hi htmlArg                       guifg=#BCC7DA
hi vbComment                     guifg=#21C2A5
hi cIncluded                     guifg=#21C2A5
hi cppNamespace                  guifg=#BCC7DA
hi sSymbols                      guifg=#BCC7DA
hi CppModifier                   guifg=#FFFFFF gui=NONE
hi typescriptClassname           guifg=#3EC984 gui=NONE
hi typescriptTypeParameter       guifg=#3EC984
hi typescriptInterfaceName       guifg=#3EC984 gui=NONE
hi typescriptTypeReference       guifg=#3EC984 gui=NONE
hi typescriptDecorator           guifg=#7EE6E1
hi typescriptTemplateSubstitution guifg=#7EE6E1
hi typescriptTemplateSB          guifg=#7EE6E1
hi typescriptRegexpString        guifg=#7EE6E1
hi! link odinAttribute Special
hi! link odinExtNumber odinNumber
hi! link odinExtHex    odinNumber

" ----- Terminal colours -----------------------------------------------------
let g:terminal_color_0  = "#101010"
let g:terminal_color_1  = "#EE5555"
let g:terminal_color_2  = "#3EC984"
let g:terminal_color_3  = "#E3B749"
let g:terminal_color_4  = "#82DDD9"
let g:terminal_color_5  = "#BCC7DA"
let g:terminal_color_6  = "#7EE6E1"
let g:terminal_color_7  = "#DBCAA4"
let g:terminal_color_8  = "#3E5A5E"
let g:terminal_color_9  = "#FF7777"
let g:terminal_color_10 = "#55D89A"
let g:terminal_color_11 = "#F0CF6B"
let g:terminal_color_12 = "#A0E8E4"
let g:terminal_color_13 = "#D6BEE8"
let g:terminal_color_14 = "#A6F0EC"
let g:terminal_color_15 = "#FFFFFF"
