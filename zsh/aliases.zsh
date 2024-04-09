alias dc='docker compose'
alias di='docker image list'
alias dps='docker ps'
alias e='/opt/homebrew/bin/emacsclient --no-wait'
alias ls='ls -F'
alias ll='ls -lF'
alias llt='ls -ltrF'
alias lls='ls -lSrFh'
alias la='ls -a'
alias cp='cp -i'
alias c=cargo
alias m=make
alias mv='mv -i'
alias r=rg
alias rm='rm -i'
alias sl=ls
alias ssh='ssh -X'
alias typos='typos --exclude \*.js --exclude \*.css --exclude \*.trace --exclude \*.map --exclude \*.sql --exclude \*.svg'
alias od='od -Ax -t x1 -v'
alias less='bat --theme=TwoDark'
which md5sum > /dev/null && alias md5='md5sum'

# macos
alias f='open -a Finder'
alias mp='$HOME/Applications/mpv.app/Contents/MacOS/mpv'
alias cv='$HOME/Applications/cooViewer.app/Contents/MacOS/cooViewer'

# git aliases
alias g=git
alias gl='git log'
alias gll='git log --graph --oneline'
alias gs='git status -s'
alias gt='git for-each-ref --sort=committerdate --format="%(committerdate:short) %(refname:short)" refs/tags'
alias gsp='git status -s | sk | cut -c 4- | pbcopy'
alias gd="git diff"
alias gds="git diff --staged"

# unaliases
alias gc > /dev/null && unalias gc
