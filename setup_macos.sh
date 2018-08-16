#!/bin/sh


DOT_FILES=(
.agignore
.vimrc
.bash_profile
.lynxrc
.config/fish/config.fish
.config/fish/functions/peco_select_history.fish
.config/karabiner/assets/complex_modifications/mission_control.json
.config/karabiner/assets/complex_modifications/pc_style_copy_past_extend.json
.config/karabiner/assets/complex_modifications/eisuu_vim.json
)


abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

SCRIPT_DIR="$(abs_dirname "$0")"
echo $SCRIPT_DIR

for file in ${DOT_FILES[@]}
do
    echo $file
    ln -sf $SCRIPT_DIR/$file $HOME/$file
done
