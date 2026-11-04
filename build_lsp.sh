#!/usr/bin/env bash

SCRIPTPATH=$(dirname "$(realpath "$0")")
LOGPATH="$SCRIPTPATH/nwscript.log"
SUCCESS="SUCCESS"
INFO="INFO"
WARN="WARN"
ERROR="ERROR"

print_log() {
  printf "%s: [%s] %s %s\n" "$(date)" "$1" "$2" | tee -a "$LOGPATH"
  sync
}

if ! [ "$EUID" -ne 0 ]; then
  print_log "$WARN" "Don't run this script as root. Exiting"
  sleep 1s
  exit 1
fi

commandExists() {
  command -v "$1" >/dev/null 2>&1
}

PKGS=(
  'git'
  'wget'
  'tar'
)

for PKG in "${PKGS[@]}"; do
  if ! commandExists "$PKG"; then
    print_log "$ERROR" "$PKG not found. Exiting."
    exit 1
  fi
done

APPS_PATH="$HOME/.apps"
LSP_ROOT_PATH="$APPS_PATH/nwscript_ls"

LSP_PATH="$LSP_ROOT_PATH/bin/nwscript-ee-language-server.cjs"

FILE_NAME='nwscript-ee-language-server-4.1.0_snd'
NEW_FILE_NAME='nwscript_ls'
LSP_URL="https://github.com/StefanoND/nwscript-ee-language-server/releases/download/v4.1.0_snd/$FILE_NAME.tgz"

if [ -f "$LSP_PATH" ]; then
  print_log "$SUCCESS" "LSP is already installed. Nothing else to do."
  exit 0
fi

if ! [ -d "$APPS_PATH" ]; then
  print_log "$INFO" "Creating '$APPS_PATH' folder."
  mkdir -p "$APPS_PATH" && sync
else
  print_log "$INFO" "'$APPS_PATH' folder already exists, continuing."
fi

if ! [ -d "$HOME/.local/bin" ]; then
  print_log "$INFO" "Creating '$HOME/.local/bin' folder."
  mkdir -p "$HOME/.local/bin" && sync
else
  print_log "$INFO" "'$HOME/.local/bin' folder already exists, continuing."
fi

if ! [ -d "$LSP_ROOT_PATH" ]; then
  print_log "$INFO" "Downloading LSP to '$APPS_PATH' folder."
  cd "$APPS_PATH"
  wget "$LSP_URL" && sync
  mv "$FILE_NAME.tgz" "$NEW_FILE_NAME.tgz"
  tar -xvf "$NEW_FILE_NAME.tgz"
  mv package "$NEW_FILE_NAME"
else
  print_log "$INFO" "LSP is already in '$APPS_PATH' folder already exists, continuing."
fi

if [ -d "$LSP_ROOT_PATH" ]; then
  cd "$LSP_ROOT_PATH" || exit 1
fi

if [ -f "$HOME/.local/bin/nwscript_ls" ]; then
  print_log "$INFO" "Backing up '$HOME/.local/bin/nwscript_ls'"
  mv "$HOME/.local/bin/nwscript_ls" "$HOME/.local/bin/nwscript_ls.old" && sync
fi

if ! [ -f "$HOME/.local/bin/nwscript_ls" ]; then
  print_log "$INFO" "Creating '$HOME/.local/bin/nwscript_ls'"
  touch "$HOME/.local/bin/nwscript_ls" && sync
  printf "#!/usr/bin/env bash
\"$HOME/.apps/nwscript_ls/bin/nwscript-ee-language-server.cjs\" --stdio" | tee "$HOME/.local/bin/nwscript_ls" && sync
fi

print_log "$INFO" "Making '$HOME/.local/bin/nwscript_ls' executable"
chmod +x "$HOME/.local/bin/nwscript_ls"

print_log "$SUCCESS" "LSP installed."
exit 0
