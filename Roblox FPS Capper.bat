@echo off

title Roblox FPS Unlocker

echo.
echo ------------------------------
echo Roblox FPS Unlocker
echo.
echo made by chiiicken#3436
echo ------------------------------
echo.

tasklist /fi "ImageName eq RobloxPlayerBeta.exe" /fo csv 2>NUL | find /I "RobloxPlayerBeta.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo.
    echo [INFO] We detected that your Roblox Client is running right now.
    echo [Info] However this is not a problem. Just make sure to restart your Roblox after you have set your FPS Cap.
    echo.
    echo.
)

echo Please enter the new FPS Cap (number)
set /p "fpscap=FPS CAP: "

echo.
echo.


Set "value=" & For /F Delims^=^ EOL^= %%G In ('%SystemRoot%\System32\curl.exe -s "http://setup.roblox.com/version"') Do (Set "value=%%G" & SetLocal EnableDelayedExpansion & For /F Delims^=^"^= %%H In ("!value:* value=!") Do EndLocal & Set "value=%%H")

echo [0/3] Fetching Roblox version...

If Defined value (
    echo [1/3] Fetched Roblox Version: %value%
    if exist "%localappdata%/Roblox/Versions/%value%/" (
        cd "%localappdata%/Roblox/Versions/%value%/"
        
        if exist "ClientSettings/" (
            echo [2/3] Settings folder already exists. Skipping..
        ) else (
            mkdir "ClientSettings"
            echo [2/3] Successfully created Settings folder
        )

        echo [2/3] Overriding Client Settings...
        cd "ClientSettings" 
        echo { "DFIntTaskSchedulerTargetFps": %fpscap% } > "ClientAppSettings.json"
        echo [3/3] Successfully overriden local Roblox Client Settings File!
        echo.
        echo.
        echo [Success] Your FPS Cap has been set to %fpscap%! 
        echo [Success] Please restart your game to see the changes.
        pause
    ) else (

        echo. && echo. && echo.
        echo [FAILED] Failed to find your Roblox Version Folder!
        echo [FAILED] I will manually fetch your Roblox path now... 

        timeout 2 >NUL
            
        echo. && echo /// Attempting second fetching Method \\

        for /f "delims=" %%D in ('dir "%localappdata%/Roblox/Versions" /B') do (

            echo.
            echo.
            echo %%D
            echo [Backup Method] Caught new Roblox path: %%D && echo [Backup Method] Attempting settings override...

            cd "%localappdata%/Roblox/Versions/%%D/"
            
            if exist "ClientSettings/" (
                echo.
            ) else (
                mkdir "ClientSettings"
            )

            cd "ClientSettings" 
            echo { "DFIntTaskSchedulerTargetFps": %fpscap% } > "ClientAppSettings.json"
            echo [Backup Method] [Success] Settingsfile in %%D has been overriden. New value: %fpscap%! 
        )

            echo.
            echo.
            echo [Backup Method] [FINISH] Your Roblox FPS Cap has been set to %fpscap%.
            echo [Backup Method] [FINISH] If you still see no changes in your Game, please make sure to update your Game Client.



            timeout 1 >nul

            cls  

            echo [Backup Method] [FINISH] Your Roblox FPS Cap has been set to %fpscap%.
            echo [Backup Method] [FINISH] If you still see no changes in your Game, please make sure to update your Game Client.
            echo.
            echo [Backup Method] [FINISH] Press any key to exit. 

            pause >nul
    )

) else (
    echo [FAILED] Invalid response from the Roblox API! Please try again later.. 
    pause
)
