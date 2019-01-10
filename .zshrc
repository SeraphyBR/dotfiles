#   ________      _______. __    __  .______        ______ 
#  |       /     /       ||  |  |  | |   _  \      /      |
#  `---/  /     |   (----`|  |__|  | |  |_)  |    |  ,----'
#     /  /       \   \    |   __   | |      /     |  |     
# __ /  /----.----)   |   |  |  |  | |  |\  \----.|  `----.
#(__)________|_______/    |__|  |__| | _| `._____| \______|
#                                                          


################## Oh-my-zsh Section ########################################################

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

if [ -z "$DISPLAY" ]; then
    ZSH_THEME="rkj-repos"
    export TERM="xterm-256color"
else 
    POWERLEVEL9K_MODE='nerdfont-complete'
    ZSH_THEME="powerlevel9k/powerlevel9k"
fi
 
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting extract)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [ ! -d $ZSH_CACHE_DIR ]; then
  mkdir $ZSH_CACHE_DIR
fi    

# Use autosuggestion
# https://github.com/zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8' 


######################## PowerLevel9K Section #####################################################
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
if [ ! -z "$DISPLAY" ]; then 
    POWERLEVEL9K_DIR_SHOW_WRITABLE=true 
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs )
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ssh root_indicator background_jobs virtualenv)
    POWERLEVEL9K_DIR_SHOW_WRITABLE=true 
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
    POWERLEVEL9K_SHORTEN_DELIMITER=""
    POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
fi

# If powerlevel9k shows errors messages about mercurial...
if [ ! -e "~/.hgrc" ];then
    touch ~/.hgrc
fi

############################################################################################### 

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

###################### End of Oh-my-zsh section ##########################################################



#################### User settings below this line ########################################################

# Auto correct mistakes
#setopt correct 
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

################## Completion section ###########################################################
 

#################################  Aliases section  ############################################# 
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
 
alias clima="curl pt.wttr.in"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ls='ls --color=auto'
alias cp='cp -R'
alias rm='rm -Ivr'
alias :q='exit'
alias svim='doas nvim'
alias vim='nvim' 
alias mocp="mocp -T darkdot_theme"
alias bbswitch="cat /proc/acpi/bbswitch"
alias nvidia-settings="optirun -b none nvidia-settings -c :8"
alias sxiv="sxiv -r . "
alias addpkg="doas emerge -a --jobs"
alias update="doas ego sync"
alias upgrade="doas emerge -auvDN @world"
alias .='cd ../'
alias ..='cd ../../'

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
 
###############################################################


