@set startTime=%time%
@echo off
color 02
: List of codepages https://ss64.com/nt/chcp.html
CHCP 65001
set output_dir=E:\Video\Name of output directory

echo --------------------------------------
set avidemux="C:\Program Files\Avidemux\avidemux.exe"

if not exist "%output_dir%" (
  mkdir "%output_dir%"
  echo Output directory not exist...
  echo "%output_dir%" created.
)

echo --------------------------------------
echo Start encoding at %startTime%
echo Output dir "%output_dir%"
echo --------------------------------------
for %%f in (*.avi *.mkv *.mov *.mp4 *.mts *.ts) do (
  echo Processing %%~ff
  %avidemux% --load "%%f" --run Settings.py --save "%output_dir%\%%~nf.mp4" --quit
)

del /y "%output_dir%\*.stats"
del /y "%output_dir%\*.mbtree"

echo --------------------------------------
echo Start  time: %startTime%
echo Finish time: %time%
echo --------------------------------------

set endTime=%time%
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%startTime%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%endTime%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%

if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%
:: Mission accomplished
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo Time to complete "%hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total)
echo --------------------------------------
pause
