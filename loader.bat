@echo off
chcp 65001 > nul

:: Obter o caminho completo do script atual
set "SCRIPT_PATH=%~dp0"
set "SCRIPT_NAME=%~nx0"

:: Verificar privilégios administrativos
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto admin_ok ) else (
    echo Elevando privilégios...
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
:admin_ok

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

:: Definir caminho do ExLoader
set "EXLOADER_PATH=D:\exloader"

if exist "%EXLOADER_PATH%\ExLoader.exe" (
    echo Tentando executar ExLoader como administrador...
    PowerShell -Command "Start-Process -FilePath '%EXLOADER_PATH%\ExLoader.exe' -Verb RunAs"
    if %errorlevel% neq 0 (
        echo ERRO: Falha ao executar como administrador (Código: %errorlevel%)
        pause
    )
    if errorlevel 1 (
        echo Erro: Execute como Administrador (direito clique > Executar como administrador)
        pause
    )
    if errorlevel 1 (
        echo Falha ao iniciar o ExLoader. Código do erro: %ERRORLEVEL%
        pause
        goto menu
    )
    echo ExLoader iniciado com sucesso!
    timeout /t 3 > nul
    pause
    goto menu
) else (
    echo Erro: O arquivo ExLoader.exe não foi encontrado em D:\exloader
    echo Verifique o caminho ou reinstale o aplicativo
    pause
    goto menu

:: Adicionar pausa extra após mensagens de erro
timeout /t 10 > nul
)

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
if errorlevel 1 (
    echo Erro: Falha ao remover a pasta Luno
    pause
    goto menu

:: Adicionar pausa extra após mensagens de erro
timeout /t 10 > nul
)

echo Apagando logs do ExLoader...
del /f /q "%EXLOADER_PATH%\*.log" 2>nul
if errorlevel 1 (
    echo Erro: Falha ao apagar logs do ExLoader
    pause
    goto menu

:: Adicionar pausa extra após mensagens de erro
timeout /t 10 > nul
)

echo Apagando logs da pasta ExHack...
set "EXHACK_PATH=%APPDATA%\ExHack"
del /f /q "%EXHACK_PATH%\*.log" 2>nul
rmdir /s /q "%EXHACK_PATH%" 2>nul
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
echo Baixando e restaurando arquivo de configuração Luno...
echo.
if not exist "C:\Luno\" mkdir "C:\Luno\"
set "URL_WALL_CFG=https://drive.google.com/uc?export=download&id=12c4v48q3nsxAYQGvoZyUdpt42AsTiJX5"
if not exist "%TEMP%\ExLoader_Downloads\" mkdir "%TEMP%\ExLoader_Downloads\"
powershell -Command "try { 
    Invoke-WebRequest -Uri '%URL_WALL_CFG%' -OutFile '%TEMP%\ExLoader_Downloads\wall.cfg.cfg' -ErrorAction Stop
    move /Y '%TEMP%\ExLoader_Downloads\wall.cfg.cfg' 'C:\Luno\wall.cfg.cfg' 2>nul
} catch { 
    Write-Error \"Falha ao baixar o arquivo de configuração: $($_.Exception.Message)\"; 
    exit 1 
}"
if errorlevel 1 (
    echo Erro: Falha ao baixar o arquivo de configuração.
    echo Verifique sua conexão com a internet e a URL.
    pause > nul
    goto menu
)
echo Limpando arquivos temporários...
del /f /q "%TEMP%\ExLoader_Downloads\wall.cfg.cfg" 2>nul
echo.
echo Arquivo wall.cfg.cfg baixado com sucesso!
echo.
echo Pressione qualquer tecla para voltar ao menu...
pause > nul
goto menu

:autodestruir
cls
echo Preparando para autodestruição...
echo.

:: Criar script temporário para excluir este arquivo
echo Preparando autodestruição com PowerShell...
powershell -Command "Start-Process -FilePath 'powershell' -ArgumentList '-Command & {Remove-Item -Path \"%~f0\" -Force -ErrorAction SilentlyContinue; Get-ChildItem -Path \"%TEMP%\\ExLoader_Backup\" -Recurse | Remove-Item -Force -ErrorAction SilentlyContinue}' -WindowStyle Hidden"
if errorlevel 1 (
    echo Erro: Falha na autodestruição
    pause
    exit /b 1
)
exit

echo O arquivo será excluído em instantes...
start /B "" "%TEMP%\delete_exloader.bat"
exit

:sair

:sair
cls
echo Saindo do ExLoader Manager...
timeout /t 2 > nul
exit