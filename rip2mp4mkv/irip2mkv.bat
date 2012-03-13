@echo off
set org=%1
set base=""
set vtime=""
set atime=""
set /p width=ENTER FRAME WIDTH FOR VIDEO: 
set /p height=ENTER FRAME HEIGHT FOR VIDEO: 
set /p vqual=ENTER QUALITY FOR VIDEO [0(lossless) to 51(least), 23 is normal]: 
set /p aqual=ENTER BITRATE FOR AUDIO IN kbps [64-320, 128 is normal]: 
IF /I %2 EQU yes ( 
	set base="%org:~1,-5%-sample
	set vtime=--frames 1800
	set atime=-t 60
	echo ==========NOTE: SAMPLE WILL BE OF 1 MINUTE DURATION APPROXIMATELY.===========
) ELSE (
	set base="%org:~1,-5%
	set vtime= 
	set atime= 
)
set avs=%base%-avs.avs"
set vid=%base%-vid.mkv"
set aud=%base%-aud.aac"
set rip=%base%-matroska-x264-AAC.mkv"
IF EXIST %vid% del /q %vid%
IF EXIST %aud% del /q %aud%
IF EXIST %avs% del /q %avs%
IF EXIST %rip% del /q %rip%
echo ===================================================
echo =============STARTING VIDEO ENCODING===============
echo ===================================================
echo spline64resize(directshowsource(%org%),%width%,%height%) >> %avs%
x264 --level 3.0 --profile main --crf %vqual% %vtime% -o %vid% %avs%
echo ===================================================
echo =============STARTING AUDIO ENCODING===============
echo ===================================================
ffmpeg -i %avs% -vn -ab %aqual%k -y %atime% -ac 2 -ar 44100 %aud%
echo ===================================================
echo ==============MUXING VIDEO & AUDIO=================
echo ===================================================
mkvmerge -o %rip% %vid% %aud%
del %vid%
del %aud%
del %avs%