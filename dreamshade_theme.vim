" This just changes a few colors from the Nord theme
function! OverrideColorSchemes()
    hi CursorLine guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
    hi CursorLineNr guibg=#BCC7DA guifg=#101010 gui=bold ctermfg=NONE

    hi Normal guifg=#DBCAA4 guibg=NONE ctermbg=NONE
    hi Delimiter guifg=#DBCAA4
    hi Operator guifg=#DBCAA4
    hi vimMapRhs guifg=#DBCAA4
    hi vimFuncName guifg=#DBCAA4
    hi vimUserFunc guifg=#DBCAA4
    hi vimUserAttrbKey guifg=#DBCAA4
    hi javaScript guifg=#DBCAA4
    hi typescriptAssign guifg=#DBCAA4
    hi typescriptTypeBrackets guifg=#DBCAA4
    hi typescriptTypeAnnotation guifg=#DBCAA4
    hi typescriptOptionalMark guifg=#DBCAA4
    hi typescriptArrowFunc guifg=#DBCAA4
    hi typescriptMember guifg=#DBCAA4
    hi typescriptBinaryOp guifg=#DBCAA4
    hi typescriptInterfaceName guifg=#DBCAA4
    hi NonText guibg=NONE ctermbg=NONE
    hi typescriptGlobal guifg=#DBCAA4
    hi typescriptES6SetMethod guifg=#DBCAA4
    hi typescriptBOMNavigatorProp guifg=#DBCAA4
    hi typescriptJSONStaticMethod guifg=#DBCAA4
    hi htmlTagN guifg=#DBCAA4
    hi htmlTagName guifg=#DBCAA4

    hi Comment guifg=#67B32E

    hi String guifg=#2EB8A6
    hi vbComment guifg=#2EB8A6
    hi Character guifg=#2EB8A6
    hi cIncluded guifg=#2EB8A6

    hi Type guifg=#55C08E
    hi vimNotation guifg=#55C08E
    hi typescriptClassname guifg=#55C08E
    hi typescriptTypeParameter guifg=#55C08E
    hi typescriptInterfaceName guifg=#55C08E gui=NONE

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

    hi Structure guifg=#FFFFFF gui=NONE
    hi StorageClass guifg=#FFFFFF gui=NONE
    hi Repeat guifg=#FFFFFF gui=NONE
    hi Conditional guifg=#FFFFFF gui=NONE
    hi Label guifg=#FFFFFF gui=NONE
    hi Statement guifg=#FFFFFF gui=NONE
    hi Keyword guifg=#FFFFFF gui=NONE
    hi Identifier guifg=#FFFFFF gui=NONE
    hi CppModifier guifg=#FFFFFF gui=NONE
    hi Exception guifg=#FFFFFF gui=NONE

    hi sSymbols guifg=#BCC7DA
    hi cppNamespace guifg=#BCC7DA
    hi Define guifg=#BCC7DA
    hi Include guifg=#BCC7DA
    hi PreProc guifg=#BCC7DA
    hi Function guifg=#BCC7DA
    hi htmlTag guifg=#BCC7DA
    hi htmlArg guifg=#BCC7DA

    hi Todo guifg=#E3B749 gui=underline,bold
    hi def link myTodos Todo
    hi NoCheckin guifg=#FF0000 gui=underline,bold

    call SetCustomSyntax()
endfunction

function! SetCustomSyntax()
    " @ForThis: Setup notes like the one before <
    syn match myTodos /@\zs\%([A-Z].*\)\ze:/ containedin=.*Comment.*
    syn match NoCheckin /nocheckin\c/ containedin=.*Comment.*
    syn match NoCheckin /nocheckin\c/
    syn match cppNamespace /[a-zA-Z0-9_]\+::/
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64 bool32 Vec2 Vec3 Vec4 Vec2f Vec3f Vec4f Mat2 Mat3 Mat4 Mat2f Mat3f Mat4f
    syn keyword cStatement For defer Loop
    syn match sSymbols "\.\|->\|=>"
endfunction

augroup DreamshadeColorScheme
    autocmd!
    autocmd ColorScheme * call OverrideColorSchemes()
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    autocmd Syntax * call SetCustomSyntax()
augroup END

