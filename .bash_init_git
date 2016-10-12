##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Only when this is an interactive shell.
##
is_interactive || return


##  Frequently needed git shortcuts
##
alias   ga='git add'
alias   gb='git branch'
alias   gc='git config'
alias   gh='git help'
alias   gs='git status'


##
##  See: https://git-scm.com/docs/git-diff
##
##  >   * `--cached`
##  >   * `--staged`
##  >
##  >     This form is to view the changes you staged for the next
##  >     commit relative to the named _`<commit>`_. Typically you
##  >     would want comparison with the latest commit, so if you do
##  >     not give _`<commit>`_, it defaults to `HEAD`. If `HEAD` does
##  >     not exist (e.g. unborn branches) and _`<commit>`_ is not
##  >     given, it shows all staged changes.
##  >
##  >   * `--word-diff[=`_`<mode>`_`]`
##  >
##  >     Show a word diff, using the _`<mode>`_ to delimit changed
##  >     words.  By default, words are delimited by whitespace; see
##  >     `--word-diff-regex` below.  The _`<mode>`_ defaults to plain,
##  >     and must be one of:
##  >
##  >       * `color`
##  >
##  >         Highlight changed words using only colors.  Implies
##  >         `--color`.
##  >
##  >       * `plain`
##  >         Show words as `[-`_`removed`_`-]` and `{+`_`added`_`+}`.
##  >         Makes no attempts to escape the delimiters if they appear
##  >         in the input, so the output may be ambiguous.
##  >
##  >       * `porcelain`
##  >
##  >         Use a special line-based format intended for script
##  >         consumption.  Added/removed/unchanged runs are printed in
##  >         the usual unified diff format, starting with a
##  >         `+`/`-`/` ` character at the beginning of the line and
##  >         extending to the end of the line.  Newlines in the input
##  >         are represented by a tilde `~` on a line of its own.
##  >
##  >       * `none`
##  >
##  >         Disable word diff again.
##  >
##  >     Note that despite the name of the first mode, color is used
##  >     to highlight the changed parts in all modes if enabled.
##  >
##  >   * `-M[`_`<n>`_`]`
##  >   * `--find-renames[=`_`<n>`_`]`
##  >
##  >     Detect renames.  If _`<n>`_ is specified, it is a threshold
##  >     on the similarity index (i.e. amount of addition/deletions
##  >     compared to the file’s size).  For example, `-M90%` means
##  >     Git should consider a delete/add pair to be a rename if more
##  >     than 90% of the file hasn’t changed.  Without a `%` sign,
##  >     the number is to be read as a fraction, with a decimal point
##  >     before it.  I.e., `-M5` becomes `0.5`, and is thus the same
##  >     as `-M50%`.  Similarly, `-M05` is the same as `-M5%`.  To
##  >     limit detection to exact renames, use `-M100%`.  The default
##  >     similarity index is `50%`.
##  >
##  >   * `-w`
##  >   * `--ignore-all-space`
##  >
##  >     Ignore whitespace when comparing lines.  This ignores
##  >     differences even if one line has whitespace where the other
##  >     line has none.
##
alias   gd='git diff -M'
alias  gdw='gd --word-diff=color -w'
alias  gsd='gd --staged'
alias gsdw='gdw --staged'


##
##  See: https://git-scm.com/docs/git-log
##
##  >   * `--follow`
##  >
##  >     Continue listing the history of a file beyond renames (works
##  >     only for a single file).
##  >
##  >   * `--no-decorate`
##  >   * `--decorate[=short|full|auto|no]`
##  >
##  >     Print out the ref names of any commits that are shown.  If
##  >     `short` is specified, the ref name prefixes `refs/heads/`,
##  >     `refs/tags/` and `refs/remotes/` will not be printed.  If
##  >      `full` is specified, the full ref name (including prefix)
##  >      will be printed.  If `auto` is specified, then if the output
##  >      is going to a terminal, the ref names are shown as if
##  >      `short` were given, otherwise no ref names are shown.  The
##  >      default option is `short`.
##  >
##  >   * `--abbrev-commit`
##  >
##  >     Instead of showing the full 40-byte hexadecimal commit object
##  >     name, show only a partial prefix.  Non default number of
##  >     digits can be specified with `--abbrev=`_`<n>`_ (which also
##  >     modifies diff output, if it is displayed).
##  >
##  >     This should make "--pretty=oneline" a whole lot more readable
##  >     for people using 80-column terminals.
##  >
##  >   * `--oneline`
##  >
##  >     This is a shorthand for `--pretty=oneline --abbrev-commit`
##  >     used together.
##  >
##  >   * `--graph`
##  >
##  >     Draw a text-based graphical representation of the commit
##  >     history on the left hand side of the output.  This may cause
##  >     extra lines to be printed in between commits, in order for
##  >     the graph history to be drawn properly.  Cannot be combined
##  >     with `--no-walk`.
##  >
##  >     This enables parent rewriting, see History Simplification
##  >     below.
##  >
##  >     This implies the `--topo-order` option by default, but the
##  >     `--date-order` option may also be specified.
##  >
##  >   * `-p`
##  >   * `-u`
##  >   * `--patch`
##  >
##  >     Generate patch (see section on generating patches).
##  >
##  >   * `--name-status`
##  >
##  >     Show only names and status of changed files.  See the
##  >     description of the `--diff-filter` option on what the status
##  >     letters mean.
##  >
##  >   * `--word-diff[=`_`<mode>`_`]`
##  >
##  >     _See same option at `git-diff` above._
##  >
##  >   * `-M[`_`<n>`_`]`
##  >   * `--find-renames[=`_`<n>`_`]`
##  >
##  >     If generating diffs, detect and report renames for each
##  >     commit.  For following files across renames while traversing
##  >     history, see --follow.
##  >
##  >     _See same option at `git-diff` above._
##  >
##  >   * `-w`
##  >   * `--ignore-all-space`
##  >
##  >     _See same option at `git-diff` above._
##
alias   gl='git log --decorate --abbrev-commit --name-status -M'
alias  gld='git log --decorate --abbrev-commit -p -M'
alias gldw='gld --word-diff=color -w'
alias  gll='git log --decorate --oneline'
alias   gg='gl --graph'
alias  ggl='gll --graph'


##  Try to provide the means for including a git repository's status
##  in the PS1 prompt
##
##  If `__git_ps1` hasn't been defined yet, try to find an instance of
##  the `git-prompt` script in various known locations and `source`
##  the first one that appears usable.
##
if type -p __git_ps1 >&- ; then :; else

    ##  Try these patterns in order:
    ##
    ##    * `~/.git-prompt*`
    ##    * `/usr/lib/git-core/git-sh-prompt*`
    ##    * `/etc/bash_completion.d/git-prompt*`
    ##    * `/usr/local/etc/bash_completion.d/git-prompt*`
    ##
    for __git_prompt in {~/.git,/usr/lib/git-core/git-sh,/{,usr/local/}etc/bash_completion.d/git}-prompt*; do
        if [[ -r "${__git_prompt}" && "$( file -bm "${IX_HOME}/.magic" -- "${__git_prompt}" )" == 'git-prompt' ]] ; then
            source -- "${__git_prompt}"
            break
        fi
    done
fi

if type -p __git_ps1 >&- ; then

    ##  > unstaged (`*`) and staged (`+`) changes will be shown next to
    ##  > the branch  name.  You can configure this per-repository with
    ##  > the `bash.showDirtyState` variable, which defaults to true
    ##  > once `GIT_PS1_SHOWDIRTYSTATE` is enabled.
    ##
    ##  @property   env.$GIT_PS1_SHOWDIRTYSTATE
    ##  @default    1
    ##
    export GIT_PS1_SHOWDIRTYSTATE='1'


    ##  > If something is stashed, then a `$` will be shown next to the
    ##  > branch name.
    ##
    ##  @property   env.$GIT_PS1_SHOWSTASHSTATE
    ##  @default    1
    ##
    export GIT_PS1_SHOWSTASHSTATE='1'


    ##  > If there're untracked files, then a `%` will be shown next to
    ##  > the branch name.  You can configure this per-repository with
    ##  > the `bash.showUntrackedFiles` variable, which defaults to
    ##  > true once `GIT_PS1_SHOWUNTRACKEDFILES` is enabled.
    ##
    ##  @property   env.$GIT_PS1_SHOWUNTRACKEDFILES
    ##  @default    1
    ##
    export GIT_PS1_SHOWUNTRACKEDFILES='1'


    ##  > If you would like to see the difference between HEAD and its
    ##  > upstream, set `GIT_PS1_SHOWUPSTREAM='auto'`.
    ##  >
    ##  > A `<` indicates you are behind, `>` indicates you are ahead,
    ##  > `<>` indicates you have diverged and `=` indicates that there
    ##  > is no difference. You can further control behaviour by
    ##  > setting `GIT_PS1_SHOWUPSTREAM` to a space-separated list of
    ##  > values:
    ##  >
    ##  >   * `verbose` - show number of commits ahead/behind (+/-)
    ##  >                 upstream;
    ##  >   * `name`    - if `verbose`, then also show the upstream
    ##  >                 abbrev name;
    ##  >   * `legacy`  - don't use the `--count` option available in
    ##  >                 recent versions of `git-rev-list`;
    ##  >   * `git`     - always compare `HEAD` to `@{upstream}`;
    ##  >   * `svn`     - always compare `HEAD` to your SVN `upstream`;
    ##  >
    ##  > By default, `__git_ps1` will compare `HEAD` to your SVN
    ##  > `upstream` if it can find one, or `@{upstream}` otherwise.
    ##  > Once you have set `GIT_PS1_SHOWUPSTREAM`, you can override it
    ##  > on a per-repository basis by setting the `bash.showUpstream`
    ##  > config variable.
    ##
    ##  @property   env.$GIT_PS1_SHOWUPSTREAM
    ##  @default    verbose
    ##
    export GIT_PS1_SHOWUPSTREAM='verbose'


    ##  > If you would like to see more information about the identity
    ##  > of commits checked out as a detached `HEAD`, set
    ##  > `GIT_PS1_DESCRIBE_STYLE` to one of these values:
    ##  >
    ##  >   * `contains` - relative to newer annotated tag
    ##  >                  (`v1.6.3.2~35`)
    ##  >   * `branch`   - relative to newer tag or branch (`master~4`)
    ##  >   * `describe` - relative to older annotated tag
    ##  >                  (`v1.6.3.1-13-gdd42c2f`);
    ##  >   * `default`  - exactly matching tag;
    ##
    ##  @property   env.$GIT_PS1_DESCRIBE_STYLE
    ##  @default    branch
    ##
    export GIT_PS1_DESCRIBE_STYLE='branch'


    ##  > If you would like a colored hint about the current dirty
    ##  > state, set `GIT_PS1_SHOWCOLORHINTS` to a nonempty value.
    ##  >
    ##  > The colors are based on the colored output of
    ##  > `git status -sb` and are available only when using
    ##  > `__git_ps1` for `${PROMPT_COMMAND}`.
    ##
    ##  @property   env.$GIT_PS1_SHOWCOLORHINTS
    ##  @default    1
    ##
    export GIT_PS1_SHOWCOLORHINTS='1'


    ##  > If you would like `__git_ps1` to do nothing in the case when
    ##  > the current directory is set up to be ignored by git, then
    ##  > set `GIT_PS1_HIDE_IF_PWD_IGNORED` to a nonempty value.
    ##  > Override this on the repository level by setting
    ##  > `bash.hideIfPwdIgnored` to `false`.
    ##
    ##  @property   env.$GIT_PS1_HIDE_IF_PWD_IGNORED
    ##  @default    ''
    ##
    export GIT_PS1_HIDE_IF_PWD_IGNORED=''

fi
