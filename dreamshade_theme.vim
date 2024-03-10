" This just changes a few colors from the Nord theme
function! OverrideColorSchemes()
    let l:ident            = "#FFFFFF"
    let l:normal           = "#DBCAA4"
    let l:define           = "#BCC7DA"
    let l:deselected       = "#101010"
    let l:dark_background  = "#061214"
    let l:background       = "#091B1F"
    let l:light_background = "#132C30"
    let l:constant         = "#7EE6E1"
    let l:string           = "#21C2A5"
    let l:type             = "#3EC984"
    let l:comment          = "#67B32E"

    exec "hi Normal guifg=" . l:normal " guibg=NONE ctermbg=NONE"
    exec "hi CursorLine guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE"
    exec "hi CursorLineNr guibg=" . l:define . " guifg= " . l:deselected . " gui=bold ctermfg=NONE"

    exec "hi StatusLine guibg=" . l:background
    exec "hi StatusLineNC guibg=" . l:background

    hi link ExtraWhitespace Error

    if exists("g:nvui") || exists("g:neovide")
        exec "hi Normal guibg=" . l:dark_background
        exec "hi NormalActive guibg=" . l:background
        exec "hi CursorLine guibg=" . l:light_background . " guifg=NONE ctermbg=NONE ctermfg=NONE"
    endif

    exec "hi TabLineFill guibg=" . l:background
    exec "hi TabLine guifg=#82DDD9 guibg=" . l:light_background
    exec "hi TabLineSel guifg=#101010 guibg=" . l:type

    exec "hi CurSearch guifg=" . l:deselected . " guibg=" . l:define
    exec "hi IncSearch guifg=" . l:deselected . " guibg=" . l:define
    exec "hi MatchParen guifg=" . l:deselected . " guibg=" . l:type
    exec "hi Visual guifg=" . l:deselected . " guibg=" . l:type
    exec "hi Search guifg=" . l:deselected . " guibg=" . l:type
    exec "hi Substitute guifg=" . l:deselected . " guibg=" . l:type

    exec "hi VertSplit guibg=" . l:background

    hi NonText guibg=NONE ctermbg=NONE

    exec "hi Identifier guifg=" . l:normal . " gui=NONE"
    exec "hi Function guifg=" . l:normal
    exec "hi Delimiter guifg=" . l:normal
    exec "hi Operator guifg=" . l:normal
    exec "hi vimMapRhs guifg=" . l:normal
    exec "hi vimFuncName guifg=" . l:normal
    exec "hi vimUserFunc guifg=" . l:normal
    exec "hi vimUserAttrbKey guifg=" . l:normal
    exec "hi javaScript guifg=" . l:normal
    exec "hi htmlTagN guifg=" . l:normal
    exec "hi htmlTagName guifg=" . l:normal

    exec "hi Comment guifg=" . l:comment

    exec "hi String guifg=" . l:string
    exec "hi vbComment guifg=" . l:string
    exec "hi Character guifg=" . l:string
    exec "hi cIncluded guifg=" . l:string

    exec "hi Structure guifg=" . l:type . " gui=NONE"
    exec "hi StorageClass guifg=" . l:type . " gui=NONE"
    exec "hi Type guifg=" . l:type
    exec "hi vimNotation guifg=" l:type
    exec "hi typescriptClassname guifg=" . l:type
    exec "hi typescriptTypeParameter guifg=" l:type
    exec "hi typescriptInterfaceName guifg=" . l:type . "gui=NONE"
    exec "hi typescriptClassname guifg=" . l:type . " gui=NONE"
    exec "hi typescriptTypeReference guifg=" . l:type . " gui=NONE"

    exec "hi Number guifg=" . l:constant
    exec "hi Boolean guifg=" . l:constant
    exec "hi SpecialChar guifg=" . l:constant
    exec "hi Float guifg=" . l:constant
    exec "hi Special guifg=" . l:constant
    exec "hi typescriptDecorator guifg=" . l:constant
    exec "hi typescriptTemplateSubstitution guifg=" . l:constant
    exec "hi typescriptTemplateSB guifg=" . l:constant
    exec "hi typescriptRegexpString guifg=" . l:constant

    exec "hi Repeat guifg=" . l:ident . " gui=NONE"
    exec "hi Conditional guifg=" . l:ident . " gui=NONE"
    exec "hi Label guifg=" . l:ident . " gui=NONE"
    exec "hi Statement guifg=" . l:ident . " gui=NONE"
    exec "hi Keyword guifg=" . l:ident . " gui=NONE"
    exec "hi CppModifier guifg=" . l:ident . " gui=NONE"
    exec "hi Exception guifg=" . l:ident . " gui=NONE"

    exec "hi sSymbols guifg=" . l:define
    exec "hi cppNamespace guifg=" . l:define
    exec "hi Define guifg=" . l:define
    exec "hi Include guifg=" . l:define
    exec "hi PreProc guifg=" . l:define
    exec "hi htmlTag guifg=" . l:define
    exec "hi htmlArg guifg=" . l:define
    exec "hi odinAttribute guifg=" . l:define

    hi Todo guifg=#E3B749 gui=underline,bold
    hi NoCheckin guifg=#EE1010 gui=underline,bold

    hi! link odinAttribute Special
    hi! link odinExtNumber odinNumber
    hi! link odinExtHex odinNumber
    hi! link GitGutterAddLineNr DiffAdd
    hi! link GitGutterChangeLineNr DiffChange
    hi! link GitGutterDeleteLineNr DiffDelete
    hi! link GitGutterChangeDeleteLineNr DiffChangeDelete
endfunction

function! SetCustomSyntax()
    match ExtraWhitespace /\s\+$/
    " @For this: Setup notes like the one before in comments <
    syn match Todo /@[A-z0-9\-_\(\)\[\]{} ]*:/ display oneline containedin=.*Comment,vimCommentTitle,cCommentL contained
    syn match cppNamespace /[a-zA-Z0-9_]\+::/
    syn match sSymbols "->\|=>"
    " Not working...
    " syn match odinExtNumber /(0[boi])?[0-9_.]+/ display
    " syn match odinExtHex /0x[0-9_a-fA-F]+/ display
    syn keyword NoCheckin nocheckin containedin=ALL
    syn keyword Statement defer
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64 bool32 byte f32 f64 vec2 vec3 vec4 ivec2 ivec3 ivec4 mat4
    syn keyword odinDataType f32 f64 f32le f64le f32be f64be u8 u16 u32 u64 u128 u8le u16le u32le u64le u128le u8be u16be u32be u64be u128be
    syn region odinAttribute start="@(" end=")" contains=odinString
endfunction

function! DreamshadeWindowEntered()
    setlocal cursorline
    if exists("g:nvui") || exists("g:neovide")
        setlocal winhl=Normal:NormalActive
    endif
endfunction

function! DreamshadeWindowLeft()
    setlocal nocursorline
    if exists("g:nvui") || exists("g:neovide")
        setlocal winhl=NormalActive:Normal
    endif
endfunction

augroup DreamshadeColorScheme
    autocmd!
    autocmd ColorScheme * call OverrideColorSchemes()
    autocmd VimEnter,WinEnter,BufWinEnter * call DreamshadeWindowEntered()
    autocmd WinLeave * call DreamshadeWindowLeft()
    autocmd Syntax * call SetCustomSyntax()
augroup END

colorscheme nord
