@echo off
if exist image.jpg (
	for %%i in (*.mp3) do (
		echo Now converting %%~ni
		ffmpeg -loop 1 -r 1 -i image.jpg -i "%%i" -b:a 192k -s 1280x720 -y -shortest -loglevel error "%%~ni.mp4"
	)
) else (
    echo image.jpg doesn't exist in this folder.
    pause
)
