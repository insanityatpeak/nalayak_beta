import ctypes, os, glob
files = glob.glob(os.path.expanduser('~/.nalayak_beta/sounds/*.wav'))
for f in files:
    print(f"Testing {os.path.basename(f)}...")
    err1 = ctypes.windll.winmm.mciSendStringW(f'open "{f}" type mpegvideo alias media', None, 0, None)
    err2 = ctypes.windll.winmm.mciSendStringW('play media wait', None, 0, None)
    ctypes.windll.winmm.mciSendStringW('close media', None, 0, None)
    if err1 != 0 or err2 != 0:
        print(f"  FAILED! Open: {err1}, Play: {err2}")
    else:
        print("  OK")
