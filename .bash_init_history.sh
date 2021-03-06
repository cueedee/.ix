##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Only when this is an interactive shell.
##
is_interactive || return


##
##  OS X:
##
##  See also: file:///etc/bashrc_Apple_Terminal
##

##  Ensure history is being appended-to instead of overwritten.
##
##  See also: https://www.gnu.org/software/bash/manual/bashref.html#index-shopt (scroll down)
##
##  > If set, the history list is appended to the file named by the
##  > value of the `HISTFILE` variable when the shell exits, rather
##  > than overwriting the file.
##
##  @property   shopt.histappend
##  @default    on
##
shopt -s histappend


##  Ensure duplicate history entries are avoided keeping only the most
##  recent one.
##
##  Additionally, to provide a means for avoiding certain sensitive
##  commands from being saved, prevent lines starting with a space from
##  being saved too.
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-HISTCONTROL
##
##  > A colon-separated list of values controlling how commands are
##  > saved on the history list.  If the list of values includes
##  > `ignorespace`, lines which begin with a space character are not
##  > saved in the history list.  A value of `ignoredups` causes lines
##  > which match the previous history entry to not be saved.  A value
##  > of `ignoreboth` is shorthand for `ignorespace` and `ignoredups`.
##  > A value of `erasedups` causes all previous lines matching the
##  > current line to be removed from the history list before that line
##  > is saved.  Any value not in the above list is ignored.  If
##  > `HISTCONTROL` is unset, or does not include a valid value, all
##  > lines read by the shell parser are saved on the history list,
##  > subject to the value of `HISTIGNORE`.  The second and subsequent
##  > lines of a multi-line compound command are not tested, and are
##  > added to the history regardless of the value of `HISTCONTROL`.
##
##  @property   $HISTCONTROL
##  @default    erasedups:ignoreboth
##
HISTCONTROL=erasedups:ignoreboth


##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-HISTFILESIZE
##
##  > The maximum number of lines contained in the history file.  When
##  > this variable is assigned a value, the history file is truncated,
##  > if necessary, to contain no more than that number of lines by
##  > removing the oldest entries.  The history file is also truncated
##  > to this size after writing it when a shell exits.  If the value
##  > is `0`, the history file is truncated to zero size.  Non-numeric
##  > values and numeric values less than zero inhibit truncation.  The
##  > shell sets the default value to the value of `HISTSIZE` after
##  > reading any startup files.
##
##  @property   $HISTFILESIZE
##  @default    10000
##
HISTFILESIZE=10000


##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-HISTSIZE
##
##  > The maximum number of commands to remember on the history list.
##  > If the value is `0`, commands are not saved in the history list.
##  > Numeric values less than zero result in every command being saved
##  > on the history list (there is no limit).  The shell sets the
##  > default value to `500` after reading any startup files.
##
##  @property   $HISTSIZE
##  @default    10000
##
HISTSIZE=10000


##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-HISTTIMEFORMAT
##
##  > If this variable is set and not null, its value is used as a
##  > format string for `strftime` to print the time stamp associated
##  > with each history entry displayed by the history builtin.  If
##  > this variable is set, time stamps are written to the history file
##  > so they may be preserved across shell sessions.  This uses the
##  > history comment character to distinguish timestamps from other
##  > history lines.
##
##  @property   $HISTTIMEFORMAT
##  @default    '[%Y-%m-%d %a %T] '
##
HISTTIMEFORMAT='[%Y-%m-%d %a %T] '


##  Inject history appending into `${PROMPT_COMMAND}`.
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-PROMPT_005fCOMMAND
##
##  > If set, the value is interpreted as a command to execute before
##  > the printing of each primary prompt (`$PS1`).
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-history
##
##  > - `-a`
##  >
##  >   Append the new history lines to the history file.  These are
##  >   history lines entered since the beginning of the current Bash
##  >   session, but not already appended to the history file.
##
##  @property   $PROMPT_COMMAND
##  @default    "${PROMPT_COMMAND};history -a"
##
PROMPT_COMMAND="$( command_inject "${PROMPT_COMMAND}" "history -a" )"
