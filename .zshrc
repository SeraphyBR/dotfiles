
#   ________      _______. __    __  .______        ______
#  |       /     /       ||  |  |  | |   _  \      /      |
#  `---/  /     |   (----`|  |__|  | |  |_)  |    |  ,----'
#     /  /       \   \    |   __   | |      /     |  |
# __ /  /----.----)   |   |  |  |  | |  |\  \----.|  `----.
#(__)________|_______/    |__|  |__| | _| `._____| \______|
#


################## Oh-my-zsh Section ##################################

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

if [ ! -d "$ZSH" ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions fast-syntax-highlighting zsh-completions extract)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

if [ -z "$DISPLAY" ]; then
    ZSH_THEME="rkj-repos"
else
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block, everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
    ZSH_THEME="powerlevel10k/powerlevel10k"
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
UPDATE_ZSH_DAYS=1

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [ ! -d $ZSH_CACHE_DIR ]; then
  mkdir $ZSH_CACHE_DIR
fi

# Use autosuggestion
# https://github.com/zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

###################### End of Oh-my-zsh section ##################################

#################### User settings below this line ################################

# Extended globbing. Allows using regular expressions with *
setopt extendedglob
# Case insensitive globbing
setopt nocaseglob
# Array expension with parameters
setopt rcexpandparam
# Dont warn about running processes when exiting
setopt nocheckjobs
# Sort filenames numerically when it makes sense
setopt numericglobsort
# No beep
setopt nobeep
# Immediately append history instead of overwriting
setopt appendhistory
# If a new command is a duplicate, remove the older one
setopt histignorealldups
# if only directory path is entered, cd there.
setopt autocd
# Remove command lines from the history list when the first character on the line is a space.
setopt HIST_IGNORE_SPACE

##########################  Aliases section  ########################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias ls='exa --group-directories-first' # https://the.exa.website/
alias cp='cp -R'
alias rm='rm -Ivr'
alias :q='exit'
alias vim='nvim'
alias mocp='mocp -T darkdot_theme'
alias bbswitch='cat /proc/acpi/bbswitch'
alias efetchlog='tail -f /var/log/emerge-fetch.log'
alias webcam='mpv /dev/video0'
alias smtp='simple-mtpfs'
alias .='cd ../'
alias ..='cd ../../'
alias nvrun='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia' 
alias vkrun='__NV_PRIME_RENDER_OFFLOAD=1'
####################### Custom functions ###############################

c() {
    if [ $# -eq 0 ] ; then
        clear
    elif [ -d "$1" ] ; then
        cd "$1"
    elif [ -f "$1" ] ; then
        cat "$1"
    fi
}

# Ref: https://github.com/paulmillr/dotfiles/blob/master/home/.zshrc.sh#L282
# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

clima() {
    local cache="$HOME/.cache/clima"
    local tmp="/tmp/clima"
    if curl -s 'pt.wttr.in' > $tmp; then
        mv $tmp $cache
        cat $cache
    elif [ -e $cache ]; then
        echo "Without internet connection, using local cache."
        cat $cache
    else 
        echo "You need internet connection!"
    fi
}

mkernel() {
    if [ ${EUID:-$(id -u)} -ne 0 ]; then
        echo "You need to be root"
    else
        eselect kernel list
        echo -n "Choose kernel: "
        read target
        eselect kernel set $target
        cd /usr/src/linux
        make menuconfig && make -j8 && make install && make modules_install
    fi
}

# Reload color settings of my logitech g512 keyboard
# and change keyboard layout
loadg512(){
    g810-led -p /etc/g810-led/profile
    setxkbmap -layout us -variant intl
}

###############################################################

