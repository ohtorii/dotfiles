"----------------------------------------------------------
"[設定] molokai
"----------------------------------------------------------
if neobundle#is_installed('molokai') " molokaiがインストールされていれば
    colorscheme molokai " カラースキームにmolokaiを設定する
endif
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける


"----------------------------------------------------------
"[設定] molokai
"----------------------------------------------------------
set columns=120
set lines=999
set guifont=Source\ Code\ Pro\ Light\ for\ Powerine:13
