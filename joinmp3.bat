@echo off
del /f /q concat joined.mp3
for %%i in (*.mp3) do (
	echo file '%%~nxi' >> concat
)
ffmpeg -f concat -safe 0 -i concat -safe 0 -b:a 192k joined.mp3
del /f /q concat
