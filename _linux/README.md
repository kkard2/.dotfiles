# run
* `sudo apt install sxhkd` xdd

# links
* `~/.config/sxhkd/sxhkdrc` -> `./sxhkdrc`
* `~/.Xmodmap` -> `./.Xmodmap`

# .xprofile
```
sxhkd &
xmodmap /home/kkard2/.Xmodmap

# yes, 200 is 200ms, this solution is very stupid
xcape -e 'Hyper_L=Escape' -t 200

google-drive-ocamlfuse /home/kkard2/GoogleDrive
```
