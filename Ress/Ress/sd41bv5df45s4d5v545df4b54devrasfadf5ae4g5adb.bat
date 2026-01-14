@echo off
chcp 65001 >nul
title RESS - Seu painel util
color 0C

:: ================= MENU PRINCIPAL =================
:menu
cls
echo.
echo  ███████████████████████████████████████████████
echo  █                                             █
echo  █   ██████╗ ███████╗███████╗███████╗          █
echo  █   ██╔══██╗██╔════╝██╔════╝██╔════╝          █
echo  █   ██████╔╝█████╗  ███████╗███████╗          █
echo  █   ██╔══██╗██╔══╝  ╚════██║╚════██║          █
echo  █   ██║  ██║███████╗███████║███████║          █
echo  █   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝          █
echo  █                                             █
echo  █        Seu painel util • por Thomas         █
echo  █                                             █
echo  ███████████████████████████████████████████████
echo.
echo  ┌───────────────────────────────────────────┐
echo  │  [1] 🌐 Rede e Internet                    │
echo  │  [2] 🖥️  Informacoes do Computador          │
echo  │  [3] 🧹 Limpeza e Manutencao                │
echo  │  [4] 🛠️  Ferramentas do Windows             │
echo  │  [5] 📄 Relatorio do Sistema                │
echo  │  [6] ⚡ Utilidades do Dia a Dia             │
echo  │  [7] 📊 Monitoramento em Tempo Real         │
echo  │                                           │
echo  │  [0] ❌ Sair                                │
echo  └───────────────────────────────────────────┘
echo.

choice /c 12345670 /n /m "Escolha:"
set op=%errorlevel%

if %op%==1 goto rede
if %op%==2 goto pc
if %op%==3 goto limpeza
if %op%==4 goto ferramentas
if %op%==5 goto relatorio
if %op%==6 goto utilidades
if %op%==7 goto monitor
if %op%==8 exit
goto menu

:: ================= MONITORAMENTO =================
:monitor
cls
color 0A
title RESS - Monitoramento em Tempo Real

:monitor_loop
cls
echo  ╔════════════ 📊 MONITORAMENTO EM TEMPO REAL ════════════╗
echo  ║   Pressione Q para voltar ao menu                     ║
echo  ╚══════════════════════════════════════════════════════╝
echo.

:: CPU
echo  🔥 PROCESSADOR (Uso):
wmic cpu get loadpercentage
echo.

:: MEMORIA
setlocal enabledelayedexpansion
for /f "skip=1 tokens=1,2" %%a in ('wmic OS get FreePhysicalMemory^,TotalVisibleMemorySize') do (
    set free=%%a
    set total=%%b
)
set /a used=(total-free)/1024
set /a totalmb=total/1024
echo  🧠 MEMORIA RAM:
echo     Usada : !used! MB
echo     Total : !totalmb! MB
endlocal
echo.

:: DISCO
echo  💾 DISCO C:
wmic logicaldisk where DeviceID="C:" get FreeSpace,Size
echo.

:: REDE
echo  🌐 REDE (Pacotes):
netstat -e
echo.

echo  Atualizando a cada 3 segundos...
choice /c QN /n /t 3 /d N >nul
if errorlevel 2 goto monitor_loop
if errorlevel 1 goto menu

:: ================= REDE =================
:rede
cls
color 0C
echo  ╔════════════ 🌐 REDE E INTERNET ═════════════╗
echo.
echo [1] Mostrar IPv4
echo [2] Informacoes completas
echo [3] Testar conexao
echo [4] Limpar cache DNS
echo [5] Conexoes ativas
echo [6] Status do Wi-Fi
echo.
echo [0] Voltar
echo.

choice /c 1234560 /n /m "Opcao:"
set r=%errorlevel%

if %r%==1 ipconfig | findstr IPv4 & pause
if %r%==2 ipconfig /all & pause
if %r%==3 ping -n 4 8.8.8.8 & pause
if %r%==4 ipconfig /flushdns & pause
if %r%==5 netstat -an & pause
if %r%==6 netsh wlan show interfaces & pause
if %r%==7 goto menu
goto rede

:: ================= PC =================
:pc
cls
color 0B
echo  ╔══════════ 🖥️  INFORMACOES DO COMPUTADOR ══════════╗
echo.
whoami
hostname
ver
echo.
wmic cpu get name
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize
wmic path win32_VideoController get name
wmic logicaldisk where DeviceID="C:" get Size,FreeSpace
pause
goto menu

:: ================= LIMPEZA =================
:limpeza
cls
color 0E
echo  ╔══════════ 🧹 LIMPEZA E MANUTENCAO ══════════╗
echo.
echo [1] Temporarios usuario
echo [2] Temporarios Windows
echo [3] Limpar DNS
echo [4] Limpar lixeira
echo.
echo [0] Voltar
echo.

choice /c 12340 /n /m "Opcao:"
set l=%errorlevel%

if %l%==1 del /s /q "%temp%\*" 2>nul & pause
if %l%==2 del /s /q "C:\Windows\Temp\*" 2>nul & pause
if %l%==3 ipconfig /flushdns & pause
if %l%==4 rd /s /q C:\$Recycle.Bin & pause
if %l%==5 goto menu
goto limpeza

:: ================= FERRAMENTAS =================
:ferramentas
cls
color 09
echo  ╔══════════ 🛠️  FERRAMENTAS DO WINDOWS ══════════╗
echo.
echo [1] Painel de Controle
echo [2] Configuracoes
echo [3] Gerenciador de Tarefas
echo [4] Prompt de Comando
echo [5] Explorador
echo [6] Informacoes do Sistema
echo.
echo [0] Voltar
echo.

choice /c 1234560 /n /m "Opcao:"
set f=%errorlevel%

if %f%==1 control
if %f%==2 start ms-settings:
if %f%==3 taskmgr
if %f%==4 start cmd
if %f%==5 explorer
if %f%==6 msinfo32
if %f%==7 goto menu
goto ferramentas

:: ================= UTILIDADES =================
:utilidades
cls
color 0A
echo  ╔══════════ ⚡ UTILIDADES DO DIA A DIA ══════════╗
echo.
echo [1] Status da bateria
echo [2] Antivírus ativo
echo [3] Erros recentes
echo.
echo [0] Voltar
echo.

choice /c 1230 /n /m "Opcao:"
set u=%errorlevel%

if %u%==1 powercfg /batteryreport & start battery-report.html & pause
if %u%==2 wmic /namespace:\\root\SecurityCenter2 path AntiVirusProduct get displayName,productState & pause
if %u%==3 wevtutil qe System /c:10 /f:text & pause
if %u%==4 goto menu
goto utilidades

:: ================= RELATORIO =================
:relatorio
cls
color 07
echo Gerando relatorio...
systeminfo > relatorio_ress.txt
ipconfig /all >> relatorio_ress.txt
wmic cpu get name >> relatorio_ress.txt
wmic logicaldisk get size,freespace >> relatorio_ress.txt
echo Relatorio criado!
pause
goto menu