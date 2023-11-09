export LANG=ja_JP.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH


# zgen
#ZGEN_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zgen/zgen.git"
ZGEN_HOME="${HOME}/.zgen/zgen.git"
[ ! -d $ZGEN_HOME ] && mkdir -p "$(dirname $ZGEN_HOME)"
[ ! -d $ZGEN_HOME/.git ] && git clone https://github.com/tarjoilija/zgen.git "$ZGEN_HOME"
source "${ZGEN_HOME}/zgen.zsh"

# exec `zgen reset` if you want to remove saved config file.
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-history-substring-search

    zgen save
fi

# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


# load my configs
for file in $HOME/.dot-files/zsh/*.zsh ; do
    source "$file"
done
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local


# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.rg

# skim
export SKIM_DEFAULT_OPTIONS='--bind="ctrl-q:execute-silent(echo -n {1} | pbcopy)+abort,ctrl-k:kill-word,ctrl-d:delete-char,ctrl-w:backward-kill-word,f1:execute-silent(code {1})+abort,ctrl-v:page-down,ctrl-g:page-up,,alt-p:preview-up,alt-n:preview-down,ctrl-space:toggle+up"'

# Homebbrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1
export DFT_PARSE_ERROR_LIMIT=99
export DFT_BYTE_LIMIT=100000

# rtx
eval "$(/Users/mac/.cargo/bin/rtx activate zsh)"
. =(rtx complete -s zsh)

# zoxide
export _ZO_FZF_OPTS=''
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"

# Wasmtime
export WASMTIME_HOME="$HOME/.local/share/rtx/installs/wasmtime/v7.0.0"
export PATH="$WASMTIME_HOME/bin:$PATH"

# bun completions
[ -s "/Users/mac/.bun/_bun" ] && source "/Users/mac/.bun/_bun"

# modular
export MODULAR_HOME="/Users/mac/.modular"
export PATH="/Users/mac/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
