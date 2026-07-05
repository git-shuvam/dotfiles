path=(
	$HOME/.local/bin
	$HOME/.local/share/pnpm/bin
	$HOME/.venv/bin
	$path
)

# ==================== Completion ====================
completion_manager() {
	local plugin
	for plugin in "$@"; do
		if ! command -v "${plugin%% *}" >/dev/null 2>&1; then continue; fi
		case $plugin in
		just) source <(just --completions bash) ;;
		pnpm) source <(pnpm completion bash) ;;
		npm) source <(npm completion) ;;
		docker) source <(docker completion bash) ;;
		kubectl) source <(kubectl completion bash) ;;
		fzf)
			source <(fzf --bash)
			# fuzzy finder
			FZF_DEFAULT_OPTS='--layout=reverse --border=bold --border=rounded --color=dark'
			;;
		uv) eval "$(uv generate-shell-completion zsh)" ;;     # source <(uv generate-shell-completion zsh)
		uvx) eval "$(uvx --generate-shell-completion zsh)" ;; # source <(uvx --generate-shell-completion zsh)
		esac
	done
}
# completion_manager just uv uvx

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
alias gl="git log --graph --all --format='%C(auto)%h %C(green)%an%C(reset)(%C(yellow)%cr%C(reset)): %s [%C(auto)%D%C(reset)]'"
alias v='nvim'
alias j='just -g'
alias t='tmux'
alias tree='tree -a --dirsfirst'
alias ls='ls --color=auto -halp --group-directories-first --time-style=+%Y-%m-%d'

[[ -f $HOME/.envrc ]] && . $HOME/.envrc

# # ====================== Prompt ======================
[[ -x "$(command -v starship)" ]] && source <(starship init zsh)
