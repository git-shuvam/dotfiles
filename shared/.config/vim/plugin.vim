vim9script

# ===================================================
# Minimal native plugin manager (Vim 9)
# Installs missing plugins into Vim's default package
# directory and loads them immediately.
# ===================================================
# pm.Plugin([
#     { repo: 'preservim/nerdtree', },
#     { repo: 'junegunn/fzf', start: false, post: ['./install --all'], },
#     { repo: 'neoclide/coc.nvim', post: ['npm ci'], branch: 'release',},
#     { repo: 'dense-analysis/ale', tag: 'v3.3.0', },
#     { repo: 'foo/bar', commit: '4f8c9ab',},
#  ])

# export def Sync(plugins: list<dict<any>>)
#     const ICON = {
#         install: '✔',
#         remove:  '✘',
#         hook:    '⚙',
#         warn:    '⚠',
#         error:   '✖',
#         done:    '✓',
#     }

#     const root = split(&packpath, ',')[0]
#     const base = $"{root}/pack/pm/start"

#     mkdir(base, 'p')

#     var desired: dict<bool> = {}
#     var changed = false
#     var headerShown = false

#     var installed = 0
#     var removed = 0
#     var skipped = 0
#     var errors = 0

#     def ShowHeader()
#         if headerShown
#             return
#         endif

#         echom '────────────────────────'
#         echom ' Plugin Sync'
#         echom '────────────────────────'

#         headerShown = true
#     enddef

#     # -------------------------------------------------------------------------
#     # Install
#     # -------------------------------------------------------------------------

#     for spec in plugins
#         if !get(spec, 'enabled', true)
#             continue
#         endif

#         const repo = spec.repo
#         const name = get(spec, 'name', split(repo, '/')[-1])

#         desired[name] = true

#         const path = $"{base}/{name}"

#         if isdirectory(path)
#             skipped += 1
#             continue
#         endif

#         const url = get(spec, 'url', $"https://github.com/{repo}.git")
#         const depth = get(spec, 'depth', 1)
#         const branch = get(spec, 'branch', '')
#         const tag = get(spec, 'tag', '')
#         const commit = get(spec, 'commit', '')
#         const post = get(spec, 'post', [])

#         var cmd = 'git clone'

#         if depth > 0
#             cmd ..= $" --depth={depth}"
#         endif

#         if !empty(branch) && empty(tag) && empty(commit)
#             cmd ..= ' --branch ' .. shellescape(branch)
#         endif

#         cmd ..= ' '
#             .. shellescape(url)
#             .. ' '
#             .. shellescape(path)

#         system(cmd)

#         if v:shell_error != 0
#             ShowHeader()

#             echohl ErrorMsg
#             echom $" {ICON.error} Failed to clone {repo}"
#             echohl None

#             errors += 1
#             continue
#         endif

#         if !empty(tag)
#             system(
#                 'git -C '
#                 .. shellescape(path)
#                 .. ' checkout tags/'
#                 .. shellescape(tag)
#             )
#         elseif !empty(commit)
#             system(
#                 'git -C '
#                 .. shellescape(path)
#                 .. ' checkout '
#                 .. shellescape(commit)
#             )
#         endif

#         for hook in post
#             ShowHeader()

#             echohl MoreMsg
#             echom $" {ICON.hook} {repo}: {hook}"
#             echohl None

#             system(
#                 'cd '
#                 .. shellescape(path)
#                 .. ' && '
#                 .. hook
#             )

#             if v:shell_error != 0
#                 echohl WarningMsg
#                 echom $" {ICON.warn} Hook failed: {repo}"
#                 echohl None
#             endif
#         endfor

#         ShowHeader()

#         echohl MoreMsg
#         echom $" {ICON.install} Installed {repo}"
#         echohl None

#         installed += 1
#         changed = true
#     endfor

#     # -------------------------------------------------------------------------
#     # Clean
#     # -------------------------------------------------------------------------

#     for path in glob($"{base}/*", false, true)
#         const name = fnamemodify(path, ':t')

#         if has_key(desired, name)
#             continue
#         endif

#         delete(path, 'rf')

#         ShowHeader()

#         echohl WarningMsg
#         echom $" {ICON.remove} Removed {name}"
#         echohl None

#         removed += 1
#         changed = true
#     endfor

#     # -------------------------------------------------------------------------
#     # Reload packages
#     # -------------------------------------------------------------------------

#     if changed
#         packloadall
#     endif

#     # -------------------------------------------------------------------------
#     # Summary
#     # -------------------------------------------------------------------------

#     if changed || errors > 0
#         echom '────────────────────────'

#         echohl MoreMsg
#         echom $" {ICON.done} Plugin sync complete"
#         echohl None

#         echom $" Installed : {installed}"
#         echom $" Removed   : {removed}"
#         echom $" Skipped   : {skipped}"
#         echom $" Errors    : {errors}"
#         echom '────────────────────────'
#     endif
# enddef


export def Sync(plugins: list<dict<any>>)
    const ICON = {
        install: '✔',
        remove:  '✘',
        hook:    '⚙',
        warn:    '⚠',
        error:   '✖',
        done:    '✓',
    }

    const root = split(&packpath, ',')[0]
    const base = $"{root}/pack/vendor/start"

    mkdir(base, 'p')

    var desired: dict<bool> = {}
    var changed = false
    var headerShown = false

    var installed = 0
    var removed = 0
    var skipped = 0
    var errors = 0

    def ShowHeader()
        if headerShown
            return
        endif

        echom '────────────────────────'
        echom ' Plugin Sync'
        echom '────────────────────────'

        headerShown = true
    enddef

    # -------------------------------------------------------------------------
    # Install missing plugins
    # -------------------------------------------------------------------------

    for spec in plugins
        if !get(spec, 'enabled', true)
            continue
        endif

        const repo = spec.repo
        const name = get(spec, 'name', split(repo, '/')[-1])
        const path = $"{base}/{name}"

        desired[name] = true

        if isdirectory(path)
            skipped += 1
            continue
        endif

        const url = get(spec, 'url', $"https://github.com/{repo}.git")
        const depth = get(spec, 'depth', 1)
        const branch = get(spec, 'branch', '')
        const tag = get(spec, 'tag', '')
        const commit = get(spec, 'commit', '')
        const post = get(spec, 'post', [])

        var cmd = 'git clone'

        if depth > 0
            cmd ..= $" --depth={depth}"
        endif

        if !empty(branch) && empty(tag) && empty(commit)
            cmd ..= ' --branch ' .. shellescape(branch)
        endif

        cmd ..= ' '
            .. shellescape(url)
            .. ' '
            .. shellescape(path)

        system(cmd)

        if v:shell_error != 0
            ShowHeader()

            echohl ErrorMsg
            echom $" {ICON.error} Failed to clone {repo}"
            echohl None

            errors += 1
            continue
        endif

        if !empty(tag)
            system(
                'git -C '
                .. shellescape(path)
                .. ' checkout tags/'
                .. shellescape(tag)
            )
        elseif !empty(commit)
            system(
                'git -C '
                .. shellescape(path)
                .. ' checkout '
                .. shellescape(commit)
            )
        endif

        for hook in post
            ShowHeader()

            echohl MoreMsg
            echom $" {ICON.hook} {repo}: {hook}"
            echohl None

            system(
                'cd '
                .. shellescape(path)
                .. ' && '
                .. hook
            )

            if v:shell_error != 0
                echohl WarningMsg
                echom $" {ICON.warn} Hook failed: {repo}"
                echohl None
            endif
        endfor

        ShowHeader()

        echohl MoreMsg
        echom $" {ICON.install} Installed {repo}"
        echohl None

        installed += 1
        changed = true
    endfor

    # -------------------------------------------------------------------------
    # Remove orphaned plugins
    # -------------------------------------------------------------------------

    for path in glob($"{base}/*", false, true)
        const name = fnamemodify(path, ':t')

        if has_key(desired, name)
            continue
        endif

        delete(path, 'rf')

        ShowHeader()

        echohl WarningMsg
        echom $" {ICON.remove} Removed {name}"
        echohl None

        removed += 1
        changed = true
    endfor

    # -------------------------------------------------------------------------
    # Reload packages
    # -------------------------------------------------------------------------

    if changed
        packloadall
    endif

    # -------------------------------------------------------------------------
    # Summary
    # -------------------------------------------------------------------------

    if changed || errors > 0
        echom '────────────────────────'

        echohl MoreMsg
        echom $" {ICON.done} Plugin sync complete"
        echohl None

        echom $" Installed : {installed}"
        echom $" Removed   : {removed}"
        echom $" Skipped   : {skipped}"
        echom $" Errors    : {errors}"
        echom '────────────────────────'
    endif
enddef
