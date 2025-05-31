1. Open VScode settings
2. Search for `terminal.integrated.profile.windows`
3. Edit in settings.json
4. Inside `terminal.integrated.profiles.windows` add
   ```
   "Laragon": {
     "path": "${env:windir}\\System32\\cmd.exe",
     "args": ["/k", "<extracted-laragon-path>\\bin\\cmder\\vendor\\bin\\vscode_init.cmd"]
   },
   ```
   Example:
   ```
   "terminal.integrated.profiles.windows": {
        "Laragon": {
            "path": "${env:windir}\\System32\\cmd.exe",
            "args": ["/k", "C:\\laragon\\bin\\cmder\\vendor\\bin\\vscode_init.cmd"]
        },
   ...
   ...
   }
   ```
