# Setup for macOS
## Resident application
- [Lunar](https://lunar.fyi)
- [Shifty](https://shifty.natethompson.io/en/)
- [Amphetamine](https://apps.apple.com/jp/app/amphetamine/id937984704)
- [Karabiner-Elements](https://karabiner-elements.pqrs.org)
- [BetterSnapTool](https://apps.apple.com/jp/app/bettersnaptool/id417375580)
- [Google IME](https://www.google.co.jp/ime/)
- [Google Drive File Stream](https://support.google.com/drive/answer/7329379)
- [Google Photos Backup](https://photos.google.com/apps)
- [Scroll Reverser](https://pilotmoon.com/scrollreverser/)

## Homebrew packages
TBA

## Special system preferences
### Change save location for screencaptures
```bash
$ defaults write com.apple.screencapture location <SAVE_LOCATION_PATH>
$ killall SystemUIServer
```

#### Rollback
```bash
$ defaults delete com.apple.screencapture location
$ killall SystemUIServer
```

### Add "Quit Finder" to Finder.app menu bar
```bash
$ defaults write com.apple.Finder QuitMenuItem -boolean true
$ killall Finder
```

#### Rollback
```bash
$ defaults delete com.apple.Finder QuitMenuItem
$ killall Finder
```

### Disable clamshell mode for Mac notebook computer
In order to disable clamshell mode, you need to use [macOS Recovery](https://support.apple.com/en-us/HT201314).

1. Restart your Mac
2. Hold `⌘-R` until displaying the Apple logo
3. Open the Terminal app from the utility menu
4. Type the following command
```bash
$ nvram boot-args="niog=1"
```

**NOTE**: This setting goes back after [resetting NVRAM or PRAM on your Mac](https://support.apple.com/en-us/HT204063).

### Disable acceleration on a mouse
1. Type the following command
```bash
$ defaults write .GlobalPreferences com.apple.mouse.scaling -1
```
2. Log out and back in, or restart your Mac

#### Rollback
1. Type the following command
```bash
$ defaults write .GlobalPreferences com.apple.mouse.scaling 1
```
2. Log out and back in, or restart your Mac
