export PATH=$PATH:/usr/local/sbin
export HISTCONTROL=ignoredups
export MONO_GAC_PREFIX="/usr/local"

# スクリーンロックのショートカットを解除
# ctrl-s でコマンド履歴を戻れるようにする
stty stop undef
stty start undefc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
