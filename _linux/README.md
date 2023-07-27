# run
* `sudo apt install sxhkd` xdd

# links
* `~/.config/sxhkd/sxhkdrc` -> `./sxhkdrc`
* `~/.Xmodmap` -> `./.Xmodmap`

# .xprofile
```
xmodmap /home/kkard2/.Xmodmap

# yes, 200 is 200ms, this solution is very stupid
xcape -e 'Hyper_L=Escape' -t 200

sxhkd &

google-drive-ocamlfuse /home/kkard2/GoogleDrive

~/.fehbg &
```
