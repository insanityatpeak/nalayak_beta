import os
import sys
import json
import random
import subprocess
import platform

DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_DIR = os.path.join(DIR, "config")

def load_json(filename):
    try:
        with open(os.path.join(CONFIG_DIR, filename), 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return {}

def play_sound(category="fail"):
    sounds_config = load_json("sounds.json")
    sounds_dir = os.path.join(DIR, "sounds")
    
    sound_file = None
    if category in sounds_config and sounds_config[category]:
        file_name = random.choice(sounds_config[category])
        sound_path = os.path.join(sounds_dir, file_name)
        if os.path.exists(sound_path):
            sound_file = sound_path
            
    if not sound_file and os.path.exists(sounds_dir):
        files = [f for f in os.listdir(sounds_dir) if f.endswith(('.wav', '.mp3', '.ogg', '.aiff'))]
        if files:
            sound_file = os.path.join(sounds_dir, random.choice(files))
            
    if sound_file:
        try:
            if platform.system() == "Windows":
                CREATE_NO_WINDOW = 0x08000000
                script = (
                    "import ctypes, sys; "
                    "f = sys.argv[1]; "
                    "ctypes.windll.winmm.mciSendStringW(f'open \"{f}\" type mpegvideo alias media', None, 0, None); "
                    "ctypes.windll.winmm.mciSendStringW('play media wait', None, 0, None); "
                    "ctypes.windll.winmm.mciSendStringW('close media', None, 0, None)"
                )
                subprocess.Popen(
                    [sys.executable, "-c", script, sound_file],
                    creationflags=CREATE_NO_WINDOW
                )
            elif platform.system() == "Darwin":
                subprocess.Popen(["afplay", sound_file], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
            else:
                subprocess.Popen(["paplay", sound_file], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        except Exception:
            pass

def main():
    if len(sys.argv) < 2:
        return
        
    cmd_full = sys.argv[1].strip()
    exit_code = sys.argv[2] if len(sys.argv) > 2 else "?"
    is_success = str(sys.argv[3]).lower() == "true" if len(sys.argv) > 3 else False
    
    if not cmd_full:
        return
        
    # Attempt to fix Windows code page issues when printing emojis
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError:
        pass
        
    if is_success:
        if random.random() < 0.4:
            play_sound("success")
        return
        
    base_cmd = cmd_full.split()[0].lower()
    
    commands = load_json("commands.json")
    personalities = load_json("personalities.json")
    
    # Decide roast message
    if base_cmd in commands and random.random() > 0.4:
        roaster = "Terminal"
        roast = random.choice(commands[base_cmd])
    else:
        if personalities:
            roaster = random.choice(list(personalities.keys()))
            roast = random.choice(personalities[roaster])
        else:
            roaster = "System"
            roast = "Command failed."

    # --- INTELLIGENT SOUND LOGIC ---
    import difflib
    known_commands = list(commands.keys()) + ["cd", "ls", "dir", "echo", "cat", "rm", "sudo", "del", "mkdir", "clear"]
    suggested_cmd = None
    
    if base_cmd in ["rm", "sudo", "chmod", "chown", "del", "remove-item"]:
        # 1. Dangerous command failed
        sound_cat = "dangerous"
    elif base_cmd in commands:
        # 2. Known command failed (user typed 'git' correctly, but args failed)
        sound_cat = "funny"
    else:
        # 3. Typo detection
        closest = difflib.get_close_matches(base_cmd, known_commands, n=1, cutoff=0.7)
        if closest:
            sound_cat = "typo"
            suggested_cmd = closest[0]
        else:
            # 4. Complete gibberish
            sound_cat = "command_not_found"

    # Play sound in background
    play_sound(sound_cat)
    
    # Print the roast
    print(f"\n\033[91m✖ Command failed\033[0m (Exit code: {exit_code})")
    print(f"\033[93m☠ {roaster}:\033[0m \033[1m“{roast}”\033[0m\n")

    if suggested_cmd:
        print(f"\033[92m⚠ Did you mean: {suggested_cmd}?\033[0m\n")
    elif commands and random.random() < 0.4:
        hints = list(commands.keys())
        random.shuffle(hints)
        hint_str = ", ".join(hints[:8])
        print(f"\033[36m💡 Try failing these commands for custom roasts: {hint_str}\033[0m\n")

if __name__ == "__main__":
    main()
