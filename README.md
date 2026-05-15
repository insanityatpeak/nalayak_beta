# ☠️ Nalayak (Beta)


https://github.com/user-attachments/assets/8b770c51-7bf2-4e4a-ab3c-f8857a275635



**Nalayak** (Hindi for *worthless/incompetent*) is an ultra-lightweight, cross-platform terminal roaster that intercepts your failed commands, roasts you with customizable personalities, and natively plays meme sounds in the background.

Unlike other terminal audio tools, Nalayak uses native APIs (`mciSendString` on Windows, `afplay` on macOS) to seamlessly play audio *without* freezing your terminal or requiring heavy dependencies.

---

## ✨ Features
- **Zero Dependencies:** Written in pure standard-library Python. No `pip install` required.
- **Lightweight Typo Engine:** Fuzzy matches your failed commands to suggest fixes without needing a massive database.
- **Cross-Platform:** Works seamlessly on **Windows PowerShell**, **macOS (zsh/bash)**, and **Linux (bash/fish)**.

---

## 🎭 Personalities & Roasts
Nalayak doesn't just throw standard error messages; it verbally assaults you using distinct Indian developer personas. You can fully customize these in `config/personalities.json`.

**Example Personas:**
- 👨🏽‍🦳 **Indian Dad**: *"Padhai likhai chhod de, singhade bech."*
- 🏢 **Toxic Senior**: *"PR review ke liye mat aana mere paas. Ye basic cheez nahi aati?"*
- ☁️ **DevOps Bhaiya**: *"Cloud bill tere akele ke failures se badh raha hai."*
- 🍕 **Hostel Friend**: *"Bhai raat ko kya phoonk ke coding kar raha tha?"*

---

## 🔊 Context-Aware SFX
The audio engine isn't just random—it actively analyzes *how* you failed and plays the appropriate Sound Effect (SFX). You can add your own `.wav` or `.mp3` files to the `sounds/` folder and map them in `config/sounds.json`.

**How the Audio Logic Works:**
- 🤕 **Typo Detect (`typo_confused.wav`)**: Triggers when you make a slight spelling mistake on a known command (e.g., typing `gti status`).
- 🤡 **Bad Arguments (`bruh.wav`, `vine_boom.wav`)**: Triggers when you type a real command correctly, but it fails due to bad arguments (e.g., `git push` in an empty folder).
- 💥 **Total Gibberish (`fahhh.wav`, `fail_scream.wav`)**: Triggers when your command isn't even close to a real word (e.g., `asdfghjkl`).
- ⚠️ **Dangerous Fails (`modi.wav`)**: Triggers specifically when you fail a high-risk destructive command like `rm`, `sudo`, or `del`.
- 🎉 **Positive Reinforcement (`nokia.wav`)**: 40% chance to trigger seamlessly in the background when you type a *successful* command!

---

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

---

## 🗑️ Uninstalling

If the roasts get too real, you can easily remove Nalayak without leaving any trace.

- **Windows:** Run `.\uninstall.ps1`
- **macOS/Linux:** Run `./uninstall.sh`
