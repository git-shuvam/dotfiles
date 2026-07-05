# [[ -o interactive ]] && echo "loading ${(%):-%N} ..."
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/.history"
export ZSH_SESSION_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/sessions"
mkdir -p -- "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
mkdir -p -- "${ZSH_SESSION_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/zsh/sessions}"

path=(
	$HOME/.local/bin
	$HOME/.local/share/pnpm/bin
	$HOME/.venv/bin
	$path
)
# ==================== Completion ====================
if [[ -d ~/.zfunc ]]; then
	fpath+=~/.zfunc
else
	mkdir -p "$HOME/.zfunc"
	command -v rustup >/dev/null 2>&1 && {
		rustup completions zsh >"$HOME/.zfunc/_rustup"
		rustup completions zsh cargo >"$HOME/.zfunc/_cargo"
	}
	command -v just >/dev/null 2>&1 && just --completions zsh >"$HOME/.zfunc/_just"
	command -v pnpm >/dev/null 2>&1 && pnpm completion zsh >"$HOME/.zfunc/_pnpm"
	command -v npm >/dev/null 2>&1 && npm completion >"$HOME/.zfunc/_npm"
	command -v docker >/dev/null 2>&1 && docker completion zsh >"$HOME/.zfunc/_docker"
	command -v kubectl >/dev/null 2>&1 && kubectl completion zsh >"$HOME/.zfunc/_kubectl"
	command -v uv >/dev/null 2>&1 && uv generate-shell-completion zsh >"$HOME/.zfunc/_uv"
	command -v uvx >/dev/null 2>&1 && uvx --generate-shell-completion zsh >"$HOME/.zfunc/_uvx"
	echo "$HOME/.zfunc created and all completion added to it, restart zsh"
fi

mkdir -p -- "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p -- "${ZCOMPDUMP:h}"
autoload -Uz compinit
compinit -d "$ZCOMPDUMP"

# ===================== settings =====================
export ZPM_BASE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
# ==================== ZSH plugins ====================
[[ ! -d "$ZPM_BASE" ]] && mkdir -p -- "$ZPM_BASE"

zpm() {
	local repo
	for repo in "$@"; do
		local name="${repo:t}"
		local target="$ZPM_BASE/$name"

		if [[ ! -d "$target" ]]; then
			echo "Installing $repo..."
			git clone --depth=1 "https://github.com/$repo.git" "$target"
		fi
		source "$target/$name.zsh"
	done
}
zpm zsh-users/zsh-syntax-highlighting # zsh-users/zsh-autosuggestions

# ----------------------- Alias -----------------------
xtract() {
	if [ -f "$1" ]; then
		case $1 in
		*.tar.bz2) tar xjvf "$1" ;;
		*.tar.gz) tar xzvf "$1" ;;
		*.tar.xz) tar xvf "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.bz2) bzip2 "$1" ;;
		*.rar) unrar2dir "$1" ;;
		*.gz) gunzip "$1" ;;
		*.zip) unzip2dir "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*.ace) unace x "$1" ;;
		*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
alias sz='clear; source $ZDOTDIR/.zshrc'
alias gs='git status --short'
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gcm='git commit -m'
alias gco='git checkout'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'
alias gap='git add --patch'
# %h -- commit hash
# %an -- author name
# %ar -- commit time
# %D -- ref names
# %n -- new line
# %s -- commt message
# alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto)  %D%n%s%n'"
# alias gl="git log --graph --decorate --all --format='%C(auto)%h %d %C(green)%an%C(reset)(%C(yellow)%cr%C(reset)): %s'"
# alias gl="git log --graph --all --format='%C(auto)%h %C(green)%an%C(reset)(%C(yellow)%cr%C(reset)): %s%C(auto)%d'"
alias gl="git log --graph --all --format='%C(auto)%h %C(green)%an%C(reset)(%C(yellow)%cr%C(reset)): %s [%C(auto)%D%C(reset)]'"

alias v='nvim'
alias j='just -g'
alias t='tmux'
alias tree='tree -a --dirsfirst'

# # ====================== Prompt ======================
if [[ -x "$(command -v starship)" ]]; then
	# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
	source <(starship init zsh)
else
	# | Directive | Meaning                                                    |
	# | --------- | ---------------------------------------------------------- |
	# | `%b`      | Branch name (or tag name if detached)                      |
	# | `%a`      | Action (e.g. `rebase`, `merge`, `cherry-pick`, `bisect`)   |
	# | `%i`      | Revision identifier (usually commit hash in detached HEAD) |
	# | `%m`      | Miscellaneous information (depends on hooks/backends)      |
	# | `%r`      | Repository root name                                       |
	# | `%s`      | VCS name (`git`, `hg`, `svn`, etc.)                        |
	# | `%S`      | Repository subdirectory relative to the repo root          |
	# | `%c`      | Staged changes marker (requires `check-for-changes`)       |
	# | `%u`      | Unstaged changes marker (requires `check-for-changes`)     |
	autoload -Uz promptinit colors vcs_info add-zsh-hook
	colors
	promptinit
	prompt_redhat_setup() {
		PS1='[%F{green}%n@%m%f %F{cyan}%2~%f]%(#.%F{red}#%f.%F{white}$%f) '
		PS2='> '
		prompt_opts=(cr percent)
	}
	prompt redhat

	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr '+'
	zstyle ':vcs_info:git:*' unstagedstr '*'
	zstyle ':vcs_info:git:*' formats '%F{green}%b%c%u%f'
	zstyle ':vcs_info:git:*' actionformats '%F{green}%b|%a%c%u%f'
	add-zsh-hook precmd vcs_info
	setopt PROMPT_SUBST
	RPROMPT='${vcs_info_msg_0_}'
fi

[[ -f "$HOME/.envrc" ]] && source "$HOME/.envrc"

# ================== OS based config ==================
case "$(uname -s)" in
Darwin)
	export HOMEBREW_NO_AUTO_UPDATE=1
	export HOMEBREW_NO_ENV_HINTS=1
	# export HOMEBREW_UPGRADE_GREEDY=1
	# alias k='kubectl'
	alias ls='ls -FGhlo -D %Y-%m-%d'
	# completion_manager just pnpm npm docker kubectl fzf uv uvx
	;;
Linux)
	alias ls='ls --color=auto -halp --group-directories-first --time-style=+%Y-%m-%d'
	# completion_manager just uv uvx
	;;
esac
command -v fzf >/dev/null 2>&1 && {
	# export FZF_DEFAULT_OPTS='--height 40% --popup bottom,40% --layout reverse --border top'
	export FZF_DEFAULT_OPTS='--height 5% --popup bottom,5% --layout reverse --border top'
	source <(fzf --zsh)
}
# ===================== clean up =====================
# unset -f completion_manager zpm
unset -f zpm

# bindkey -l # list all keymaps
# bindkey -v # enable vi mode
bindkey -e # (enable emacs)/(disable vi) mode
