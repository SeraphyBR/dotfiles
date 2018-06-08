# Dot Files
Repository dedicated to my configuration files of my Desktop environment, with the purpose of backup and sharing.

## Screenshots:

![Screenshot-1](Screenshots/Screenshot1.png)

### Rofi:

![Screenshot-2](Screenshots/Screenshot2.png)

## Programs and infos:
* Linux Distro =        [Manjaro](https://manjaro.org/)
* Window Manager =      [Bspwm](https://github.com/baskerville/bspwm)(Main) and [i3-gaps](https://github.com/Airblader/i3)
* Web Browser =         [Firefox](https://www.mozilla.org/pt-BR/firefox/new/) / [qutebrowser](https://qutebrowser.org/)
* Program Launcher =    [Rofi](https://github.com/DaveDavenport/rofi)
* Status bar =          [Polybar](https://github.com/jaagr/polybar)
* Music Player =        [MOC](http://moc.daper.net) and [Spotify](https://www.spotify.com/) (with a polybar module: [spotify_status](https://github.com/Jvanrhijn/polybar-spotify))
* Vídeo Player =        [SMPlayer](https://www.smplayer.info/) and [MPV](https://mpv.io/)
* Sound Visualizer =    [Cava](https://github.com/karlstav/cava)
* File Manager =        Thunar / [Ranger](https://github.com/ranger/ranger)
* Wallpaper Setter =    Nitrogen
* Terminal Emulator =   [Termite](https://github.com/thestinger/termite) and [Suckless' Simple Terminal](https://github.com/SeraphyBR/st)
* Shell =               Zsh ([Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [PowerLevel9k](https://github.com/bhilburn/powerlevel9k) theme)
* Text Editor =         [Vim](https://github.com/vim/vim) (or [Neovim](https://github.com/neovim/neovim) with same config) / [VScode](https://github.com/Microsoft/vscode)
* Power Manager =       [TLP](http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html )
* Monitor =             Arandr / [xrandr](https://wiki.archlinux.org/index.php/xrandr)  
* Lock Screen =         [Betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)
* Notification Daemon =  [Dunst](https://github.com/dunst-project/dunst) / libnotify
* Gtk theme =           Adapta-nokto-eta-maia (Manjaro repo)
* Cursor theme =        Breeze Obsidian

#### Main Fonts used in this Dotfiles:
* [DejavuSans](https://github.com/dejavu-fonts/dejavu-fonts)
* [Iosevka](https://be5invis.github.io/Iosevka/)
* [FontAwesome4](https://github.com/FortAwesome/Font-Awesome/tree/fa-4)
* [MaterialDesign](https://github.com/google/material-design-icons)
* [awesome-terminal-fonts](https://github.com/gabrielelana/awesome-terminal-fonts)

#### Obs: I generated a list of my installed programs, you can try to use it in a fresh installation of manjaro with:
* It should not work on arch linux because manjaro uses independent repository and some programs may not be found by pacman.


> $ trizen -S [installed_programs-Manjaro-Notebook.txt](https://github.com/SeraphyBR/DotFiles/blob/master/installled_programs-Manjaro-Notebook.txt)

#### Obs2: I also recently made a [setup script](https://github.com/SeraphyBR/DotFiles/blob/master/setup-dotfiles.sh), but it is available only in Brazilian Portuguese, made for my personal use. It works on Manjaro and Arch Linux.
* It works on Arch Linux, but it will be reported that some packages were not found, since they are from the manjaro repository
#### Touchpad Support: 
* To use enable touch-click, install libinput and create the following file in "/etc/X11/xorg.conf.d/30-touchpad.conf"

```  
Section "InputClass"
	Identifier "touchpad"
	Driver "libinput"
	MatchIsTouchpad "on"
	Option "Tapping" "on"
        Option "TappingButtonMap" "lmr"
        Option "TappingDrag" "on"
EndSection 	
```





