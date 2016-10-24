##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Enable extended path globbing for niftier patterns.
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-shopt (scroll down)
##
##  > If set, the extended pattern matching features described above
##  > (see Pattern Matching) are enabled.
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching
##
##  @property   shopt.extglob
##  @default    on
##
shopt -s extglob


##  Allow `**` in filename expansion if the `bash` supports it.
##
##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-shopt (scroll down)
##
##  > If set, the pattern `**` used in a filename expansion contexti
##  > will match all files and zero or more directories and
##  > subdirectories.  If the pattern is followed by a ‘/’, only
##  > directories and subdirectories match.
##
##  @property   shopt.globstar
##  @default    on
##
[[ "$(shopt -p)" == *globstar* ]] && shopt -s globstar


