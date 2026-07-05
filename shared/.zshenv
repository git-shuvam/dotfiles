export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-${ZSH_VERSION}"
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/.history"
export ZSH_SESSION_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/sessions"
mkdir -p -- "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
mkdir -p -- "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p -- "${ZSH_SESSION_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/zsh/sessions}"

# Rust
. "$HOME/.cargo/env"
