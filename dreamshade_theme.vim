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
    hi typescriptAssign guifg=#DBCAA4
    hi typescriptTypeBrackets guifg=#DBCAA4
    hi typescriptTypeAnnotation guifg=#DBCAA4
    hi typescriptOptionalMark guifg=#DBCAA4
    hi typescriptArrowFunc guifg=#DBCAA4
    hi typescriptMember guifg=#DBCAA4
    hi typescriptBinaryOp guifg=#DBCAA4
    hi typescriptInterfaceName guifg=#DBCAA4
    hi NonText guibg=NONE ctermbg=NONE

    hi Comment guifg=#67B32E

    hi String guifg=#2EB8A6
    hi Character guifg=#2EB8A6
    hi cIncluded guifg=#2EB8A6

    hi Type guifg=#55C08E
    hi vimNotation guifg=#55C08E
    hi typescriptClassname guifg=#55C08E
    hi typescriptTypeParameter guifg=#55C08E

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

    hi Structure guifg=#FFFFFF
    hi StorageClass guifg=#FFFFFF
    hi Repeat guifg=#FFFFFF
    hi Conditional guifg=#FFFFFF
    hi Label guifg=#FFFFFF
    hi Statement guifg=#FFFFFF
    hi Keyword guifg=#FFFFFF
    hi Identifier guifg=#FFFFFF
    hi CppModifier guifg=#FFFFFF
    hi Exception guifg=#FFFFFF

    hi Define guifg=#BCC7DA
    hi Include guifg=#BCC7DA
    hi PreProc guifg=#BCC7DA
    hi Function guifg=#BCC7DA
    hi typescriptGlobal guifg=#BCC7DA

    call SetCustomSyntax()
endfunction

function! SetCustomSyntax()
    " @ForThis: Setup notes like the one before <
    hi Todo guifg=#E3B749 gui=underline
    syn match myTodos /@\zs\%([A-Z].*\)\ze:/ containedin=.*Comment.*
    hi def link myTodos Todo
endfunction

augroup DreamshadeColorScheme
    autocmd!
    autocmd ColorScheme * call OverrideColorSchemes()
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    autocmd Syntax * call SetCustomSyntax()
augroup END

