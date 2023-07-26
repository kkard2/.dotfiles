# .dotfiles
config stuff (i need to move everything into one place)

# running
* run `./espanso/update_from_assets.py`

# links
* `~/.ideavimrc` -> `./idea/.ideavimrc`
* `$XDG_CONFIG_HOME/espanso` -> `./espanso`
* `./espanso/assets` -> `<ASSET_DIR>` (asset dir is sth that syncs media)
* `$XDG_CONFIG_HOME/nvim` -> `./nvim`

# other config
* `~/.gitconfig`
```
[include]
        path = <repo>/global_gitconfig
```
DO NOT SYMLINK PLEASE

# windows
* run `./_windows/startup.ps1` on startup (`PowerShell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File <PATH>`)

# linux gigachad
* `sudo apt install sxhkd` xdd
* `~/.config/sxhkd/sxhkdrc` -> `./_linux/sxhkdrc`
