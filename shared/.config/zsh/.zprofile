# [[ -o login ]] && echo "loading ${(%):-%N} ..."

if [[ -x '/opt/homebrew/bin/brew' ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv zsh)" # ensure Homebrew's environment is set up for zsh
fi

mkdir -p -- "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/.history"
HISTSIZE=10000                     # Max number of history entries in memory
SAVEHIST=10000                     # Max number of history entries to save to file
HISTCONTROL=ignoredups:ignorespace # Avoid duplicate history entries and commands starting with space
setopt HIST_IGNORE_ALL_DUPS        # Ignore duplicate commands in history
setopt SHARE_HISTORY               # Share history across all sessions
setopt inc_append_history          # Save each command to the history file immediately
setopt autocd                      # Automatically change to a directory when you cd into it
setopt correct                     # Enable command correction
setopt interactivecomments         # Allow comments in interactive shells
setopt numericglobsort             # Sort glob results numerically
setopt magicequalsubst             # Enable magic equal substitution
setopt notify                      # Notify when background jobs complete

if command -v nvim >/dev/null 2>&1; then
	export EDITOR='nvim'
elif command -v vim >/dev/null 2>&1; then
	export EDITOR='vim'
fi

export VISUAL="$EDITOR"
