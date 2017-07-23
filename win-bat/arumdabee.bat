:: ArumDaBee 아름다비
:: Easy ADB interface
::
:: Written by David.Hong
:: Codes are opened under CC BY-SA 4.0

@echo off
pushd %~dp0

:_init
color 2f
cls
mode con cols=55 lines=30
set /a WAITTIME = 5

:_checkfile
::echo ^> Searching for adb.exe file...
if exist .\platform-tools\adb.exe (
 set adb=.\platform-tools\adb.exe
 goto _startmenu
)
if exist .\adb.exe (
 set adb=.\adb.exe
 goto _menu
)
if exist .\adb\adb.exe (
 set adb=.\adb\adb.exe
 goto _startmenu
)
if exist %1\adb.exe (
 set adb=%1\adb.exe
 goto _startmenu
)
if exist .\adb.conf (
	setlocal enabledelayedexpansion
	set /p adb= <adb.conf
	if exist !adb!\adb.exe (
		set adb=!adb!\adb.exe
		setlocal disabledeyaledexpansion
 		goto _startmenu
	)
	if exist !adb!\..\adb.exe (
		setlocal disabledelayedexpansion
		goto _startmenu
	)
	setlocal disabledelayedexpansion
	echo ^> Current configuration invalid:
	echo ^> Unable to find adb.exe !
)

:_findfile
echo ^> Where is the adb.exe file?
echo ^> (Type path or drag file here from explorer)
echo|set /P ="> "
set /p adb=
if exist %adb%\adb.exe (
	set adb=%adb%\adb.exe
	goto _startmenu
)
if exist %adb%\..\adb.exe (
	goto _startmenu
)
goto _nofile

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

:_startmenu
echo %adb% > adb.conf
setlocal disabledelayedexpansion

:_menu
cls
set run=
color 2f
echo ================================================
echo		       A r u m D a B e e
echo.
echo             easier ADB experience
echo  v 0.0.4a                         (c)David.Hong
echo ================================================
echo.
echo	1	Kill running ADB server
echo	2	ADB via WiFi connect device
echo	3	ADB via WiFi connection setup
echo	4	ADB connected device list
echo	5	APK install via ADB
::echo	6	APK ^& Data Backup
::echo	7	APK ^& Data Restore
echo	8	Logcat
echo.
echo	0	Exit
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
echo ^> Listed device correct?
choice /C YN0 /M "> [Y]es(default) [N]o [0]menu" /T %WAITTIME% /D Y /N
if ERRORLEVEL 3 ( goto _menu )
if ERRORLEVEL 2 ( cls && goto _f3 )

:_f3_askport
echo ^> What port will be used to connect?
echo ^> Leave blank to use port 5555 (default)
echo|set /P ="> "
set /p port=
if [%port%]==[] set port=5555
echo ^> Using port [%port%]. Correct?
choice /C YN /M "> [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 ( goto _f3_askport )

echo -------------------- adb -----------------------
%adb% tcpip %port%
echo ------------------------------------------------

echo Finished.
echo|set /P ="> "
pause
set port=
goto _menu



:_f4
echo ^> [4] Check connected devices
echo -------------------- adb -----------------------
%adb% devices
echo ------------------------------------------------
echo|set /P ="> "
pause
goto _menu



:_f5
echo ^> [5] Installing apk via ADB
echo -------------------- adb -----------------------
%adb% devices
echo ------------------------------------------------
echo ^> Listed device correct?
choice /C YN0 /M "> [Y]es(default) [N]o [0]menu" /T %WAITTIME% /D Y /N
if ERRORLEVEL 3 ( goto _menu )
if ERRORLEVEL 2 ( cls && goto _f5 )

:_f5_askpath
echo ^>
echo ^> Where is the APK file to install?
echo ^> Type path or drag apk file in to this window.
echo|set /P ="> "
set /p apk=
if [%apk%]==[] (
	echo ^> * Path is empty!
	set apk=
	color 2f
	goto _f5_askpath
)
if not exist %apk% (
	color 4f
	echo ^> * APK file specified doesn't exist.
	set apk=
	color 2f
	goto _f5_askpath
)

:_f5_confirmpath
echo ^>
echo ^> Path to apk file:
echo ^> %apk%
choice /C YN /M "> Correct? [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 ( goto _f5_askpath )
if ERRORLEVEL 1 ( goto _f5_opt_l )

:_f5_opt_l
echo ^>
echo ^>
echo ^> Is apk forward lock application?
choice /C YN /M "> [Y]es or unsure(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 (
	set l= 
	echo ^> * Not allowing forwarding.
)
if ERRORLEVEL 1 (
	set l=l
	echo ^> * Allowing forwarding!
)

:_f5_opt_t
echo ^>
echo ^> Allow test package?
choice /C YN /M "> [Y]es [N]o(default)" /T %WAITTIME% /D N /N
if ERRORLEVEL 2 (
	set t=
	echo ^> * Not allowing test packages.
)
if ERRORLEVEL 1 (
	set t=t
	echo ^> * Allowing test packages!
)


:_f5_opt_s
echo ^>
echo ^> Install application on SD card?
choice /C YN /M "> [Y]es [N]o(default)" /T %WAITTIME% /D N /N
if ERRORLEVEL 2 (
	set s=
	echo ^> * Installing application on internal memory only.
)
if ERRORLEVEL 1 ( 
	set s=s
	echo ^> * Allow installing application on SD card!
)


:_f5_opt_d
echo ^>
echo ^> Allow downgrade?
echo ^> (Only works with debug enabled APK)
choice /C YN /M ">  [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 (
	set d=
	echo ^> * Not allowing downgrade.
)
if ERRORLEVEL 1 ( 
	set d=d
	echo ^> * Allowing downgrade!
)


:_f5_opt_g
echo ^>
echo ^> Grant all runtime permissions?
choice /C YN /M ">  [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 (
	set g=
	echo ^> * Not granting all runtime permissions.
)
if ERRORLEVEL 1 ( 
	set g=g
	echo ^> * Granting all runtime permissions!
)

:_f5_opt_apply
echo ^>
echo ^> Command = "adb install -%l%r%t%%s%%d%%g% %apk%"

echo -------------------- adb -----------------------
%adb% install -%l%r%t%%s%%d%%g% %apk%
echo ------------------------------------------------

echo ^> Finished!
set f5proceed=
set port=
set l=
set t=
set s=
set d=
set g=
echo|set /P ="> "
pause
goto _menu



:_f6
echo ^> [6] Backup and export APK ^& data via ADB
echo -------------------- adb -----------------------
%adb% devices
echo ------------------------------------------------
echo "> Listed device correct?"
choice /C YN0 /M ">  [Y]es(default) [N]o [0]menu" /T %WAITTIME% /D Y /N
if ERRORLEVEL 3 goto _menu
if ERRORLEVEL 2 ( cls && goto _f6 )
if ERRORLEVEL 1 ( goto _f5_askpath )

:_f6_askpath
echo ^>
echo ^> Where the backuped data should be placed?
echo ^> Type the path of directory or drag it to here.
echo|set /P ="> "
set /p file=
if [%folder%]==[] (
	echo ^> ERROR: Path is empty!
	set file=
	goto _f6_askpath
)
if not exist %file% (
	echo ^> ERROR: Specified path doesn't exist.
	set file=
	goto _f6_askpath
)

:_f6_confirmpath
echo ^> Backup file name:
echo|set /P ="> "
set /p file2=
if [%file2%]==[] (
	echo ^> ERROR: Path is empty!
	set file2=
	goto _f6_confirmpath
)
set file=%file%%file2%
echo ^>
echo ^> Location of backup file:
echo ^> %file%
choice /C YN /M "> Proceed? [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 goto _f6_askpath
if ERRORLEVEL 1 goto _f6_opt_packages

:_f6_opt_packages
echo ^>
echo ^> Find the app package name in the list shown next.
timeout /t 3 >nul
echo -------------------- adb -----------------------
%adb% shell pm list packages
echo ------------------------------------------------
echo ^>
::GET PACKAGES HERE
echo ^>


:_f6_opt_apk
echo ^>
echo ^> Include .obb files into the apk file?
choice /C YN /M ">  [Y]es(default) [N]o" /T %WAITTIME% /D Y /N
if ERRORLEVEL 2 (
	set apk=no
	echo ^> * Not exporting apk files.
)
if ERRORLEVEL 1 ( 
	set apk=
	echo ^> * Exporting apk files!
)

:_f6_opt_obb
echo ^>
echo ^> Include .obb files into the backup file?
choice /C YN /M ">  [Y]es [N]o(default)" /T %WAITTIME% /D N /N
if ERRORLEVEL 2 (
	set obb=no
	echo ^> * Not exporting obb files.
)
if ERRORLEVEL 1 ( 
	set obb=
	echo ^> * Exporting obb files!
)

:_f6_opt_shared
echo ^>
echo ^> Include shared storage into the backup file?
choice /C YN /M ">  [Y]es [N]o(default)" /T %WAITTIME% /D N /N
if ERRORLEVEL 2 (
	set shared=no
	echo ^> * Not exporting shared storage.
)
if ERRORLEVEL 1 ( 
	set shared=
	echo ^> * Exporting shared storage!
)

:_f6_process
echo ^> Command = "adb backup -f %f% -%apk%apk -%obb%obb -%shared%shared %pkg%"
echo -------------------- adb -----------------------
%adb% backup -f %file% %apk% %obb% %shared% %packages%
echo ------------------------------------------------
set f=
set apk=
set obb=
set shared=
set pkg=
echo ^> Finished.
echo|set /P ="> "
pause
goto _menu



:_f7
goto _menu



:_f8
echo [8] Logcat
echo ^> Press Ctrl+c to escape
pause
echo -------------------- adb -----------------------
%adb% logcat
echo ------------------------------------------------
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
::exit