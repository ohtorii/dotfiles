"-----------------------------------------------
" setting
"-----------------------------------------------
"ファイル読み込み時の文字コード
set encoding=utf-8
"Vim script内でマルチバイト文字を使う場合の設定
scriptencoding utf-8

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
"set ambiwidth=double " □や○文字が崩れる問題を解決

" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" logging
if has('win32')||has('win64')
	"set verbosefile=$TEMP/vim.log
	"set verbose=20
endif

"------------------------------------------------
"ウインドウ
"------------------------------------------------
" タイトルをウィンドウ枠に表示
set title

"------------------------------------------------
"ステータスライン
"------------------------------------------------
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

"---------
"コマンド補完
"---------
set wildmenu		" コマンドモードの補完
set history=1000	" 保存するコマンド履歴の数



"------------------------------------------------
" 見た目（ウインドウの中身に関する設定）
"------------------------------------------------
" 行番号を表示
set number
"シンタックスハイライト
syntax on
" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 右下に表示される行・列の番号を表示する
set ruler
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" ビープ音を可視化
"set visualbell
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells

" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
" 全角括弧関連
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”
" 括弧入力時の対応する括弧を表示
"set showmatch

source $VIMRUNTIME/macros/matchit.vim " ノーマルモード時に「%」で対応するカッコにジャンプする。

" コマンドラインの補完
set wildmode=list:longest

"---------
"背景
"---------
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray

"-------------------------------------------------
" Tab文字系
"-------------------------------------------------
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:—→,trail:-,eol:↲
"set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅


"------------------------------------------------
" 検索系
"------------------------------------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"-----------------------------------------------
"カーソル移動
"-----------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"-----------------------------------------------
"ペースト設定
"-----------------------------------------------
set clipboard+=unnamed

"クリップボードから普通にペーストすると自動インデントが効いて下に行くほど右にずれていきますが、
"以下の設定をすることで、クリップボードからペーストする時だけインデントしないようにしてくれます。
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"-----------------------------------------------
"ショートカットキー
"-----------------------------------------------

"メタキーを使うための設定
"http://blog.remora.cx/2012/07/using-alt-as-meta-in-vim.html
"
"let c = 'a'
"while c <= 'z'
"    execute "set <M-" . c . ">=\e" . c
"    execute "imap \e" . c . " <M-" . c . ">"
"    execute "set <M-S-" . c . ">=\e" . toupper(c)
"    execute "imap \e" . toupper(c) . " <M-" . c . ">"
"    let c = nr2char(1+char2nr(c))
"endw

function! DefineKey_M(c)
	execute "set <M-" . a:c . ">=\e" . a:c
	execute "imap \e" . a:c . " <M-" . a:c . ">"
endfunction

"Windowsのキーマッピング
"source $VIMRUNTIME/mswin.vim

"ESC押しづらいため
"inoremap <C-c> <Esc>

"ウインドウ上下分割
call DefineKey_M('h')
noremap <M-h> :<C-u>sp<CR>
inoremap <M-h> <ESC>:<C-u>sp<CR>

"ウインドウ左右分割
call DefineKey_M('v')
noremap <M-v> :<C-u>vs<CR>
noremap <M-v> <ESC>:<C-u>vs<CR>

"ウインドウとタブのクローズ
call DefineKey_M('q')
noremap <M-q> :<C-u>q<CR>
noremap <M-q> <ESC>:<C-u>q<CR>

"分割したウインドウ内を上下左右移動
nnoremap <M-right> <C-w>l
nnoremap <M-down>  <C-w>j
nnoremap <M-up>    <C-w>k
nnoremap <M-left>  <C-w>h
inoremap <M-right> <ESC><C-w>l
inoremap <M-down>  <ESC><C-w>j
inoremap <M-up>    <ESC><C-w>k
inoremap <M-left>  <ESC><C-w>h

"タブ左右移動
call DefineKey_M('_')
nnoremap <M-_> gt
call DefineKey_M('/')
nnoremap <M-/> gT
inoremap <M-_> <ESC>gt
inoremap <M-/> <ESC>gT

"新規タブ
nnoremap <C-n> :<C-u>tabnew<CR>


" quote and bracket {{{
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap "" ""<Left>
"inoremap """ """<CR>"""<Up>
"inoremap ”” ””<Left>
"inoremap '' ''<Left>
"inoremap ’’ ’’<Left>
"inoremap <> <><Left>
"inoremap $$ $$<Left>
"}}}


" for Japanese IME mode"{{{
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap え e
nnoremap お o
nnoremap っd dd
nnoremap っy yy
nnoremap し” ci"
nnoremap し’ ci'
nnoremap せ ce
nnoremap で de
inoremap <silent> っj <ESC>

nnoremap っz zz
nnoremap ・ /
"}}}




"
"memo: vim-submodeプラグインを利用しています、そちらの設定も参照してください。
"


"deleteキーが効かない問題の回避
"https://qiita.com/omega999/items/23aec6a7f6d6735d033f
set backspace=indent,eol,start

"-----------------------------------------------
"補完のヒント表示
"(See) http://koturn.hatenablog.com/entry/2018/02/10/170000
"-----------------------------------------------
" 入力キーの辞書
let s:compl_key_dict = {
      \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
      \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
      \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
      \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
      \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
      \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
      \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
      \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
      \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
      \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
      \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
      \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
      \ char2nr('s'): "\<C-x>s",
      \ char2nr("\<C-s>"): "\<C-x>s"
      \}
" 表示メッセージ
let s:hint_i_ctrl_x_msg = join([
      \ '<C-l>: While lines',
      \ '<C-n>: keywords in the current file',
      \ "<C-k>: keywords in 'dictionary'",
      \ "<C-t>: keywords in 'thesaurus'",
      \ '<C-i>: keywords in the current and included files',
      \ '<C-]>: tags',
      \ '<C-f>: file names',
      \ '<C-d>: definitions or macros',
      \ '<C-v>: Vim command-line',
      \ "<C-u>: User defined completion ('completefunc')",
      \ "<C-o>: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! s:hint_i_ctrl_x() abort
  echo s:hint_i_ctrl_x_msg
  let c = getchar()
  return get(s:compl_key_dict, c, nr2char(c))
endfunction

inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()


"-----------------------------------------------
"NeoBundle（Vimプラグインの管理）
"-----------------------------------------------

if has('win32')||has('win64')
	if has('vim_starting')
	    " 初回起動時のみruntimepathにNeoBundleのパスを指定する(絶対パス)
	    set runtimepath+=$VIM/~/.vim/bundle/neobundle.vim/

	    " NeoBundleが未インストールであればgit cloneする
	    if !isdirectory(expand("$VIM/~/.vim/bundle/neobundle.vim/"))
	        echo "install NeoBundle..."
	        :call system("git clone git://github.com/Shougo/neobundle.vim $VIM/~/.vim/bundle/neobundle.vim")
	    endif
	endif
else
	if has('vim_starting')
	    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
	    set runtimepath+=~/.vim/bundle/neobundle.vim/

	    " NeoBundleが未インストールであればgit cloneする
	    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
	        echo "install NeoBundle..."
	        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
	    endif
	endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する

" カラースキームmolokai
NeoBundle 'tomasr/molokai'

" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
"ステータスラインの表示内容強化
"NeoBundle 'vim-airline/vim-airline'
"NeoBundle 'vim-airline/vim-airline-themes'

" 末尾の全角と半角の空白文字を赤くハイライト(FixWhitespace コマンド)
NeoBundle 'bronson/vim-trailing-whitespace'

" インデントの可視化
NeoBundle 'Yggdroot/indentLine'

" 対応する括弧を虹色で表示する
NeoBundle 'luochen1990/rainbow'

"ユーザー定義のモードを追加する
"NeoBundle 'kana/vim-submode'

" 多機能セレクタ
NeoBundle 'ctrlpvim/ctrlp.vim'

" CtrlPの拡張プラグイン. 関数検索
NeoBundle 'tacahiroy/ctrlp-funky'
" CtrlPの拡張プラグイン. コマンド履歴検索
NeoBundle 'suy/vim-ctrlp-commandline'
" CtrlPの検索にagを使う
NeoBundle 'rking/ag.vim'
" psearch
NeoBundle 'idanarye/psearch.vim'

"置換を可視化する
NeoBundle 'osyo-manga/vim-over'
"現在の検索位置を画面に表示する(ハイライトしたままになるので未使用)
"NeoBundle 'osyo-manga/vim-anzu'
"カーソル位置の単語をハイライトする
NeoBundle 'osyo-manga/vim-brightest'

"サイドバーにファイル一覧を表示
"NeoBundle 'scrooloose/nerdtree'

"選択範囲を広げる
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-entire'

"テキストを囲う
NeoBundle 'tpope/vim-surround'
"Pythonの補完
NeoBundle 'davidhalter/jedi-vim'
"pythonのインデントをpep8スタイルに合わせる
NeoBundle 'Vimjas/vim-python-pep8-indent'

"C#の補完(そもそも動作しないためコメントアウト)
"NeoBundle 'OmniSharp/omnisharp-vim'

"構文検査
NeoBundle 'scrooloose/syntastic'

"コメントアウト
NeoBundle 'tyru/caw.vim'
"Undo
"neobundle "sjl/gundo.vim"

"Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neocomplete.vim'

"----------------------------------------------------------
call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck



"----------------------------------------------------------
"[設定] molokai
"----------------------------------------------------------
if neobundle#is_installed('molokai') " molokaiがインストールされていれば
    colorscheme molokai " カラースキームにmolokaiを設定する
endif
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

"----------------------------------------------------------
" [設定]lightline.vim
"----------------------------------------------------------
if neobundle#is_installed('lightline.vim')
	set laststatus=2 " ステータスラインを常に表示
	set showmode " 現在のモードを表示
	set showcmd " 打ったコマンドをステータスラインの下に表示
	set ruler " ステータスラインの右側にカーソルの現在位置を表示する
	let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left' : [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
		\ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

	function! LightlineModified()
	  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction

	function! LightlineReadonly()
	  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
	endfunction

	function! LightlineFilename()
	  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
			\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
			\  &ft == 'unite' ? unite#get_status_string() :
			\  &ft == 'vimshell' ? vimshell#get_status_string() :
			\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
			\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
	endfunction

	function! LightlineFugitive()
	  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		return fugitive#head()
	  else
		return ''
	  endif
	endfunction

	function! LightlineFileformat()
	  return winwidth(0) > 70 ? &fileformat : ''
	endfunction

	function! LightlineFiletype()
	  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
	endfunction

	function! LightlineFileencoding()
	  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
	endfunction

	function! LightlineMode()
	  return winwidth(0) > 60 ? lightline#mode() : ''
	endfunction
endif

"----------------------------------------------------------
" [設定]vim-airline
"----------------------------------------------------------
if neobundle#is_installed('vim-airline')
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	"左側に使用されるセパレータ
	let g:airline_left_sep = '⮀'
	let g:airline_left_alt_sep = '⮁'
	"右側に使用されるセパレータ
	let g:airline_right_sep = '⮂'
	let g:airline_right_alt_sep = '⮃'
	let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
	let g:airline_symbols.linenr = '¶'			"行
	let g:airline_symbols.maxlinenr = '㏑'		"最大行
	let g:airline_symbols.branch = '⭠'		"gitブランチ
	let g:airline_symbols.paste = 'ρ'			"ペーストモード
	let g:airline_symbols.spell = 'Ꞩ'			"スペルチェック
	let g:airline_symbols.notexists = '∄'		"gitで管理されていない場合
	let g:airline_symbols.whitespace = 'Ξ'	"空白の警告(余分な空白など)
endif

"----------------------------------------------------------
" [設定]luochen1990/rainbow
"----------------------------------------------------------
if neobundle#is_installed('indentLine')
	let g:indentLine_color_term = 111
	let g:indentLine_color_gui = '#708090'
	let g:indentLine_char = '┆'
endif

"----------------------------------------------------------
" [設定]luochen1990/rainbow
"----------------------------------------------------------
if neobundle#is_installed('rainbow')
	let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
endif

"----------------------------------------------------------
" [設定]vim-submode.vim
"----------------------------------------------------------
"ウインドウサイズ変更
if neobundle#is_installed('vim-submode')
	call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
	call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
	call submode#map('bufmove', 'n', '', '+', '<C-w>+')
	call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endif


"----------------------------------------------------------
"[設定] CtrlPの設定
"----------------------------------------------------------
if neobundle#is_installed('ctrlp.vim')
	let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
	let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
	let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
	let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用
	let g:ctrlp_regexp = 0 "
	let g:ctrlp_use_caching = 1				" キャッシュを使用して検索を高速化
	let g:ctrlp_clear_cache_on_exit = 0	"	" vim終了時にキャッシュをクリアしない
	let g:ctrlp_show_hidden = 0				" 隠しファイルを表示しない

	" 検索してほしくないファイルやディレクトリを除外
	let g:ctrlp_custom_ignore = {
		\ 'dir':  '\v[\/]\.?(extlib|git|hg|svn)$',
		\ 'file': '\v\.(exe|elf|so|dll|o|so|swp|ga|db|terminal|zip|jpg|png|xlsx|xls)$',
		\ 'link': 'some_bad_symbolic_links',
	\ }
	"set wildignore+=*/Music/*,*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.doc,*.xlsx,*.xls
	"memo: \Library\Musicを除外できていない。（要調査）
	let wildignore = $HOME.'/\(Library\|Google Drive\|Music\|Movies\|Pictures\|Documents\)\|.\(pdf\|epub\|mobi\|rar\|png\|jpg\|dmg\|nib\|bz\|gz\|tar\|db\|terminal\|plist\|xib\)$'


	" CtrlPCommandLineの有効化
	command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

	" CtrlPFunkyの有効化
	let g:ctrlp_funky_matchtype = 'path'
endif

"----------------------------------------------------------
"osyo-manga/vim-over
"----------------------------------------------------------

"----------------------------------------------------------
"osyo-manga/vim-anzu
"----------------------------------------------------------
if neobundle#is_installed('vim-anzu')
	nmap n <Plug>(anzu-n-with-echo)
	nmap N <Plug>(anzu-N-with-echo)
	nmap * <Plug>(anzu-star-with-echo)
	nmap # <Plug>(anzu-sharp-with-echo)
	" clear status
	nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
	" statusline
	set statusline=%{anzu#search_status()}
endif

"----------------------------------------------------------
" osyo-manga/vim-brightest
"----------------------------------------------------------
if neobundle#is_installed('vim-brightest')
	" ハイライトするグループ名を設定します
	" アンダーラインで表示する
	let g:brightest#highlight = {
	\   "group" : "BrightestUnderline"
	\}

	" ハイライトする単語のパターンを設定します
	" デフォルト（空の文字列の場合）は <cword> が使用されます
	"let g:brightest#pattern = '\k\+'
endif

"----------------------------------------------------------
" [設定]ag.vim
"----------------------------------------------------------
if neobundle#is_installed('ag.vim') && executable('ag')
	" agが使える環境の場合
	if has('win32')||has('win64')
		let g:ctrlp_user_command='ag %s --files-with-matches --nocolor --hidden -g ""'.' --path-to-ignore '.$HOME.'/.agignore'
	else
		let g:ctrlp_user_command='ag %s --files-with-matches --nocolor --hidden -g ""'
	endif
	
	"let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
	"let g:ctrlp_user_command = "ag --ignore-case --files-with-matches --nocolor --hidden -g '\\.(asm|bat|cs|cfg|config|cpp|hpp|c|h|fish|go|html|ini|js|java|json|lua|py|pl|rb|vbs|md|mac|txt|sh|bash|ps1|md|xml|csv|log|vim)$'"
	"--asm --batch --csharp --cc --cpp --glsl --go --haskell --html --ini --java --js --json --log --lua --make --markdown --md --perl --php --python --ruby --shell --yaml --vim --xml --yaml'
endif

"----------------------------------------------------------
" [設定]psearch.vim
"----------------------------------------------------------


"----------------------------------------------------------
" [設定]nerdtree
"----------------------------------------------------------

"----------------------------------------------------------
" [設定]vim-expand-region
"----------------------------------------------------------
if neobundle#is_installed('vim-expand-region')
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)
	"iw iW は動作が非常に遅いため無効化している
	let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :1,
      \ 'ip'  :1,
      \ 'ie'  :1,
      \ }
endif

"----------------------------------------------------------
" [設定]vim-surround
"----------------------------------------------------------
if neobundle#is_installed('vim-surround')
	call DefineKey_M('2')
	vmap <M-2> S"

	call DefineKey_M('7')
	vmap <M-7> S'

	call DefineKey_M('8')
	vmap <M-8> S(

	"VIM起動時に画面先頭に変な文字が挿入されるためコメントアウト中
	"call DefineKey_M('[')
	"vmap <M-[> S{
	"
	"動作しない
	"call DefineKey_M(',')
	"vmap <M-lt> S<
	"
	"動作しない
	"call DefineKey_M('@')
	"vmap <M-@> S`

endif


"----------------------------------------------------------
" [設定]syntastic
"----------------------------------------------------------
if neobundle#is_installed('syntastic')
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 0
	let g:syntastic_check_on_wq = 1

	let g:syntastic_error_symbol='✗'
	let g:syntastic_style_error_symbol = '✗'
	let g:syntastic_warning_symbol = '⚠'
	let g:syntastic_style_warning_symbol = '⚠'

	"python
	let g:syntastic_python_checkers = ['pyflakes']

	"sh
	"let g:syntastic_sh_checkers = ['shellcheck']
	let g:syntastic_sh_checkers = ['sh']
endif


"----------------------------------------------------------
" [設定]gundo
"----------------------------------------------------------
if neobundle#is_installed('gundo.vim')
	nnoremap u g-
	nnoremap <C-r> g+
endif


"----------------------------------------------------------
" [設定]jedi-vim
"----------------------------------------------------------
if neobundle#is_installed('jedi-vim')
	"pythonのバージョンを2に固定して以下のエラーが表示されないようにする。
	"jedi-vim failed to initialize Python: jedi-vim requires Vim with support for Python 2 or 3.  .... 
	let g:jedi#force_py_version = 2
endif

"----------------------------------------------------------
" [設定]vim-python-pep8-indent
"----------------------------------------------------------
if neobundle#is_installed('vim-python-pep8-indent')
	
endif

"----------------------------------------------------------
" [設定]OmniSharp
"----------------------------------------------------------
if neobundle#is_installed('omnisharp-vim')
	let g:OmniSharp_server_use_mono = 1
	let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim

	let g:OmniSharp_timeout = 5

	"let g:OmniSharp_server_type = 'v1'
	" The legacy server uses different syntastic checkers to roslyn
	"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
endif

"----------------------------------------------------------
" [設定]tyru/caw.vim
"----------------------------------------------------------
if neobundle#is_installed('caw.vim')
	nmap <C-e> <Plug>(caw:hatpos:toggle)
	vmap <C-e> <Plug>(caw:hatpos:toggle)
endif

"----------------------------------------------------------
" [設定]Unite
"----------------------------------------------------------
if neobundle#is_installed('unite.vim')
	" 大文字小文字を区別しな
	let g:unite_enable_ignore_case = 1
	let g:unite_enable_smart_case = 1
	"リンクファイルをMRUメニューに表示する
	"let g:neomru#follow_links = 1
	"dotfilesを表示する
	call unite#custom#source('file', 'matchers', "matcher_default")

	" ESCキーを2回押すと終了する
	au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:

	" grep検索
	nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
	" カーソル位置の単語をgrep検索
	nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
	" grep検索結果の再呼出
	nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

	" unite grep に ag(The Silver Searcher) を使う
	if executable('ag')
	  let g:unite_source_grep_command = 'ag'
	  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	  let g:unite_source_grep_recursive_opt = ''
	endif
endif


"----------------------------------------------------------
" [設定]unite-outline
"----------------------------------------------------------


"----------------------------------------------------------
" [設定]neocomplete
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  " return neocomplete#close_popup() . "\<CR>"
	  " For no inserting <CR> key.
	  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplete#close_popup()
	inoremap <expr><C-e>  neocomplete#cancel_popup()

	" Close popup by <Space>.
	inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

	" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	" "
	"Jedi-vimとの連携
	"
	autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	if !exists('g:neocomplete#force_omni_input_patterns')
			let g:neocomplete#force_omni_input_patterns = {}
	endif
	" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
	let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
endif


"----------------------------------------------------------
"秀丸エディタ互換
"----------------------------------------------------------
if neobundle#is_installed('unite')
	"ファイル一覧を開く
	nnoremap <silent> <C-o> :<C-u>Unite file<CR>
	inoremap <silent> <C-o> <ESC><ESC>:<C-u>Unite file<CR>
endif

if ! empty(neobundle#get("unite-outline"))
	"ウインドウ右側に表示する
	nnoremap <silent> <F4> :<C-u>Unite -vertical outline<CR>
endif


"単語選択
nnoremap <silent> <C-up> <ESC><ESC>viw
inoremap <silent> <C-up> <ESC><ESC>viw

"------------------------------------------------
"ウインドウ(最終行に記述しないと反映しなかった・・・なぜ？)
"------------------------------------------------
" ウインドウの幅
set columns=100
" ウインドウの高さ
set lines=50