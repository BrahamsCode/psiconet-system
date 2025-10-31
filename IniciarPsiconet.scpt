#!/usr/bin/osascript

# Script de AppleScript para iniciar Psiconet Sistema

tell application "Terminal"
    do script "cd '" & (do shell script "dirname " & quoted form of POSIX path of (path to me)) & "' && ./start.sh"
    activate
end tell
