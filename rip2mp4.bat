@echo off
set org=%1
set base=""
set vtime=""
set atime=""
set width=%2
set height=%3
set vqual=%4
set aqual=%5
set base="%org:~1,-5%
set avs=%base%-avs.avs"
set vid=%base%-vid.mp4"
set aud=%base%-aud.aac"
set rip=%base%-iPod-x264-AAC.mp4"
IF EXIST %vid% del /q %vid%
IF EXIST %aud% del /q %aud%
IF EXIST %avs% del /q %avs%
IF EXIST %rip% del /q %rip%
echo =============================================================================
echo ==========================STARTING VIDEO ENCODING============================
echo =============================================================================
echo spline64resize(directshowsource(%org%),%width%,%height%) >> %avs%
x264 --level 3.0 --profile main --crf %vqual% -o %vid% %avs%
echo =============================================================================
echo ==========================STARTING AUDIO ENCODING============================
echo =============================================================================
ffmpeg -i %avs% -vn -ab %aqual%k -y -ac 2 -ar 44100 %aud%
echo =============================================================================
echo ==========================MUXING VIDEO AND AUDIO=============================
echo =============================================================================
mp4box -out %rip% %vid% -add %aud% -ipod
del %vid%
del %aud%
del %avs%