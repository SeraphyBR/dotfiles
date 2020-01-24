# If you come from bash you might have to change your $PATH.
export PATH="/bin:/usr/local/bin:$HOME/.local/bin:/usr/sbin:$PATH"
#export PATH=$PATH:/usr/bin/go/bin
#export GOPATH=$HOME/go
#export PATH=$PATH:$GOPATH/bin

export PATH="$HOME/.gems/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export GEM_HOME="$HOME/.gems"

export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Time
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# NodeJS global
NODE_PATH=$NODE_PATH:$(npm root -g)
export PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# Editor
export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
