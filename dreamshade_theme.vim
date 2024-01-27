" This just changes a few colors from the Nord theme
function! OverrideColorSchemes()
    hi Normal guifg=#DBCAA4 guibg=NONE ctermbg=NONE
    hi CursorLine guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
    hi CursorLineNr guibg=#BCC7DA guifg=#101010 gui=bold ctermfg=NONE

    hi link ExtraWhitespace Error

    if exists("g:nvui") || exists("g:neovide")
        hi NormalInactive guibg=#07080A
        hi Normal guibg=#090F11
        hi CursorLine guibg=#252930 guifg=NONE ctermbg=NONE ctermfg=NONE
    endif

    hi NonText guibg=NONE ctermbg=NONE

    hi Identifier guifg=#DBCAA4 gui=NONE
    hi Function guifg=#DBCAA4
    hi Delimiter guifg=#DBCAA4
    hi Operator guifg=#DBCAA4
    hi vimMapRhs guifg=#DBCAA4
    hi vimFuncName guifg=#DBCAA4
    hi vimUserFunc guifg=#DBCAA4
    hi vimUserAttrbKey guifg=#DBCAA4
    hi javaScript guifg=#DBCAA4
    hi htmlTagN guifg=#DBCAA4
    hi htmlTagName guifg=#DBCAA4

    hi Comment guifg=#67B32E

    hi String guifg=#2EB8A6
    hi vbComment guifg=#2EB8A6
    hi Character guifg=#2EB8A6
    hi cIncluded guifg=#2EB8A6

    hi Structure guifg=#55C08E gui=NONE
    hi StorageClass guifg=#55C08E gui=NONE
    hi Type guifg=#55C08E
    hi vimNotation guifg=#55C08E
    hi typescriptClassname guifg=#55C08E
    hi typescriptTypeParameter guifg=#55C08E
    hi typescriptInterfaceName guifg=#55C08E gui=NONE
    hi typescriptClassname guifg=#55C08E gui=NONE
    hi typescriptTypeReference guifg=#55C08E gui=NONE

    hi Number guifg=#82DDD9
    hi Boolean guifg=#82DDD9
    hi SpecialChar guifg=#82DDD9
    hi Float guifg=#82DDD9
    hi Special guifg=#82DDD9
    hi typescriptDecorator guifg=#82DDD9
    hi typescriptTemplateSubstitution guifg=#82DDD9
    hi typescriptTemplateSB guifg=#82DDD9
    hi typescriptRegexpString guifg=#82DDD9

    hi Operator guifg=#8CD4AC

    hi Repeat guifg=#FFFFFF gui=NONE
    hi Conditional guifg=#FFFFFF gui=NONE
    hi Label guifg=#FFFFFF gui=NONE
    hi Statement guifg=#FFFFFF gui=NONE
    hi Keyword guifg=#FFFFFF gui=NONE
    hi CppModifier guifg=#FFFFFF gui=NONE
    hi Exception guifg=#FFFFFF gui=NONE

    hi sSymbols guifg=#BCC7DA
    hi cppNamespace guifg=#BCC7DA
    hi Define guifg=#BCC7DA
    hi Include guifg=#BCC7DA
    hi PreProc guifg=#BCC7DA
    hi htmlTag guifg=#BCC7DA
    hi htmlArg guifg=#BCC7DA

    hi Todo guifg=#E3B749 gui=underline,bold
    hi NoCheckin guifg=#EE1010 gui=underline,bold
endfunction

function! SetCustomSyntax()
    match ExtraWhitespace /\s\+$/
    " @For this: Setup notes like the one before in comments <
    syn match Todo /@\zs\%([A-z0-9\-_\(\)\[\]{}]*\)\ze:/ containedin=.*Comment.*
    syn match NoCheckin /nocheckin/ containedin=ALL
    syn match cppNamespace /[a-zA-Z0-9_]\+::/
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64 bool32 byte f32 f64 vec2 vec3 vec4 ivec2 ivec3 ivec4 mat4
    syn keyword Statement defer
    syn match sSymbols "\.\|->\|=>"
endfunction

function! DreamshadeWindowEntered()
    setlocal cursorline
    if exists("g:nvui") || exists("g:neovide")
        setlocal winhl=NormalInactive:Normal
    endif
endfunction

function! DreamshadeWindowLeft()
    setlocal nocursorline
    if exists("g:nvui") || exists("g:neovide")
        setlocal winhl=Normal:NormalInactive
    endif
endfunction

augroup DreamshadeColorScheme
    autocmd!
    autocmd ColorScheme * call OverrideColorSchemes()
    autocmd VimEnter,WinEnter,BufWinEnter * call DreamshadeWindowEntered()
    autocmd WinLeave * call DreamshadeWindowLeft()
    autocmd Syntax * call SetCustomSyntax()
augroup END

