colorscheme molokai
set number                      "行数表示
set nocompatible                "viと互換を取らない
set backspace=indent,eol,start  "バックスペースで削除できる物を指定する
set backupdir=$HOME/ "vimbackup
set directory=$HOME/ "vimbackup
set title                       "タイトルを表示する
set wrap                        "折り返し
set autoread                    "他でファイルに変更があったら自動読み込み
set wildmenu                    "コマンドライン補完
set wildmode=list:longest
set completeopt=menu,preview,menuone
set showmatch matchtime=1       "カッコ対応
syntax on                       "シンタックスハイライト
set cursorline                  "カーソル行を強調表示

"検索設定
set ignorecase      "大文字と小文字を区別しない
set smartcase       "大文字と小文字が含まれていたらそのまま
set wrapscan        "最後までいったら最初に戻る
set incsearch       "インクリメンタルサーチ
set hlsearch        "一致文字強調
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return> "エスケープ二回で強調消去
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

"タブ（インデント）周り
set softtabstop=2
set tabstop=2       "タブの空白数
set shiftwidth=2    "シフト移動幅
set expandtab       "タブを挿入するときに空白文字を使わない
set autoindent
set smartindent
set cindent
"改行時に自動でコメント文が挿入されるのを無効にする
autocmd FileType * setlocal formatoptions-=ro

"文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

if has('mac')
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
endif

"ステータスラインについての設定
set laststatus =2
set statusline =\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline +=\ \ \ [%{&ff}/%Y/%{&enc}] 
set statusline +=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

set showcmd         "入力中のコマンドをステータスに表示
set cmdheight=2     "コマンドラインを表示

"ステータスラインの色
highlight StatusLine    term=None cterm=None ctermfg=black ctermbg=white

function! CurDir()
let curdir = substitute(getcwd(), $HOME, "~", "")
return curdir
endfunction

function! HasPaste()
if &paste
return '[PASTE]'
else
return ''
endif
endfunction

"}

augroup vimrc-auto-mkdir  " {{{
autocmd!
autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
function! s:auto_mkdir(dir, force)  " {{{
if !isdirectory(a:dir) && (a:force ||
        \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
endif
endfunction  " }}}
augroup END  " }}}

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
