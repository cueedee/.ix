##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Only when this is an interactive shell.
##
is_interactive || return


##  Declare the default pager utility to use.
##
##  @property   env.$PAGER
##  @default    less
##
export PAGER='less'


##  Options which are passed to less automatically.
##
##  > * `-R` or `--RAW-CONTROL-CHARS`
##  >
##  >   Like `-r`, but only ANSI "color" escape sequences are output in
##  >   "raw" form.  Unlike -r, the screen appearance is maintained
##  >   correctly in most cases.  ANSI "color" escape sequences are
##  >   sequences of the form:
##  >
##  >   ```
##  >   ESC [ ... m
##  >   ```
##  >
##  >   where the `...` is zero or more color specification characters.
##  >   For the purpose of keeping track of screen appearance, ANSI
##  >   color escape sequences are assumed to not move the cursor.  You
##  >   can make less think that characters other than `m` can end ANSI
##  >   color escape sequences by setting the environment variable
##  >   `LESSANSIENDCHARS` to the list of characters which can end a
##  >   color escape sequence.  And you can make less think that
##  >   characters other than the standard ones may appear between the
##  >   `ESC` and the `m` by setting the environment variable
##  >   `LESSANSIMIDCHARS` to the list of characters which can appear.
##  >
##  > * `-i` or `--ignore-case`
##  >
##  >   Causes searches to ignore case; that is, uppercase and
##  >   lowercase are considered identical.  This option is ignored if
##  >   any uppercase letters appear in the search pattern; in other
##  >   words, if a pattern contains uppercase letters, then that
##  >   search does not ignore case.
##  >
##  > * `-jn` or `--jump-target=n`
##  >
##  >   Specifies a line on the screen where the "target" line is to be
##  >   positioned.  The target line is the line specified by any
##  >   command to search for a pattern, jump to a line number, jump to
##  >   a file percentage or jump to a tag.  The screen line may be
##  >   specified by a number: the top line on the screen is 1, the
##  >   next is 2, and so on.  The number may be negative to specify a
##  >   line relative to the bottom of the screen: the bottom line on
##  >   the screen is -1, the second to the bottom is -2, and so on.
##  >   Alternately, the screen line may be specified as a fraction of
##  >   the height of the screen, starting with a decimal point: .5 is
##  >   in the middle of the screen, .3 is three tenths down from the
##  >   first line, and so on.  If the line is specified as a fraction,
##  >   the actual line number is recalculated if the terminal window
##  >   is resized, so that the target line remains at the specified
##  >   fraction of the screen height.  If any form of the -j option is
##  >   used, forward searches begin at the line immediately after the
##  >   target line, and backward searches begin at the target line,
##  >   unless changed by `-a` or `-A`.  For example, if `-j4` is used,
##  >   the target line is the fourth line on the screen, so forward
##  >   searches begin at the fifth line on the screen.
##
##  @property   env.$LESS
##  @default    '-Rij5'
##
export LESS='-Rij5'
