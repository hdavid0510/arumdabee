:: ArumDaBee 아름다비
:: Easy ADB wrapper.
::
:: Written by David.Hong
:: Codes are opened under CC BY-SA 4.0

@echo off
pushd %~dp0

:_init
color 2f
cls

:_checkfile
echo ^> Searching for adb.exe file...

if exist .\platform-tools\adb.exe (
 set adb=.\platform-tools\adb.exe
 goto _menu
)
if exist .\adb.exe (
 set adb=.\adb.exe
 goto _menu
)
if exist .\adb\adb.exe (
 set adb=.\adb\adb.exe
 goto _menu
)
if exist %1\adb.exe (
 set adb=%1\adb.exe
 goto _menu
)

:_findfile
echo ^> Finding adb.exe failed.
echo ^> Where is the directory including adb.exe file?
echo ^> (Drag folder here from explorer)
echo|set /P ="> "
set /p adb=
if exist %adb%\adb.exe (
 set adb=%adb%\adb.exe
 goto _menu
)

:_nofile
color 4f
echo ^> Cannot find adb.exe file!
echo ^> Check if you've entered correct path!
echo ^>
echo|set /P ="> "
pause
color 2f
cls
goto _findfile

:_menu
cls
set run=

color 2f
echo.
echo ================================================
echo               A r u m D a B e e
echo                easy ADB helper
echo  v 0.0.2a                          (c)David.Hong
echo ================================================
echo.
echo  1  Kill running ADB server
echo  2  ADB via WiFi connect device
echo  3  ADB via WiFi connection setup
echo.
echo  0  Exit
echo.
echo ================================================
echo.
echo Enter command to run.
echo|set /P ="> "
set /p run=

cls

if "%run%"=="0" ( goto _exit )
if "%run%"=="exit" ( goto _exit )

if "%run%"=="1" ( goto _f%run% )
if "%run%"=="2" ( goto _f%run% )
if "%run%"=="3" ( goto _f%run% )
if "%run%"=="4" ( goto _f%run% )
if "%run%"=="5" ( goto _f%run% )
if "%run%"=="6" ( goto _f%run% )
if "%run%"=="7" ( goto _f%run% )
if "%run%"=="8" ( goto _f%run% )
if "%run%"=="9" ( goto _f%run% )

if "%run%"=="a" ( goto _f%run% )
if "%run%"=="A" ( goto _f%run% )
if "%run%"=="b" ( goto _f%run% )
if "%run%"=="B" ( goto _f%run% )
if "%run%"=="c" ( goto _f%run% )
if "%run%"=="C" ( goto _f%run% )
if "%run%"=="d" ( goto _f%run% )
if "%run%"=="D" ( goto _f%run% )
if "%run%"=="e" ( goto _f%run% )
if "%run%"=="E" ( goto _f%run% )
if "%run%"=="f" ( goto _f%run% )
if "%run%"=="F" ( goto _f%run% )
if "%run%"=="g" ( goto _f%run% )
if "%run%"=="G" ( goto _f%run% )


goto _menu








:_f1
echo ^> [1] Killing running ADB server
echo ^>

echo -------------------- adb -----------------------
%adb% kill-server
echo ------------------------------------------------

echo ^> Finished.
echo|set /P ="> "
pause
goto _menu



:_f2
echo ^> [2] Connecting device via WiFi
echo ^>

:_f2_enterip
echo ^> Enter device IP and port.
echo ^> If port not declared, default port 5555 will be used.
echo|set /P ="> "
set /p ip=

if "%ip%"=="" (
 cls
 echo ^> Error: Address is blank!
 echo ^>
 goto _f2_enterip
)

echo ^>
echo ^> connecting to: %ip%
echo -------------------- adb -----------------------
%adb% connect %ip%
echo ------------------------------------------------

echo ^> Finished.
echo|set /P ="> "
pause
set ip=
goto _menu



:_f3
echo ^> [3] Setting WiFi ADB connection
echo -------------------- adb -----------------------
%adb% devices
echo ------------------------------------------------

echo|set /P ="> "
set /p f3proceed="Listed device correct? [Y/N] : "
if "%f3proceed%" == "Y" goto _f3_askport
if "%f3proceed%" == "y" goto _f3_askport
if "%f3proceed%" == "0" (
 set f3proceed=
 goto _menu
)
cls
goto _f3

:_f3_askport
echo ^> What port will be used to connect?
echo|set /P ="> "
set /p port=

echo|set /P ="> "
set /p f3proceed="Using port [%port%] correct? [Y/N] : "
if not %f3proceed% == Y (
 if not %f3proceed% == y goto _f3_askport
)

echo -------------------- adb -----------------------
%adb% tcpip %port%
echo ------------------------------------------------

echo Finished.
echo|set /P ="> "
pause
set f3proceed=
set port=
goto _menu



:_f4
goto _menu



:_f5
goto _menu



:_f6
goto _menu



:_f7
goto _menu



:_f8
goto _menu



:_f9
goto _menu



:_fa
:_fA
goto _menu



:_fb
:_fB
goto _menu



:_fc
:_fC
goto _menu



:_fd
:_fD
goto _menu



:_fe
:_fE
goto _menu



:_ff
:_fF
goto _menu



:_fg
:_fG
goto _menu



:_exit
exit