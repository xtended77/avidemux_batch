@set startTime=%time%
@ echo off
: List of codepages https://ss64.com/nt/chcp.html
CHCP 65001
set output_dir=E:\Video\Name of output directory

echo -----------------------------
set avidemux="C:\Program Files\Avidemux\avidemux.exe"

if not exist "%output_dir%" (
  mkdir "%output_dir%"
  echo Output directory not exist...
  echo "%output_dir%" created.
)

echo -----------------------------
echo Start encoding at %time%
echo Output dir "%output_dir%"
echo -----------------------------
for %%f in (*.avi *.mkv *.mov *.mp4 *.mts) do (
  echo Processing %%~ff
  %avidemux% --load "%%f" --run Settings.py --save "%output_dir%\%%~nf.mp4" --quit
)

del /y "%output_dir%\*.stats"
del /y "%output_dir%\*.mbtree"

echo -----------------------------
echo Start  time: %startTime%
echo Finish time: %time%
echo -----------------------------

Pause
