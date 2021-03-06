##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Declare the default editor utility to use.
##
##  @property   env.$EDITOR
##  @default    vim
##
##  @property   env.$VISUAL
##  @default    vim
##
export EDITOR=vim
export VISUAL="${EDITOR}"


##  Ensure vim read this directory's `.vimrc`.
##
##  This two-stage approach ensures that any special characters in the
##  `${IX_HOME}/.vimrc` path will not cause harm.
##
export MYVIMRC="${IX_HOME}/.vimrc"
export VIMINIT='source $MYVIMRC'


##  `vimdiff` shortcut
##
alias vd=vimdiff
