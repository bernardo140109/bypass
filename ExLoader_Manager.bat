@echo off
chcp 65001 > nul
color 0A
cls

title ExLoader Manager

:: Criar pasta de backup se não existir
if not exist "%TEMP%\ExLoader_Backup\" mkdir "%TEMP%\ExLoader_Backup\"

:menu
cls
echo ===================================
echo         ExLoader Manager
echo ===================================
echo.
echo 1 - Abrir ExLoader (D:\exloader)
echo 2 - Bypass (Limpar logs e configs)
echo 3 - Restaurar arquivos
echo 4 - Sair
echo.
echo ===================================
echo.

choice /c 1234 /n /m "Escolha uma opção (1-4): "

if errorlevel 4 goto sair
if errorlevel 3 goto restaurar
if errorlevel 2 goto bypass
if errorlevel 1 goto abrir_d

:abrir_d
cls
echo Abrindo ExLoader (D:\exloader)...
echo.

start "" "D:\exloader\ExLoader.exe"

echo ExLoader iniciado com sucesso!
timeout /t 3 > nul
goto menu

:bypass
cls
echo Executando bypass...
echo.

echo Criando backup da pasta Luno...
if exist "C:\Luno\*" (
    xcopy /y /e /i "C:\Luno\*" "%TEMP%\ExLoader_Backup\Luno\" 2>nul
)

echo Removendo pasta Luno...
rmdir /s /q "C:\Luno" 2>nul

echo Apagando logs do ExLoader...
del /f /q "D:\exloader\*.log" 2>nul

echo Apagando logs da pasta ExHack...
del /f /q "C:\Users\berna\AppData\Roaming\ExHack\*.log" 2>nul
rmdir /s /q "C:\Users\berna\AppData\Roaming\ExHack" 2>nul
echo.
echo Bypass concluído com sucesso!
echo.
echo 1 - Voltar ao menu
echo 2 - Autodestruir este arquivo e sair
echo.
choice /c 12 /n /m "Escolha uma opção (1-2): "

if errorlevel 2 goto autodestruir
if errorlevel 1 goto menu

:restaurar
cls
echo ===================================
echo      Restauração de Arquivos
echo ===================================
echo.
echo 1 - Restaurar do backup local
echo 2 - Baixar e restaurar pasta Luno online
echo 3 - Voltar ao menu
echo.
echo ===================================
echo.

choice /c 123 /n /m "Escolha uma opção (1-3): "

if errorlevel 3 goto menu
if errorlevel 2 goto restaurar_online
if errorlevel 1 goto restaurar_local

:restaurar_local
cls
echo Restaurando pasta Luno do backup local...
echo.
if exist "%TEMP%\ExLoader_Backup\Luno\*" (
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\Luno\*" "C:\Luno\" 2>nul
)
echo.
echo Restauração local concluída com sucesso!
echo.
echo Pressione qualquer tecla para voltar ao menu...
pause > nul
goto menu

:restaurar_online
cls
echo Baixando e restaurando pasta Luno online...
echo.
set "URL_LUNO=https://github.com/bernardo140109/bypass/raw/refs/heads/main/Luno.zip"
if not exist "%TEMP%\ExLoader_Downloads\" mkdir "%TEMP%\ExLoader_Downloads\"
powershell -Command "& {Invoke-WebRequest -Uri '%URL_LUNO%' -OutFile '%TEMP%\ExLoader_Downloads\Luno.zip'}"
echo Extraindo pasta Luno...
powershell -Command "& {Expand-Archive -Path '%TEMP%\ExLoader_Downloads\Luno.zip' -DestinationPath 'C:\Luno\' -Force}"
echo Limpando arquivos temporários...
del /f /q "%TEMP%\ExLoader_Downloads\Luno.zip" 2>nul
echo.
echo Restauração online concluída com sucesso!
echo.
echo Pressione qualquer tecla para voltar ao menu...
pause > nul
goto menu

:autodestruir
cls
echo Preparando para autodestruição...
echo.

:: Criar script temporário para excluir este arquivo
echo @echo off > "%TEMP%\delete_exloader.bat"
echo timeout /t 2 > nul >> "%TEMP%\delete_exloader.bat"
echo del /f /q "%~f0" >> "%TEMP%\delete_exloader.bat"
echo rmdir /s /q "%TEMP%\ExLoader_Backup" >> "%TEMP%\delete_exloader.bat"
echo exit >> "%TEMP%\delete_exloader.bat"

echo O arquivo será excluído em instantes...
start /min "" "%TEMP%\delete_exloader.bat"
exit

:sair
cls
echo Saindo do ExLoader Manager...
timeout /t 2 > nul
exit