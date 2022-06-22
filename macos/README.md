# Setup for macOS
## Special system preferences
### Change save location for screencaptures to Google Photo’s backup folder
1. Type the following command
```shell
$ mkdir ~/Google\ Photos
$ defaults write com.apple.screencapture location ~/Google\ Photos
$ killall SystemUIServer
```
2. Add or change target backup folder to `Google Photos` in Google Photos Backup app’s settings

You can now back up any screencaptures automatically to Google Photos.

<details><summary>Rollback</summary>

```shell
$ defaults delete com.apple.screencapture location
$ killall SystemUIServer
```
</details>

### Add "Quit Finder" to Finder.app menu bar
```shell
$ defaults write com.apple.Finder QuitMenuItem -boolean true
$ killall Finder
```

<details><summary>Rollback</summary>

```shell
$ defaults delete com.apple.Finder QuitMenuItem
$ killall Finder
```
</details>

### Do not create `.DS_Store` when using Finder.app
```shell
$ defaults write com.apple.desktopservices DSDontWriteNetworkStores True
$ killall Finder
```

<details><summary>Rollback</summary>

```shell
$ defaults write com.apple.desktopservices DSDontWriteNetworkStores False
$ killall Finder
```
</details>

### Disable clamshell mode for Mac notebook computer
In order to disable clamshell mode, you need to use [macOS Recovery](https://support.apple.com/en-us/HT201314).

1. Restart your Mac
2. Hold `⌘-R` until displaying the Apple logo
3. Open the Terminal app from the utility menu
4. Type the following command
```shell
$ nvram boot-args="niog=1"
```

<details><summary>Rollback</summary>

1. Same as the setup procedure 1-3
2. Type the following command
```shell
$ nvram -d boot-args
```
</details>

**NOTE**: This setting goes back after [resetting NVRAM or PRAM on your Mac](https://support.apple.com/en-us/HT204063).

**WARNING**: My Mac sometimes crashes and reboots after waking up when sleeping for a long time on my macOS environment. For details on my macOS environment, see `"system"` property in [Brewfile.lock.json](/Brewfile.lock.json).

### Disable acceleration on a mouse
1. Type the following command
```shell
$ defaults write .GlobalPreferences com.apple.mouse.scaling -1
```
2. Log out and back in, or restart your Mac

<details><summary>Rollback</summary>

1. Type the following command
```shell
$ defaults write .GlobalPreferences com.apple.mouse.scaling 1
```
2. Log out and back in, or restart your Mac
</details>

## Licensed applications list
The list of applications whose license should be activate or deactivate before you use or disuse the Mac computer.

- Alfred
- Bartender
- Lunar
- Witch

## Untracked applications
The following macOS applications (not chcked) have not been tracked in Homebrew Cask (`Brewfile` and `Brewfile.lock.json`) yet. These will be managed with Homebrew Cask in the future.

- [x] Google IME
- [x] 1Password 7
- [x] Alfred
- [x] Atom
- [x] Firefox
- [x] Google Chrome
- [ ] Google Drive File Stream
- [ ] Google Photos Backup
- [x] Karabiner-Elements
- [x] Karabiner-EventViewer
- [x] Keybase
- [x] KeyboardCleanTool
- [ ] Kindle
- [ ] Lunar
- [x] Scroll Reverser
- [ ] Shifty
- [x] Slack
- [x] Steam
- [ ] Tunnelblick
- [x] Visual Studio Code
- [x] zoom.us
