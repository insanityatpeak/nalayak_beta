#!/usr/bin/env bash
set -e

echo -e "\033[36mInstalling nalayak_beta...\033[0m"

INSTALL_DIR="$HOME/.nalayak_beta"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$INSTALL_DIR"
cp -r "$SRC_DIR/"* "$INSTALL_DIR/"

# Hook for bash
BASHRC="$HOME/.bashrc"
BASH_HOOK_LINE="source \"$INSTALL_DIR/hooks/hook.bash\""
if ! grep -qF "$BASH_HOOK_LINE" "$BASHRC" 2>/dev/null; then
    echo -e "\n# nalayak_beta hook\n$BASH_HOOK_LINE" >> "$BASHRC"
    echo -e "\033[32mHook added to $BASHRC\033[0m"
fi

# Hook for zsh
ZSHRC="$HOME/.zshrc"
ZSH_HOOK_LINE="source \"$INSTALL_DIR/hooks/hook.zsh\""
if [ -f "$ZSHRC" ] && ! grep -qF "$ZSH_HOOK_LINE" "$ZSHRC" 2>/dev/null; then
    echo -e "\n# nalayak_beta hook\n$ZSH_HOOK_LINE" >> "$ZSHRC"
    echo -e "\033[32mHook added to $ZSHRC\033[0m"
fi

# Hook for fish
FISH_CONF_DIR="$HOME/.config/fish/conf.d"
if [ -d "$HOME/.config/fish" ]; then
    mkdir -p "$FISH_CONF_DIR"
    cp "$INSTALL_DIR/hooks/hook.fish" "$FISH_CONF_DIR/nalayak_beta.fish"
    echo -e "\033[32mHook added to $FISH_CONF_DIR/nalayak_beta.fish\033[0m"
fi

echo -e "\033[32mnalayak_beta installed successfully! Restart your terminal.\033[0m"
