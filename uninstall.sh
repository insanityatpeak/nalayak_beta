#!/usr/bin/env bash

echo -e "\033[36mUninstalling nalayak_beta...\033[0m"

INSTALL_DIR="$HOME/.nalayak_beta"

# Remove hook from bashrc
if [ -f "$HOME/.bashrc" ]; then
    if [ "$(uname)" = "Darwin" ]; then
        sed -i '' '/# nalayak_beta hook/d' "$HOME/.bashrc" 2>/dev/null || true
        sed -i '' "\|source \"$INSTALL_DIR/hooks/hook.bash\"|d" "$HOME/.bashrc" 2>/dev/null || true
    else
        sed -i '/# nalayak_beta hook/d' "$HOME/.bashrc" 2>/dev/null || true
        sed -i "\|source \"$INSTALL_DIR/hooks/hook.bash\"|d" "$HOME/.bashrc" 2>/dev/null || true
    fi
fi

# Remove hook from zshrc
if [ -f "$HOME/.zshrc" ]; then
    if [ "$(uname)" = "Darwin" ]; then
        sed -i '' '/# nalayak_beta hook/d' "$HOME/.zshrc" 2>/dev/null || true
        sed -i '' "\|source \"$INSTALL_DIR/hooks/hook.zsh\"|d" "$HOME/.zshrc" 2>/dev/null || true
    else
        sed -i '/# nalayak_beta hook/d' "$HOME/.zshrc" 2>/dev/null || true
        sed -i "\|source \"$INSTALL_DIR/hooks/hook.zsh\"|d" "$HOME/.zshrc" 2>/dev/null || true
    fi
fi

# Remove fish hook
if [ -f "$HOME/.config/fish/conf.d/nalayak_beta.fish" ]; then
    rm "$HOME/.config/fish/conf.d/nalayak_beta.fish"
fi

# Remove directory
rm -rf "$INSTALL_DIR"

echo -e "\033[32mnalayak_beta uninstalled successfully. Restart your terminal.\033[0m"
