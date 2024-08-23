@echo off
setLocal enableDelayedExpansion
chcp 65001 >nul
mode 200,9999

for /f "tokens=1-2 delims=@" %%a in (fallback) do (
	set "f_%%a=set"
	set "len_%%a=%%b"
)
for /f "tokens=1 delims=" %%a in ('dir /b /a-d') do if NOT "%%a"=="fallback" if NOT "%%a"=="%~nx0" (
	echo(Now processing: '%%a'.
	echo(

	for /f "tokens=1-2 delims=@" %%b in (%%a) do if NOT "%%c"=="" (
		if NOT defined f_%%b (
			echo(ERROR: Unused translation present in '%%a': '%%b'.
			echo(

		) else (
			set "string1=%%c"
			set "string1=!string1:,=£!"
			set "string1=!string1: =_!"
			set "string1=!string1:\n= !"
			for %%d in (!string1!) do (
				call :getStringLength "%%d"
				if !length! GTR !len_%%b! (
					echo(ERROR: Translated text exceeds length limits in '%%a': '%%b'. Consider inserting newlines ^('\n'^).
					if NOT "!len_%%b!"=="65" (
						echo(       WARNING: String max length is not 65, this means newlines are likely NOT supported.
						echo(                You may try using newlines anyway, but please manually check to make sure they work.
						echo(                If newlines aren't supported here, rephrase your translation and contact Yeshi if you're stuck.

					) else (
						echo(       NOTE: String max length is 65, this means newlines are likely supported.
						echo(             Insert a newline and see if this error goes away.
					)

					echo(
				)
			)
		)
	)

	echo(Finished processing '%%a'.
	echo(
	echo(
	echo(
)

echo(Processing fallback...
echo(

for /f "tokens=1 delims=@" %%a in (fallback) do for /f "tokens=1 delims=" %%b in ('dir /b /a-d') do if NOT "%%b"=="fallback" if NOT "%%b"=="%~nx0" (
	set "string1=false"
	for /f "tokens=1 delims=@" %%c in (%%b) do if "%%a"=="%%c" set "string1="
	if defined string1 (
		echo(ERROR: Missing translation in '%%b': '%%a'.
		echo(
	)
)
echo(Finished processing fallback.
echo(
echo(
echo(

echo(Finished processing all locales.
echo(If there were any errors, they will be shown above clearly prefixed with 'ERROR:'.
pause
exit /b 0

:getStringLength
set "getLength=%~1"
set "length=0"
for /l %%a in (1,1,99) do if defined getLength (
	set /a length+=1
	set "getLength=!getLength:~1!"
)
exit /b 0