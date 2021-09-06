" This just changes a few colors from the Nord theme
function! OverrideColorSchemes()
    hi CursorLine guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
    hi CursorLineNr guibg=#BCC7DA guifg=#101010 gui=bold ctermfg=NONE

    hi Normal guifg=#DBCAA4 guibg=#1B1E24 ctermbg=Black
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

    hi Comment guifg=#4ACE45

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

    hi Todo guifg=#B03729 ctermfg=NONE

    hi Define guifg=#BCC7DA
    hi Include guifg=#BCC7DA
    hi PreProc guifg=#BCC7DA
    hi Function guifg=#BCC7DA
    hi typescriptGlobal guifg=#BCC7DA
endfunction

augroup DreamshadeColorScheme
    autocmd!
    autocmd ColorScheme * call OverrideColorSchemes()
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

