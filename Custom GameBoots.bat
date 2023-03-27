@echo off
title Custom GameBoots
mode con cols=80 lines=25
color 0A
: MENU
cls
echo.
echo 		       ษออออออออออออออออออออออออออออออออป
echo 		       บ        Custom GameBoots        บ
echo 		       ศออออออออออออออออออออออออออออออออผ
echo.
echo 	               d88888888b.    .d8888b d88888888b.
echo 	                       `8D    88'             `8D
echo 	                       .8D    88              .8D
echo 	               d88888888P'    88            oooY'
echo 	               88'            88              `8D
echo 	               88            .88              .8D
echo 	               88        Y8888P'      Y88888888P'
echo.
echo 		       ษออออออออออออออออออออออออออออออออป
echo 		       บ     Batch Code by brunolee     บ
echo 		       ศออออออออออออออออออออออออออออออออผ
echo.

: SELECTCFW
if not exist gameboot.png copy Rcomage\tex_ps3logo.png>NUL&ren tex_ps3logo.png gameboot.png&Rcomage\FotografixPortable\FotografixPortable gameboot.png

echo set outp=wscript.stdout>Selectbox.vbs
echo c=inputbox("[0]  Create gameboot package"^&chr(13)^&chr(13)^&"[1]  Create CFW 3.55 gameboot"^&chr(13)^&chr(13)^&"[2]  Create CFW 4.21 gameboot"^&chr(13)^&chr(13)^&"[3]  Create CFW 4.30 gameboot"^&chr(13)^&chr(13)^&"[4]  Create CFW 4.41 gameboot"^&chr(13)^&chr(13)^&"[5]  Create CFW 4.46 gameboot"^&chr(13)^&chr(13)^&"[6]  Create CFW 4.50 gameboot"^&chr(13)^&chr(13)^&"[7]  Create CFW 4.53 gameboot"^&chr(13)^&chr(13)^&"[8]  Create CFW 4.55 gameboot"^&chr(13)^&chr(13)^&chr(13)^&"Select [0]  [1]  [2]  [3]  [4]  [5]  [6]  [7]  [8]:","CFW Gameboot MENU","0")>>Selectbox.vbs
echo outp.write(c)>>Selectbox.vbs

set sel=brunolee
for /f "tokens=*" %%a in ('cscript /nologo Selectbox.vbs') do set sel=%%a
del Selectbox.vbs>NUL
if %sel%==0 (goto SELECTINSTALL)
if %sel%==1 (set CFW=3.55&goto CREATE)
if %sel%==2 (set CFW=4.21&goto CREATE)
if %sel%==3 (set CFW=4.30&goto CREATE)
if %sel%==4 (set CFW=4.41&goto CREATE)
if %sel%==5 (set CFW=4.46&goto CREATE)
if %sel%==6 (set CFW=4.50&goto CREATE)
if %sel%==7 (set CFW=4.53&goto CREATE)
if %sel%==8 (set CFW=4.55&goto CREATE)
if %sel%== (goto SELECTCFW)
if %sel%==brunolee echo c=msgbox("Gameboot creation canceled"^&chr(13)^&"Goodbye...","48","CANCEL")>Info.vbs&Info.vbs&del Info.vbs>NUL&exit
goto SELECTCFW

: CREATE
if exist custom_render_plugin.rco del custom_render_plugin.rco
copy gameboot.png tex_ps3logo.png>NUL
copy Rcomage\tex_scelogo.gim tex_scelogo.gim>NUL
Rcomage\rcomage compile Rcomage\Gameboot_%CFW%.xml custom_render_plugin.rco --zlib-method default --zlib-level 9 --pack-res zlib --pack-hdr zlib --quiet
del tex_ps3logo.png>NUL
del tex_scelogo.gim>NUL

if exist custom_render_plugin.rco echo c=msgbox("Gameboot for CFW%CFW%"^&chr(13)^&"successfully created!!","64","Gammeboot INFO")>Info.vbs&Info.vbs&del Info.vbs>NUL

: SELECTINSTALL
echo set outp=wscript.stdout>Selectbox.vbs
echo c=inputbox("[1]  Create ZIP to install with ''multiMAN''"^&chr(13)^&chr(13)^&"[2]  Create PKG to install with ''Custom GameBoots''"^&chr(13)^&chr(13)^&chr(13)^&"Select [1]  [2]:","Install Gameboot MENU","1")>>Selectbox.vbs
echo outp.write(c)>>Selectbox.vbs

set sel=brunolee
for /f "tokens=*" %%a in ('cscript /nologo Selectbox.vbs') do set sel=%%a
del Selectbox.vbs>NUL
if %sel%==1 (goto CREATEZIP)
if %sel%==2 (goto CREATEPKG)
if %sel%== (goto SELECTINSTALL)
if %sel%==brunolee echo c=msgbox("Canceled"^&chr(13)^&"Goodbye...","48","CANCEL")>Info.vbs&Info.vbs&del Info.vbs>NUL&exit
goto SELECTINSTALL

: CREATEZIP
if not exist custom_render_plugin.rco echo c=msgbox("Create a CFW gameboot first...","48","CANCEL")>Info.vbs&Info.vbs&del Info.vbs>NUL&goto SELECTCFW
if not exist vsh\resource mkdir vsh\resource>NUL
if exist PS3~dev_blind.zip del PS3~dev_blind.zip>NUL
copy custom_render_plugin.rco vsh\resource\custom_render_plugin.rco>NUL

Rcomage\7z a "PS3~dev_blind.zip" "vsh">NUL
if exist vsh rmdir /s /q vsh>NUL

if exist PS3~dev_blind.zip echo c=msgbox("ZIP Gameboot for CFW%CFW%"^&chr(13)^&"successfully created!!","64","ZIP Gammeboot INFO")>Info.vbs&Info.vbs&del Info.vbs>NUL
goto SELECTINSTALL

: CREATEPKG
if not exist custom_render_plugin.rco goto MAKEPKG
set GAMEBOOT_TITLE=brunolee

echo set outp=wscript.stdout>>TITLE.vbs
echo c=inputbox(" Give a name to gameboot"^&chr(13)^&chr(13)^&chr(13)^&" Example:"^&chr(13)^&" PlayStation 3 (Classic)","GAMEBOOT NAME","TITLE")>>TITLE.vbs
echo outp.write(c)>>TITLE.vbs
for /f "tokens=*" %%a in ('cscript /nologo TITLE.vbs') do set GAMEBOOT_TITLE=%%a
del TITLE.vbs>NUL

if %sel%== (goto CREATEPKG)
if "%GAMEBOOT_TITLE%"=="brunolee" echo c=msgbox("PKG creation canceled"^&chr(13)^&"Goodbye...","48","EXIT")>Info.vbs&Info.vbs&del Info.vbs>NUL&exit

set FOLDER=%CFW%-All-%GAMEBOOT_TITLE%
if not exist CGAMEBOOT\USRDIR\apps\GameBoots\"%FOLDER%" (goto COPYTOPKG) else echo c=msgbox("This name already exist"^&chr(13)^&"Give another name","48","GAMEBOOT NAME")>Info.vbs&Info.vbs&del Info.vbs>NUL&goto CREATEPKG


: COPYTOPKG
mkdir CGAMEBOOT\USRDIR\apps\GameBoots\"%FOLDER%"\PS3~dev_flash~vsh~resource
copy custom_render_plugin.rco CGAMEBOOT\USRDIR\apps\GameBoots\"%FOLDER%"\PS3~dev_flash~vsh~resource\custom_render_plugin.rco>NUL

echo set outp=wscript.stdout>QUEST_PKG.vbs
echo c=MsgBox("Create PKG now?",4,"CREATE PKG")>>QUEST_PKG.vbs
echo outp.write(c)>>QUEST_PKG.vbs
for /f "tokens=*" %%a in ('cscript QUEST_PKG.vbs') do set sel=%%a
del QUEST_PKG.vbs>NUL
if %sel%==6 (goto MAKEPKG)
if %sel%==7 (exit)


: MAKEPKG
if exist "package.conf" del "package.conf"
if exist "Custom GameBoots.pkg" del "Custom GameBoots.pkg"

echo ContentID = CFWPS3-CGAMEBOOT_00-0000000000000000>package.conf
echo Klicensee = 5061636B656442794272756E6F4C6565>>package.conf
echo DRMType = Free>>package.conf
echo ContentType = GameExec>>package.conf
echo PackageVersion = 01.00>>package.conf

Rcomage\psn_package_npdrm package.conf CGAMEBOOT>NUL
if exist "package.conf" del "package.conf"
ren CFWPS3-CGAMEBOOT_00-0000000000000000.pkg "Custom GameBoots.pkg"

if exist "Custom GameBoots.pkg" echo c=msgbox("PKG Custom GameBoots"^&chr(13)^&"successfully created!!","64","PKG Gammeboot INFO")>Info.vbs&Info.vbs&del Info.vbs>NUL
goto SELECTINSTALL
