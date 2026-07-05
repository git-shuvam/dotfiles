set quiet
set ignore-comments

alias s := sync
alias x := unsync
alias c := commit

_root:
    just -ul

# Clean up dotfiles
[private]
cleanup:
    bash ./bin/cleanup


# -R: remove and re-create symlinks
# -D: delete symlinks
# -t: target directory(HOME)
# -d: source directory(dotfiles)
# --adopt: [🚨] if file exits in target dir, move it to source dir and create symlink
# -n/--no/--simulate + -vv: dry-run


_sync os:
    stow -R shared {{os}}

_unsync os:
    stow -D shared {{os}}
    just cleanup


# Install and uninstall dotfiles using GNU Stow
[macos]
sync: (_sync 'macos')

# Uninstall dotfiles using GNU Stow
[macos]
unsync: (_unsync 'macos')

# Install and uninstall dotfiles using GNU Stow
[linux]
sync: (_sync 'ubuntu')

# Uninstall dotfiles using GNU Stow
[linux]
unsync: (_unsync 'ubuntu')

# Commit changes to git
commit:
    git add -A
    git commit -m "✨ Commit-$(( $(git rev-list --count HEAD 2>/dev/null || echo 0) + 1 ))"
    git push
