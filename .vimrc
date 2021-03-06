" Tabs:
set tabstop=4
set shiftwidth=4
set expandtab 
set softtabstop=4

" Indenting:
set autoindent
filetype plugin indent on
set pastetoggle=<F12>

" Colors:
set t_Co=256
colorscheme Tomorrow-Night

" Left padding:
set foldcolumn=2
au ColorScheme * highlight FoldColumn ctermbg=NONE guibg=NONE
au ColorScheme * highlight StatusLineNC ctermbg=bg guibg=bg
au ColorScheme * highlight StatusLineNC ctermfg=bg guifg=bg
sign define dummy 
function! ShowSignColumn()
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
endfunction
au BufEnter * nested call ShowSignColumn()

" Top padding:
function! TopPadding()
    silent! leftabove 1 split __TopPadding__
    silent! setlocal buftype=nofile
    silent! setlocal nobuflisted
    silent! setlocal noswapfile
    setlocal noma
    setlocal nocursorline
    setlocal nonumber
    silent! setlocal norelativenumber
    execute 'sign unplace 9999 buffer=' . bufnr("__TopPadding__")
    wincmd j
    au BufEnter __TopPadding__ nested call TopPaddingClose()
endfunction
function! TopPaddingClose()
    if winnr() == winbufnr(bufnr("__TopPadding__"))
        bdelete
    endif
endfunction
command TopPadding call TopPadding()
au VimEnter * nested call TopPadding()

" Convenient options:
syntax on
set wildmenu
set mouse=a

" Custom filetypes:
filetype on
au BufNewFile,BufRead *.cshtml  set filetype=html
au BufNewFile,BufRead *.ejs     set filetype=ejs
au BufNewFile,BufRead *.ino     set filetype=c
au BufNewFile,BufRead *.jsm     set filetype=javascript
au BufNewFile,BufRead *.json    set filetype=javascript
au BufNewFile,BufRead *.less    set filetype=less
au BufNewFile,BufRead *.webapp  set filetype=javascript

" Key maps:
map     <F6>    :bp!<CR>
imap    <F6>    <esc>:bp!<CR> 
map     <F7>    :bn!<CR>
imap    <F7>    <esc>:bn!<CR>

map     <C-Up>      :bp!<CR>
imap    <C-Up>      <esc>:bp!<CR>
map     <C-Down>    :bn!<CR>
imap    <C-Down>    :bn!<CR>

map     <A-Right>   :sh<CR>
map     <A-Left>    :qall<CR>
map     <A-Up>      :GitGutterPrevHunk<CR>
imap    <A-Up>      <esc>:GitGutterPrevHunk<CR>
map     <A-Down>    :GitGutterNextHunk<CR>
imap    <A-Down>    <esc>:GitGutterNextHunk<CR>

com! Kwbd enew|bw # 
com! WM w|make -j 4 -i
command -nargs=+ WMB w|!make <q-args> % > /dev/null &
com! WJ w|jake
" write, commit with message
command -nargs=+ Wcm w|!git commit -m <q-args> %

" Functions:

" fill rest of line with characters
function! Line80()
    let tw =    80
    let str =   '-'
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(str, reps))/
    endif
endfunction
command Line80 call Line80()

" Backups go to:
set   backupdir=./.backup,.,/tmp
set   directory=.,./.backup,/tmp

" TagList plugin options:
let tlist_php_settings = 'php;c:class;d:constant;f:function'
let tlist_javascript_settings = 'javascript;f:function'
let Tlist_Auto_Open = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_Show_Menu = 1
let Tlist_Highlight_Tag_On_BufEnter = 0
let Tlist_Auto_Highlight_Tag = 0


" Abbreviations:
iab <expr> date» strftime("%FT%T%z")
iab <expr> time» strftime("%T")
iab <expr> now» strftime("%FT%T%z")
