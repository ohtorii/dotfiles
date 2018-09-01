"----------------------------------------------------------
"[設定] molokai
"----------------------------------------------------------
if neobundle#is_installed('molokai') " molokaiがインストールされていれば
    colorscheme molokai " カラースキームにmolokaiを設定する
endif
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける


"----------------------------------------------------------
"[設定] ウインドウ設定
"----------------------------------------------------------
"フォントの設定
set guifont=Source\ Code\ Pro\ Light\ for\ Powerine:13
"メニューバーを非表示にする
"set guioptions-=m
"ツールバーを非表示にする
set guioptions-=T
"左右のスクロールバーを非表示にする
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
"水平スクロールバーを非表示にする
set guioptions-=b

"幅と高さ
set columns=120
if has('win32')||has('win64')
	set lines=80
else
	set lines=999
endif

