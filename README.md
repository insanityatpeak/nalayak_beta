# ☠️ Nalayak (Beta)

**Nalayak** (Hindi for *worthless/incompetent*) is an ultra-lightweight, cross-platform terminal roaster that intercepts your failed commands, roasts you with customizable personalities, and natively plays meme sounds in the background.

Unlike other terminal audio tools, Nalayak uses native APIs (`mciSendString` on Windows, `afplay` on macOS) to seamlessly play audio *without* freezing your terminal or requiring heavy dependencies.

---

## ✨ Features
- **Context-Aware Sound Triggers:**
  - 💥 **Dangerous Fails**: Fails a high-risk command like `rm` or `sudo`? You get a specific warning sound.
  - 🤡 **Gibberish**: Typing total garbage triggers a specific sound.
  - 🤕 **Typos**: Fuzzy matches your command to suggest fixes (e.g., `Did you mean: git?`).
  - 🎉 **Success Mode**: Type a correct command? There's a chance to trigger a random success meme!
- **Zero Dependencies:** Written in pure standard-library Python. No `pip install` required.
- **Cross-Platform:** Works seamlessly on **Windows PowerShell**, **macOS (zsh/bash)**, and **Linux (bash/fish)**.

## 🚀 Installation

### Windows (PowerShell)
1. Open PowerShell and navigate to this folder.
2. Run the installer:
   ```powershell
   .\install.ps1
   ```
3. Reload your profile:
   ```powershell
   . $PROFILE
   ```

### macOS / Linux (Zsh, Bash, Fish)
1. Open your terminal and navigate to this folder.
2. Make the installer executable and run it:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
3. Restart your terminal!

## ⚙️ Customization

You can fully customize the roasts, personalities, and meme sounds! The configurations are stored in the `config/` directory.

### Adding Custom Sounds
1. Drop any audio file (MP3, WAV) into the `sounds/` directory.
2. Open `config/sounds.json` and add the filename to the category you want it to trigger on!

### Custom Personalities
Want your terminal to yell at you like your manager? Open `config/personalities.json` and add your own custom quotes and personas.

## 🗑️ Uninstalling

If the roasts get too real, you can easily remove Nalayak without leaving any trace.

- **Windows:** Run `.\uninstall.ps1`
- **macOS/Linux:** Run `./uninstall.sh`
