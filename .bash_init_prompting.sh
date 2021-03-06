##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Only when this is an interactive shell.
##
is_interactive || return


##
##  References:
##
##    * http://invisible-island.net/ncurses/man/tput.1.html
##    * http://invisible-island.net/ncurses/man/terminfo.5.html
##    * https://en.wikipedia.org/wiki/ANSI_escape_code
##


##  Assess whether this terminal has color support.
##
##  @method     has_color
##
##  @return     {status}
##
alias has_color='tput setaf 1 &>/dev/null'


##  Assess whether this terminal is `xterm` compatible.
##
##  @method     is_xterm
##
##  @return     {status}
##
alias is_xterm='[[ "${TERM}" =~ ^(rxvt|xterm) ]]'


##
##  Most `sgr` attributes except protected mode.
##
##    * http://invisible-island.net/ncurses/man/terminfo.5.html#h3-Highlighting_-Underlining_-and-Visible-Bells
##    * http://invisible-island.net/ncurses/man/terminfo.5.html#h3-Color-Handling
##


##  Reset all attributes. (`sgr0`)
##
##  @property   $term_style_rst
##
term_style_rst="$( tput sgr0 )"


##  Turn on blinking.
##
##  @property   $term_style_bln
##
term_style_bln="$( tput blink )"


##  Turn on bold (extra bright) mode. (`bold`)
##
##  @property   $term_style_bld
##
term_style_bld="$( tput bold )"


##  Turn on half-bright mode. (`dim`)
##
##  @property   $term_style_dim
##
term_style_dim="$( tput dim )"


##  Turn on reverse video mode. (`rev`)
##
##  @property   $term_style_rev
##
term_style_rev="$( tput rev )"


##  Turn on blank mode (characters invisible). (`invis`)
##
##  @property   $term_style_inv
##
term_style_inv="$( tput invis )"


##  Begin standout mode. (`smso`)
##
##  @property   $term_style_sob
##
term_style_sob="$( tput smso )"


##  Begin underline mode. (`smul`)
##
##  @property   $term_style_ulb
##
term_style_ulb="$( tput smul )"


##  Exit standout mode. (`rmso`)
##
##  @property   $term_style_soe
##
term_style_soe="$( tput rmso )"


##  Exit underline mode. (`rmul`)
##
##  @property   $term_style_ule
##
term_style_ule="$( tput rmul )"


##  Set foreground color to black, red, green, yellow, blue, magenta,
##  cyan or white.
##
##  @property   $term_style_fg_blk
##  @property   $term_style_fg_red
##  @property   $term_style_fg_grn
##  @property   $term_style_fg_ylw
##  @property   $term_style_fg_blu
##  @property   $term_style_fg_mga
##  @property   $term_style_fg_cyn
##  @property   $term_style_fg_wht
##

##  Set foreground color to light/bright black, red, green, yellow,
##  blue, magenta, cyan or white.
##
##  @property   $term_style_fg_blk_hi
##  @property   $term_style_fg_red_hi
##  @property   $term_style_fg_grn_hi
##  @property   $term_style_fg_ylw_hi
##  @property   $term_style_fg_blu_hi
##  @property   $term_style_fg_mga_hi
##  @property   $term_style_fg_cyn_hi
##  @property   $term_style_fg_wht_hi
##

##  Set background color to black, red, green, yellow, blue, magenta,
##  cyan or white.
##
##  @property   $term_style_bg_blk
##  @property   $term_style_bg_red
##  @property   $term_style_bg_grn
##  @property   $term_style_bg_ylw
##  @property   $term_style_bg_blu
##  @property   $term_style_bg_mga
##  @property   $term_style_bg_cyn
##  @property   $term_style_bg_wht
##

##  Set background color to light/bright black, red, green, yellow,
##  blue, magenta, cyan or white.
##
##  @property   $term_style_bg_blk_hi
##  @property   $term_style_bg_red_hi
##  @property   $term_style_bg_grn_hi
##  @property   $term_style_bg_ylw_hi
##  @property   $term_style_bg_blu_hi
##  @property   $term_style_bg_mga_hi
##  @property   $term_style_bg_cyn_hi
##  @property   $term_style_bg_wht_hi
##

colors=(                                                    \
    blk    red    grn    ylw    blu    mga    cyn    wht    \
    blk_hi red_hi grn_hi ylw_hi blu_hi mga_hi cyn_hi wht_hi \
)

for index in ${!colors[@]} ; do
    color="${colors[$index]}"
    eval "term_style_fg_${color}='$( tput setaf "${index}" )'"
    eval "term_style_bg_${color}='$( tput setab "${index}" )'"
done


##  If the current terminal is like an `xterm`, output a prompt escape-
##  sequence to set the terminal's status line (i.e. window title ).
##
##  See: http://invisible-island.net/ncurses/man/terminfo.5.html#h3-Status-Lines
##
##  @method     term_status_line
##
##  @param      title           The string to use as window title.
##
##  @return     {stdout}
##
function term_status_line
{
    ##  If this `${TERM}` is any `xterm`, assure `tput` that it is an
    ##  `xterm-pcolor` `${TERM}` so it can find those escape-sequences.
    ##
    is_xterm && printf '%s%s%s' "$(tput -Txterm-pcolor tsl)" "${1}" "$(tput -Txterm-pcolor fsl)"
}


##  A POSIX compliant `sed`; i.e. if `sed` is GNU `sed` then add
##  `--posix` to disable all GNU extensions.
##
##  @method     sed_posix
##
##  @return     {stdout}
##
if sed --posix l <<<'' &>/dev/null ; then
    alias sed_posix='sed --posix'
else
    alias sed_posix='sed'
fi

##  An according-to-specs `sed` "visually unambiguous form" invocation.
##
##  The Mac OS X version of `sed` has been found to not escape the
##  backslash character itself;
##
##  From `sed(1)`:
##
##  > (The letter ell.)  Write the pattern space to the standard
##  > output in a visually unambiguous form.  This form is as
##  > follows:
##  >
##  > ----------------- | ----
##  > `backslash`       | `\\`
##  > `alert`           | `\a`
##  > `form-feed`       | `\f`
##  > `carriage-return` | `\r`
##  > `tab`             | `\t`
##  > `vertical tab`    | `\v`
##  >
##  > Nonprintable characters are written as three-digit octal
##  > numbers (with a preceding backslash) for each byte in the
##  > character (most significant byte first).  Long lines are
##  > folded, with the point of folding indicated by displaying a
##  > backslash followed by a newline.  The end of each line is
##  > marked with a `$`.
##
##  If `sed` is GNU `sed` use the POSIX compliant invocation to
##  avoid unwanted line wrapping behaviour.
##
##  @method     sed_vuf
##
##  @return     {stdout}
##
if [[ $( sed -n l <<<'\' ) == '\$' ]] ; then
    alias sed_vuf='{ sed_posix '\''s/\\/\\\\/g'\'' | sed_posix -n l; }'
else
    alias sed_vuf='sed_posix -n l'
fi


##  Output the argument with all non-printable characters escaped to
##  printable form.
##
##  @method     escape
##
##  @param      arg
##
##  @return     {stdout}
##
function escape
{
    sed_vuf <<<"${1}" | sed_posix 's/\$$//'
}


##  If non-null, output the argument, with non-printable characters
##  escaped, wrapped in PROMPT escape-sequence start and -end markers;
##
##  Ensure any backslashes already present in the input do not get
##  escaped.
##
##  Otherwise output nothing.
##
##  @method     ps_esc
##
##  @param      arg
##
##  @return     {stdout}
##
function ps_esc
{
    [[ -n "${1:+1}" ]] && printf '\\[%s\\]' "$(escape "${1}")" | sed_posix 's/\\\\/\\/g'
}


##  See: https://www.gnu.org/software/bash/manual/bash.html#index-PROMPT_005fDIRTRIM
##
##  > If set to a number greater than zero, the value is used as the
##  > number of trailing directory components to retain when expanding
##  > the `\w` and `\W` prompt string escapes _\[...\]_.  Characters
##  > removed are replaced with an ellipsis.
##
##  @property   $PROMP_DIRTRIM
##  @default    3
##
PROMPT_DIRTRIM=3


##  Ensure a primary prompt that tells you where you are using color if
##  that appears to be supported.
##
##  See: https://www.gnu.org/software/bash/manual/bash.html#Controlling-the-Prompt
##
##  > When executing interactively, bash displays the primary prompt
##  > `${PS1}` when it is ready to read a command, and the secondary
##  > prompt `${PS2}` when it needs more input to complete a command.
##  > Bash allows these prompt strings to be customized by inserting a
##  > number of backslash-escaped special characters that are decoded
##  > as follows:
##  >
##  > --------------: | :------------------------------------------------
##  > `\a`            | an ASCII `bell` character (07)
##  > `\d`            | the date in `Weekday Month Date` format (e.g., `Tue May 26`)
##  > `\D{format}`    | the format is passed to `strftime(3)` and the result is inserted into the prompt string; an empty `format` results in a locale-specific time representation.  The braces are required
##  > `\e`            | an ASCII `escape` character (033)
##  > `\h`            | the hostname up to the first `.`
##  > `\H`            | the hostname
##  > `\j`            | the number of jobs currently managed by the shell
##  > `\l`            | the basename of the shell's terminal device name
##  > `\n`            | newline
##  > `\r`            | carriage return
##  > `\s`            | the name of the shell, the basename of `${0}` (the portion following the final slash)
##  > `\t`            | the current time in 24-hour `HH:MM:SS` format
##  > `\T`            | the current time in 12-hour `HH:MM:SS` format
##  > `\@`            | the current time in 12-hour `am/pm` format
##  > `\A`            | the current time in 24-hour `HH:MM` format
##  > `\u`            | the username of the current user
##  > `\v`            | the version of bash (e.g., 2.00)
##  > `\V`            | the release of bash, version + patch level (e.g., 2.00.0)
##  > `\w`            | the current working directory, with `${HOME}` abbreviated with a `tilde` (uses the value of the `${PROMPT_DIRTRIM}` variable)
##  > `\W`            | the basename of the current working directory, with `${HOME}` abbreviated with a `tilde`
##  > `\!`            | the history number of this command
##  > `\#`            | the command number of this command
##  > `\$`            | if the effective `UID` is `0`, a `#`, otherwise a `$`
##  > `\nnn`          | the character corresponding to the octal number `nnn`
##  > `\\`            | a backslash
##  > `\[`            | begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
##  > `\]`            | end a sequence of non-printing characters
##  >
##  > The command number and the history number are usually different:
##  > the history number of a command is its position in the history
##  > list, which may include commands restored from the history file
##  > _\[...\]_, while the command number is the position in the
##  > sequence of commands executed during the current shell session.
##  > After the string is decoded, it is expanded via parameter
##  > expansion, command substitution, arithmetic expansion, and quote
##  > removal, subject to the value of the `promptvars` shell option.
##
##  @property   $PS1
##
PS1_PRE=\
"$(ps_esc "$(term_status_line '\w')" )"\
'\n'\
"$(ps_esc "${term_style_fg_blk_hi}" )"\
'\t'\
' '\
"$(ps_esc "${term_style_fg_cyn}" )"\
"${debian_chroot:+($debian_chroot)}"\
'\u@\h'

PS1_POST=\
' '\
"$(ps_esc "${term_style_fg_ylw}" )"\
'\w'\
"$(ps_esc "${term_style_rst}" )"\
'\n\$ '

PS1="${PS1_PRE}${PS1_POST}"

##  If `__git_ps1` is available inject it into `${PROMPT_COMMAND}` for
##  a colorized git status summary according to `.bash_init_git`
##  definition.
##
##  See: https://www.gnu.org/software/bash/manual/bash.html#index-PROMPT_005fCOMMAND
##
##  > If set, the value is executed as a command prior to issuing each
##  > primary prompt.
##
##  @property   @PROMPT_COMMAND
##
if type -p __git_ps1 >&-; then

    PROMPT_COMMAND="$(command_inject "${PROMPT_COMMAND}" '__git_ps1 "${PS1_PRE}$(ps_esc "${term_style_rst}")" "${PS1_POST}"' )"
fi
