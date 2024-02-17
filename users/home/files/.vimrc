" vim: foldmethod=marker

" Plugins bundle {{{1
set nocompatible
filetype off                  " required!

if has("autocmd")
    autocmd BufRead,BufNewFile *.sbt setfiletype scala
end

source ~/.vim/bundles.vim

" Preferences {{{1
" ctags
set tags=./tags,tags;/

" Works undo after buffer changes
set hidden

set encoding=utf-8

" line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

highlight Normal cterm=NONE ctermbg=NONE

set guifont=Liberation\ Mono\ for\ Powerline\ 11
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0

set signcolumn=yes
set number
set relativenumber

set mouse=a

set clipboard=unnamedplus

" eclim
set nocompatible
filetype plugin indent on
" let g:EclimLogLevel = 10

" eclim color
"hi Pmenu ctermbg=darkgray ctermfg=gray guibg=darkgray guifg=#bebebe
"hi PmenuSel ctermbg=gray ctermfg=black guibg=#bebebe guifg=black
"hi PmenuSbar ctermbg=gray guibg=#bebebe
"hi PmenuThumb cterm=reverse gui=reverse

" colorcolumn / print margin
set colorcolumn=80

" http://robots.thoughtbot.com/faster-grepping-in-vim/
" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

let g:ctrlp_open_multiple_files = 'i'

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
"set scrolloff=4

let g:tagbar_type_javascript = {
            \ 'ctagstype' : 'javascript',
            \ 'kinds'     : [
            \ 'f:function',
            \ 'v:variable',
            \ 's:string',
            \ 'o:object',
            \ 'd:directive',
            \ 'c:controller',
            \ 'F:factory',
            \ 'i:filter',
            \ 'm:modul'
            \ ],
            \ 'sort' : 1
            \ }

"    \ 'sro'        : '.',
"    \ 'kind2scope' : {
"      \ 'm': 'module',
"      \ 'd': 'directive',
"      \ 'c': 'controller'
"    \ },
"    \ 'scope2kind' : {
"      \ 'module'     : 'm',
"      \ 'directive'  : 'd',
"      \ 'controller' : 'c'
"    \ },

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¶,trail:~,nbsp:⎵,extends:»,precedes:«

" source $VIMRUNTIME/mswin.vim

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set laststatus=2
" let g:Powerline_symbols = 'fancy'

let g:Gitv_WipeAllOnClose = 1
let g:Gitv_WrapLines = 0
let g:Gitv_TruncateCommitSubjects = 1

set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" this enables "visual" wrapping
set wrap

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0
set wrapmargin=0

" Solarized
set t_Co=256
syntax enable
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
colorscheme solarized
" colorscheme torte
" colorscheme desert
set background=dark

" leader key
let mapleader = ','

" searching
set ignorecase smartcase incsearch hlsearch

" don't display welcome
"set shortmess+=I

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

"Always show current position
set ruler

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=8

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Allow backspacing like a normal editor in insert mode.
set backspace=indent,eol,start

" pastetoggle http://stackoverflow.com/questions/2861627/paste-in-insert-mode
" set paste
set pastetoggle=<F2>

" Wildmenu completion: use for file exclusions"
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"
set wildignore+=*.class "java/scala class files"
set wildignore+=*/target/* "sbt target directory"

set diffopt+=vertical

" Command-T Cache
let g:CommandTMaxCachedDirectories=0

" Rainbow parantheses
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0

"set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%C\ %#[error]\ %m,%C\ %m
"set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%C\ %#[warn]\ %m,%C\ %m
"set errorformat+=,%-G%.%#

let g:vimwiki_list = [{
                     \ 'syntax': 'markdown',
                     \ 'ext': '.md',
                     \ 'custom_wiki2html': 'wiki2html.sh'}]

" Autocommands {{{1
if has("autocmd")
    augroup vimrc_autocmd
      autocmd!
        " http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
        "  autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

        " highlight unwanted(trailing) whitespace
        " + have this highlighting not appear whilst you are typing in insert mode
        " + have the highlighting of whitespace apply when you open new buffers
        " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
        highlight ExtraWhitespace ctermbg=red guibg=red
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        autocmd BufWinLeave * call clearmatches()

        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
        autocmd FileType vimwiki call SetMarkdownOptions()

        " http://stackoverflow.com/questions/16743112/open-item-from-quickfix-window-in-vertical-split
        autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

        autocmd BufReadPost fugitive://* set bufhidden=delete

        autocmd User fugitive
                    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                    \   nnoremap <buffer> .. :edit %:h<CR> |
                    \ endif

        " Format scala code
        let g:scala_sort_across_groups=1
        " au BufEnter *.scala setl formatprg=java\ -jar\ /Users/stefanb/Exec/scalariform.jar\ -f\ -q\ +alignParameters\ +alignSingleLineCaseStatements\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis\ +rewriteArrowSymbols\ +preserveSpaceBeforeArguments\ --stdin\ --stdout
        autocmd BufRead,BufNewFile *.sc set filetype=scala
        autocmd! FileType scala nmap <leader>m :SortScalaImports<CR>
        " gggqG<C-o><C-o><leader><w>

        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        autocmd BufWriteCmd *.html,*.css,*.gtpl,*.rst :call Refresh_firefox()
        autocmd BufWriteCmd *.md :call Convert_Markdown()
        autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
        autocmd BufNewFile,BufRead *.scala setlocal ts=2 sw=2 sts=2
        autocmd FileType json syntax match Comment +\/\/.\+$+
        autocmd BufRead,BufNewFile *.gitconfig* set filetype=gitconfig
        autocmd BufRead,BufNewFile *.hbs set filetype=html
    augroup END
endif

" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

" Functions {{{1
function! SetMarkdownOptions()
    call VimwikiSet('syntax', 'markdown')
    call VimwikiSet('custom_wiki2html', 'wiki2html.sh')
    call VimwikiSet('path_html', '~/vimwiki_html/')
endfunction

function! Convert_Markdown()
    if &modified
        write
        silent !pandoc -s -f markdown -t html -o /tmp/%:t.html %:p
        call Refresh_firefox_x()
    endif
endfunction

function! Refresh_firefox_x()
    silent !echo  'var vimYo = content.window.pageYOffset;
                \ var vimXo = content.window.pageXOffset;
                \ BrowserReload();
                \ content.window.scrollTo(vimXo,vimYo);
                \ repl.quit();'  |
                \ nc -w 1 localhost 4242 2>&1 > /dev/null
endfunction

function! Refresh_firefox()
    if &modified
        write
        call Refresh_firefox_x()
    endif
endfunction

function! RefactorToVariable()
    let @x = input('Enter variable name: ')
    execute ':normal i' . @x
    call append(line('.')-1, @x . ' = ' . @y)
    execute ':normal kV=^i'
endfunction

" Commands {{{1
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

command! -nargs=0 Worktime %! /usr/bin/awk -f ~/Desktop/ws_iszer/admin/worktime/gedit_tool/worktime

command! -nargs=1 Repl silent !echo
            \ "repl.home();
            \ content.location.href = '<args>';
            \ repl.enter(content);
            \ repl.quit();" |
            \ nc localhost 4242

command! -n=0 -bar LoadPlugins call plug#load('ultisnips', 'YouCompleteMe')
    \| call youcompleteme#Enable() | :echo 'Plugins loaded'

" Mappings {{{1
nmap <leader>mh :Repl http://
" mnemonic is MozRepl Http
nmap <silent> <leader>ml :Repl file:///%:p
" mnemonic is MozRepl Local
nmap <silent> <leader>mm :Repl http://localhost/
" mnemonic is MozRepl Development

" Tagbar (http://blog.stwrt.ca/2012/10/31/vim-ctags)
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
nnoremap <silent> <Leader>te :!gnome-terminal &<CR><CR>

nnoremap <silent> <leader>tt :! ctags -R -f ./tags .<CR><CR>

" NerdTree
map <leader>n :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>

" Buffers - explore/next/previous: leader-u, Alt-F12, leader-p.
nnoremap <silent> <leader>u :BufExplorer<CR>
nnoremap <silent> <M-F12> :bn!<CR>
nnoremap <silent> <leader>p :bp<CR>

" Replace word under cursor globally
nnoremap <Leader>rg :%s/\<<C-r><C-w>\>//gc<left><left><left>

" Replace word under cursor in line
nnoremap <Leader>rl :s/\<<C-r><C-w>\>//gc<left><left><left>

" remove whitespace http://vim.wikia.com/wiki/Remove_unwanted_spaces
" called by leader-m
nnoremap <silent> <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" search and replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

map <C-s> :w<CR>
imap <C-s> <ESC>:w<CR><Insert>

" Remap Tag jump
map <C-g> <C-]>

" Ctl-X close the current buffer
nmap <C-q> <Plug>Kwbd

" Remap VIM 0 to first non-blank character
" map 0 ^

" Treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>

" ZoomWin
"nmap <leader>o <c-w>o

" Selection with shift+ arrows
" imap <S-left> <ESC>v<left>
" imap <S-right> <ESC>v<right>
" imap <S-up> <ESC>v<up>
" imap <S-down> <ESC>v<down>
"
" nmap <S-left> v<left>
" nmap <S-right> v<right>
" nmap <S-up> v<up>
" nmap <S-down> v<down>
"
" vmap <S-left> <left>
" vmap <S-right> <right>
" vmap <S-up> <up>
" vmap <S-down> <down>

" imap <S-left> <ESC>vh
" imap <S-right> <ESC>vl
" imap <S-up> <ESC>vk
" imap <S-down> <ESC>vj
"
" nmap H vh
" nmap L vl
" nmap K vk
" nmap J vj
"
" vmap H h
" vmap L l
" vmap K k
" vmap J j

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

vmap <S-Tab> <gv
vmap <Tab> >gv

" " no <down>   ddp
" no <down>   <Nop>
" no <left>   <Nop>
" no <right>  <Nop>
" " no <up>	    ddkP
" no <up>	    <Nop>
" ino <down>  <Nop>
" ino <left>  <Nop>
" ino <right> <Nop>
" ino <up>    <Nop>
" vno <down>  <Nop>
" vno <left>  <Nop>
" vno <right> <Nop>
" vno <up>    <Nop>

nmap é :
nmap <leader>md :%!pandoc<CR>
vmap <leader>md :!pandoc<CR>

nmap <silent> <leader>rst :%!rst2html -q --stylesheet-path ~/.vim/bundle/riv.vim/autoload/riv/html/html4css1.css<CR><CR>
vmap <silent> <leader>rst :!rst2html -q --link-stylesheet<CR>11dd/<\/html<CR>kk3dd

nmap <leader>ev :ed ~/.vimrc<CR>
nmap <leader>eb :ed ~/.vim/bundles.vim<CR>

" For tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

map ő [
map ú ]

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
xmap <C-Up> [egv
xmap <C-Down> ]egv

" Toggle highlighting
nnoremap <F3> :noh<CR>

" Copy the current word or visually selected text to the clipboard:
nnoremap <F4> "zyiw
xnoremap <F4> "zy

" Replace the current word or visually selected text with the clipboard contents:
nnoremap <F5> viw"zp
xnoremap <F5> "zp

" Toggle relativenumber
nnoremap <F6> :set rnu!<CR>

inoremap yy <ESC>
inoremap űű <ESC>/

" Copy the current word or visually selected text to the clipboard:
xnoremap <S-F6> "yx:call RefactorToVariable()<CR>

nnoremap <Plug>IncrementArrayIndex 0f[l<C-a>j
\:call repeat#set("\<Plug>IncrementArrayIndex")<CR>
nmap <leader>i <Plug>IncrementArrayIndex

map <C-_> <Plug>NERDCommenterToggle
nnoremap Y Y
"}}}
" Configuration for coc.nvim {{{1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Use <C-space> for trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}
