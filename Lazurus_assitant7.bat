@echo off

:: Lazarus Assistant - customized for Aarya Kattal

:: Setup
setlocal EnableDelayedExpansion

:: Maximize console window
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $h = Get-Process -Id $PID; $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $hwnd = (Get-Process -Id $PID).MainWindowHandle; $null = Add-Type -MemberDefinition '[DllImport(\"user32.dll\")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);' -Name 'WinAPI' -Namespace 'Native'; [Native.WinAPI]::MoveWindow($hwnd, 0, 0, $screen.Width, $screen.Height, $true)}"

:: ANSI Colors
for /F "delims=#" %%a in ('"prompt #$E# & for %%a in (1) do rem"') do set "ESC=%%a"
set "DARK=%ESC%[38;5;238m"
set "BLUE=%ESC%[38;5;33m"
set "CYAN=%ESC%[38;5;51m"
set "GREEN=%ESC%[38;5;84m"
set "WHITE=%ESC%[97m"
set "RED=%ESC%[91m"
set "RESET=%ESC%[0m"

:: User Information
set "user_name=Aarya Kattal"
set "birthday=May 1, 2011"
set "password=NEILGOTNOHUZZ1234"
set "love_quote=Chutti sirf kaam se nahi hoti, kabhi kabhi zindagi jeene ke liye bhi leni padti hai"

:: Personality Greeting
set AI_Trait[1]=Efficient and ready to execute, Aarya.
set AI_Trait[2]=Professional mode active. Awaiting your command.
set AI_Trait[3]=System aligned. What’s the task today?
set AI_Trait[4]=Greetings, sir. Ready to conquer the checklist.
set AI_Trait[5]=Hello Aarya. Efficiency protocol engaged.
set /a rand=%random% %% 5 + 1
call set greeting=%%AI_Trait[%rand%]%%

:: Password Screen
:password
cls
echo %DARK%****************************************
echo %DARK%*                                      *
echo %DARK%*      %WHITE%L A Z A R U S   A I %DARK%         *
echo %DARK%*   %CYAN%Secure Terminal Access%DARK%            *
echo %DARK%*                                      *
echo %DARK%****************************************%RESET%
echo.
set /p "pass=%GREEN%Enter access key:%RESET% "
if not "%pass%"=="%password%" (
    echo %RED%  ⚠ Invalid key. Try again.%RESET%
    timeout /t 1 >nul
    goto password
)

:: Main Menu
:home
cls
for /f %%i in ('powershell -Command "Get-Date -Format \"dddd, MMMM dd yyyy - hh:mm tt\""') do set datetime=%%i
for /f "tokens=2 delims=:" %%i in ('netsh wlan show interfaces ^| findstr /i "SSID" ^| findstr /v "BSSID"') do set "wifi=%%i"
set wifi=%wifi:~1%
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining /value ^| find "="') do set batt_level=%%a
for /f "tokens=2 delims==" %%b in ('wmic path Win32_Battery get EstimatedRunTime /value ^| find "="') do set batt_time=%%b
if "%batt_level%"=="" set batt_level=Unknown
if "%batt_time%"=="" (
    set batt_time=Unknown
) else (
    set /a batt_hours=%batt_time% / 60
    set /a batt_minutes=%batt_time% %% 60
    set batt_time=%batt_hours%h %batt_minutes%m
)
echo %DARK%****************************************
echo %DARK%*  %WHITE%LAZARUS ASSISTANT %GREEN%(v5.0) %BLUE%▲%DARK%           *
echo %DARK%****************************************
echo %DARK%*  %CYAN%Date:%WHITE% %datetime%%DARK%
echo %DARK%*  %CYAN%Wi-Fi:%WHITE% %wifi%%DARK%
echo %DARK%*  %CYAN%Battery:%WHITE% %batt_level%%%DARK%  %CYAN%Est Time:%WHITE% %batt_time%%DARK%
echo %DARK%*  %CYAN%User:%WHITE% %user_name%%DARK%
echo %DARK%*  %CYAN%Birthday:%WHITE% %birthday%%DARK%
echo %DARK%*  %CYAN%[Daily Quote]%DARK%
echo %DARK%*  %GREEN%%love_quote%%DARK%
echo %DARK%*                                      *
echo %DARK%*  %WHITE%%greeting%%DARK%
echo %DARK%*                                      *
echo %DARK%*  %WHITE%1. Open websites                   %DARK%*
echo %DARK%*  %WHITE%2. Initiate project study          %DARK%*
echo %DARK%*  %WHITE%3. Games                            %DARK%*
echo %DARK%*  %WHITE%4. View Update Log                 %DARK%*
echo %DARK%*  %WHITE%5. Initiate Exam Mode               %DARK%*
echo %DARK%*  %WHITE%6. Exit                             %DARK%*
echo %DARK%*  %WHITE%7. Chatbot                         %DARK%*
echo %DARK%****************************************%RESET%
echo.
powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('%greeting%')"
choice /c 1234567 /n /m "%BLUE%Choose:%RESET% "
if errorlevel 7 goto python_chatbot
if errorlevel 6 goto goodbye
if errorlevel 5 goto exam_mode
if errorlevel 4 goto changelog
if errorlevel 3 goto games
if errorlevel 2 goto study
if errorlevel 1 goto openweb

:openweb
cls
echo %DARK%****************************************
echo %DARK%*  %WHITE%WEBSITE LAUNCHER %GREEN»%DARK%                   *
echo %DARK%****************************************%RESET%
echo %CYAN%  Just type the domain (e.g. google.com)%RESET%
echo.
set /p "howmany=Open one or multiple sites? (one/multi): "
if /i "%howmany%"=="one" (
    set /p "url=› Enter website: "
    setlocal enabledelayedexpansion
    set "entered_url=!url!"
    if "!entered_url:~0,7!"=="http://" (
        set "final_url=!entered_url!"
    ) else if "!entered_url:~0,8!"=="https://" (
        set "final_url=!entered_url!"
    ) else (
        set "final_url=https://!entered_url!"
    )
    start chrome.exe --new-window "!final_url!"
    endlocal
    goto home
)
if /i "%howmany%"=="multi" (
    setlocal enabledelayedexpansion
    set /p "count=How many sites to open?: "
    set "url_args="
    for /l %%i in (1,1,!count!) do (
        set /p "site%%i=Site %%i: "
        set "url_input=!site%%i!"
        if "!url_input:~0,7!"=="http://" (
            set "fixed_url=!url_input!"
        ) else if "!url_input:~0,8!"=="https://" (
            set "fixed_url=!url_input!"
        ) else (
            set "fixed_url=https://!url_input!"
        )
        set "url_args=!url_args! !fixed_url!"
    )
    if defined url_args (
        start chrome.exe !url_args!
    )
    endlocal
    goto home
)
echo %RED%Invalid choice. Type 'one' or 'multi'%RESET%
timeout /t 2 >nul
goto openweb

:study
cls
echo %DARK%********* STUDY MODE *********%RESET%
echo Launching your study apps in Chrome...
start chrome.exe https://open.spotify.com
start chrome.exe https://teams.microsoft.com
start chrome.exe https://mail.google.com
start chrome.exe https://chat.openai.com
powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('All set for study mode, Aarya.')"
timeout /t 3 >nul
goto home

:games
cls
echo %DARK%****************************************
echo %DARK%*            %WHITE%GAMES MENU%GREEN%                *
echo %DARK%****************************************%RESET%
echo %WHITE%1.%CYAN% Guess the Number
echo %WHITE%2.%CYAN% Rock, Paper, Scissors
echo %WHITE%3.%RED% Back to Main Menu
echo.
choice /c 123 /n /m "%BLUE%Choose a game:%RESET% "
if errorlevel 3 goto home
if errorlevel 2 goto rps_game
if errorlevel 1 goto guess_number

:guess_number
cls
setlocal enabledelayedexpansion
set /a target=%random% %% 100 + 1
set tries=0
echo %CYAN%I have selected a number between 1 and 100. Try to guess it!
:guess_loop
set /p "guess=Your guess: "
set /a tries+=1
if "%guess%"=="%target%" (
    echo %GREEN%Correct! You guessed it in %tries% tries.%RESET%
    pause
    endlocal
    goto games
)
if %guess% gtr %target% (
    echo Too high! Try again.
) else (
    echo Too low! Try again.
)
goto guess_loop

:rps_game
cls
setlocal enabledelayedexpansion
echo %CYAN%Let's play Rock, Paper, Scissors! Type your choice:
echo %WHITE% (r)ock, (p)aper, or (s)cissors
set /p user_choice=Your choice:
set user_choice=!user_choice:~0,1!
set /a comp_choice=%random% %% 3
if %comp_choice%==0 set comp=rock
if %comp_choice%==1 set comp=paper
if %comp_choice%==2 set comp=scissors

echo Computer chose: %comp%

if "!user_choice!"=="r" (
    if "%comp%"=="rock" (
        echo It's a tie! Both picked rock. Snooze fest.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Tie game. Try harder.')"
    )
    if "%comp%"=="paper" (
        echo You lose! Paper covers rock. Try again.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You lose. Better luck next time.')"
    )
    if "%comp%"=="scissors" (
        echo You win! Don’t let it get to your head.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You win. Lucky shot.')"
    )
) else if "!user_choice!"=="p" (
    if "%comp%"=="rock" (
        echo You win! Paper covers rock. That’s how it works.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You win. Well played.')"
    )
    if "%comp%"=="paper" (
        echo It's a tie! Both picked paper. Snooze fest.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Tie game. Try harder.')"
    )
    if "%comp%"=="scissors" (
        echo You lose! Scissors cut paper. Ouch.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You lose. Try again.')"
    )
) else if "!user_choice!"=="s" (
    if "%comp%"=="rock" (
        echo You lose! Rock crushes scissors. Brutal.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You lose. Better luck next time.')"
    )
    if "%comp%"=="paper" (
        echo You win! Scissors cut paper. Sharp thinking.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('You win. Nicely done.')"
    )
    if "%comp%"=="scissors" (
        echo It's a tie! Scissors meet scissors. Stalemate.
        powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Tie game. Try harder.')"
    )
) else (
    echo Invalid choice. Try r, p, or s.
    powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Invalid choice. Try again.')"
)
pause
endlocal
goto games

:exam_mode
cls
echo %RED%*******************************************************************%RESET%
echo %RED%* WARNING: Initiating Exam Mode will close selected apps. Make sure  *%RESET%
echo %RED%* you have saved all work!                                           *%RESET%
echo %RED%*******************************************************************%RESET%
echo.
set /p "confirm=Type YES to confirm and continue: "
if /i not "%confirm%"=="YES" (
    echo %RED%Exam Mode cancelled.%RESET%
    timeout /t 2 >nul
    goto home
)

:exam_pass
cls
set /p "epass=Enter your password to proceed: "
if not "%epass%"=="%password%" (
    echo %RED%Incorrect password.%RESET%
    timeout /t 2 >nul
    goto exam_pass
)

:: Get list of visible app windows (processname|title)
echo.
echo %CYAN%Listing visible applications with windows:%RESET%
for /f "tokens=1,* delims=|" %%A in ('powershell -NoProfile -Command ^
    "Get-Process | Where-Object { $_.MainWindowTitle } | ForEach-Object { ($_.ProcessName + '|' + $_.MainWindowTitle) }"') do (
    echo  %%A - %%B
)

echo.
set /p "apps=Type process names to close (separate with spaces), or leave empty to skip: "
if "%apps%"=="" (
    echo No applications selected to close.
) else (
    for %%p in (%apps%) do (
        echo Closing %%p ...
        taskkill /IM %%p.exe /F >nul 2>&1
        if /I "%%p"=="chrome" (
            :: Wait for chrome to fully close
            :wait_chrome
            tasklist /FI "IMAGENAME eq chrome.exe" | find /I "chrome.exe" >nul
            if not errorlevel 1 (
                timeout /t 1 >nul
                goto wait_chrome
            )
        )
    )
)

echo.
echo %GREEN%Done. Exam Mode activated.%RESET%
timeout /t 3 >nul
goto home

:changelog
cls
echo %DARK%****************************************
echo %DARK%*         %WHITE%UPDATE LOG - LAZARUS ASSISTANT%DARK%       *
echo %DARK%****************************************%RESET%
echo.
echo %CYAN%[June 24, 2025] – v5.0%RESET%
echo   - Fully customized for Aarya Kattal
echo   - Opens study apps in Chrome (Spotify, Teams, Gmail, ChatGPT)
echo   - Added file upload & summarize feature
echo   - Games menu and exam mode improvements
echo.
pause
goto home

:python_chatbot
cls
echo %DARK%********* Starting Lazurus Chatbot *********%RESET%
python "Lazurus_chatbot_FIXED.py"
pause
goto home

:goodbye
powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Goodbye %user_name%. Have a great day.')"
echo %DARK%****************************************
echo %DARK%*  %CYAN%Session terminated. Goodbye!%DARK%       *
echo %DARK%****************************************%RESET%
timeout /t 2 >nul
exit