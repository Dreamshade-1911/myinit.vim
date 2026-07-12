" Dreamshade theme behaviour layer.

function! SetCustomSyntax()
    if !empty(nvim_win_get_config(0).relative) || &filetype =~# '^blink'
        return
    endif

    match ExtraWhitespace /\s\+$/
    " @For this: Setup notes like the one before in comments <
    syn match Todo /@[A-z0-9\-_\(\)\[\]{} ]*:/ display oneline containedin=.*Comment,vimCommentTitle,cCommentL contained
    syn match cppNamespace /[a-zA-Z0-9_]\+::/
    syn match sSymbols "->\|=>"
    syn keyword NoCheckin nocheckin containedin=ALL
    syn keyword Statement defer
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64 bool32 byte f32 f64 vec2 vec3 vec4 ivec2 ivec3 ivec4 mat4
    syn keyword odinDataType f32 f64 f32le f64le f32be f64be u8 u16 u32 u64 u128 u8le u16le u32le u64le u128le u8be u16be u32be u64be u128be
    syn region odinAttribute start="@(" end=")" contains=odinString
    syn match odinAttribute /@\w\+/
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
    autocmd VimEnter,WinEnter,BufWinEnter * call DreamshadeWindowEntered()
    autocmd WinLeave * call DreamshadeWindowLeft()
    autocmd Syntax * call SetCustomSyntax()
augroup END

colorscheme dreamshade
