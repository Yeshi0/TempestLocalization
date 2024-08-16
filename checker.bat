@echo off
setLocal enableDelayedExpansion

for /f "tokens=1 delims=@" %%a in (fallback) do set "f_%%a=set"
for /f "tokens=1 delims=" %%a in ('dir /b /a-d') do if NOT "%%a"=="fallback" if NOT "%%a"=="%~nx0" for /f "tokens=1 delims=@" %%b in (%%a) do if NOT defined f_%%b echo(Unused translation present in '%%a': '%%b'.
for /f "tokens=1 delims=@" %%a in (fallback) do for /f "tokens=1 delims=" %%b in ('dir /b /a-d') do if NOT "%%b"=="fallback" if NOT "%%b"=="%~nx0" (
	set "string1=false"
	for /f "tokens=1 delims=@" %%c in (%%b) do if "%%a"=="%%c" set "string1="
	if defined string1 echo(Missing translation in '%%b': '%%a'.
)

echo(
echo(Finished.
echo(If any locales are missing translations, they will be mentioned above.

pause
exit /b 0