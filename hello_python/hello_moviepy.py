from moviepy import VideoFileClip

videoClip = VideoFileClip('aaa.mp4')

videoClip.write_gif('aaa.gif')

print("GIF done successfully!")