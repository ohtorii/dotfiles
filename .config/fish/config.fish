function fish_user_key_bindings
  # Emacsキーバインドが使われるように、モードごとにこれを一度実行する。
  #fish_default_key_bindings -M insert
  # fish_vi_key_bindings は引数なしではすべてのキーバインドをデフォルトに戻す
  # fish_vi_key_bindingsの引数には最初のモードを指定する(insert, default, visual)
  #fish_vi_key_bindings insert

  bind \cr peco_select_history # Bind for peco select history to Ctrl+r
end

#from. http://fishshell.com/docs/current/index.html#editor
#function hybrid_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
#    for mode in default insert visual
#        fish_default_key_bindings -M $mode
#    end
#    fish_vi_key_bindings --no-erase
#end
#set -g fish_key_bindings hybrid_bindings

#SVN
set -x VISUAL vim
set -x MONO_GAC_PREFIX '/usr/local'

