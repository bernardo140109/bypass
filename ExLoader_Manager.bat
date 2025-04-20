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

:: Backup dos arquivos antes de limpar
echo Criando backup dos arquivos...

:: Backup de logs
if exist "%USERPROFILE%\AppData\Roaming\ExLoader\logs\*.log" (
    xcopy /y "%USERPROFILE%\AppData\Roaming\ExLoader\logs\*.log" "%TEMP%\ExLoader_Backup\logs\" 2>nul
)

if exist "%USERPROFILE%\AppData\Local\ExLoader\*.log" (
    xcopy /y "%USERPROFILE%\AppData\Local\ExLoader\*.log" "%TEMP%\ExLoader_Backup\local_logs\" 2>nul
)

:: Backup de configurações
if exist "%USERPROFILE%\AppData\Roaming\ExLoader\config\*" (
    xcopy /y /e /i "%USERPROFILE%\AppData\Roaming\ExLoader\config\*" "%TEMP%\ExLoader_Backup\config\" 2>nul
)

:: Backup de pastas adicionais
if exist "C:\Luno\*" (
    xcopy /y /e /i "C:\Luno\*" "%TEMP%\ExLoader_Backup\Luno\" 2>nul
)

if exist "%USERPROFILE%\AppData\Roaming\ExHack\*" (
    xcopy /y /e /i "%USERPROFILE%\AppData\Roaming\ExHack\*" "%TEMP%\ExLoader_Backup\ExHack\" 2>nul
)

if exist "C:\en1gma-tech\*" (
    xcopy /y /e /i "C:\en1gma-tech\*" "%TEMP%\ExLoader_Backup\en1gma-tech\" 2>nul
)

if exist "C:\SharkHack\*" (
    xcopy /y /e /i "C:\SharkHack\*" "%TEMP%\ExLoader_Backup\SharkHack\" 2>nul
)

:: Limpar logs de execução
echo Limpando logs de execução...
del /f /q "%USERPROFILE%\AppData\Roaming\ExLoader\logs\*.log" 2>nul
del /f /q "%USERPROFILE%\AppData\Local\ExLoader\*.log" 2>nul

:: Remover pasta de configuração específica
echo Removendo configurações...
rmdir /s /q "%USERPROFILE%\AppData\Roaming\ExLoader\config" 2>nul

:: Remover pastas adicionais
echo Removendo pastas adicionais...
rmdir /s /q "C:\Luno" 2>nul
rmdir /s /q "%USERPROFILE%\AppData\Roaming\ExHack" 2>nul
rmdir /s /q "C:\en1gma-tech" 2>nul
rmdir /s /q "C:\SharkHack" 2>nul

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
echo Restaurando arquivos do backup...
echo.

:: Restaurar logs
if exist "%TEMP%\ExLoader_Backup\logs\*" (
    echo Restaurando logs...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\logs\*" "%USERPROFILE%\AppData\Roaming\ExLoader\logs\" 2>nul
)

if exist "%TEMP%\ExLoader_Backup\local_logs\*" (
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\local_logs\*" "%USERPROFILE%\AppData\Local\ExLoader\" 2>nul
)

:: Restaurar configurações
if exist "%TEMP%\ExLoader_Backup\config\*" (
    echo Restaurando configurações...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\config\*" "%USERPROFILE%\AppData\Roaming\ExLoader\config\" 2>nul
)

:: Restaurar pastas adicionais
if exist "%TEMP%\ExLoader_Backup\Luno\*" (
    echo Restaurando pasta Luno...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\Luno\*" "C:\Luno\" 2>nul
)

if exist "%TEMP%\ExLoader_Backup\ExHack\*" (
    echo Restaurando pasta ExHack...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\ExHack\*" "%USERPROFILE%\AppData\Roaming\ExHack\" 2>nul
)

if exist "%TEMP%\ExLoader_Backup\en1gma-tech\*" (
    echo Restaurando pasta en1gma-tech...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\en1gma-tech\*" "C:\en1gma-tech\" 2>nul
)

if exist "%TEMP%\ExLoader_Backup\SharkHack\*" (
    echo Restaurando pasta SharkHack...
    xcopy /y /e /i "%TEMP%\ExLoader_Backup\SharkHack\*" "C:\SharkHack\" 2>nul
)

echo.
echo Restauração concluída com sucesso!
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