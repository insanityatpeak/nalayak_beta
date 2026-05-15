import ctypes, os
f = os.path.expanduser('~/.nalayak_beta/sounds/fahhh.wav')
err = ctypes.windll.winmm.mciSendStringW(f'open "{f}" alias media', None, 0, None)
print("open:", err)
err2 = ctypes.windll.winmm.mciSendStringW('play media wait', None, 0, None)
print("play:", err2)
