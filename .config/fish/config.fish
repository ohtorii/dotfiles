if status is-interactive
    # Commands to run in interactive sessions can go here
end

# MY_USERPROFILE を定義
if not set -q USERPROFILE
  echo "ERROR: USERPROFILE environment variable is not set."
end
set  MY_USERPROFILE (cygpath -u "$USERPROFILE")
echo "MY_USERPROFILE is set to: $MY_USERPROFILE"

set -U EDITOR /C/ProgramData/chocolatey/bin/edit.exe

zoxide init fish | source

# pacman -S mingw64/mingw-w64-x86_64-bat
set -U fish_user_paths /C/tools/msys64/mingw64/bin $fish_user_paths

# jethrokuan/fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# ghq
set -g GHQ_SELECTOR fzf
set -g GHQ_SELECTOR_OPTS --height 40%
set -U fish_user_paths $MY_USERPROFILE/scoop/shims $fish_user_paths
