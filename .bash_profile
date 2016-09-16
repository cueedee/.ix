##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Output the resolved canonical absolute path to a given path.
##
##  This is either the real command, or one of number of possible
##  shims, ultimately falling back to a simpler `python` implementation
##  that suffices for our needs.
##
##  If `python` is not available either, or should you have a need for
##  the real thing then consider one of:
##
##    * `sudo apt-get install coreutils`
##    * `brew install coreutils`
##
##  @method     realpath
##
##  @param      path        The path to resolve.
##
##  @return                 The resolved canonical absolute path to the
##                          given `${path}`.
##
hash realpath 2>/dev/null               \
    ||  {
        readlink -f . 2>/dev/null       \
    &&  alias realpath='readlink -f'    \
    ||  {
        greadlink -f . 2>/dev/null      \
    &&  alias realpath='greadlink -f'   \
    ||  alias realpath='python -c '\''import os,sys; print( os.path.realpath( sys.argv[ 2 if sys.argv[1] == "--" else 1 ] ))'\'
    }
}


##  Output the canonical absolute path to the containing directory of
##  the current script.
##
##  @method     self_dir
##
##  @return                 The canonical absolute path to the
##                          containing directory of the currently
##                          executing script.
##
function self_dir
(
    ##  `${BASH_SOURCE}` contains the path to this script's file as it
    ##  was invoked.
    ##
    ##  It could be a relative path; it could be a path to a symbolic
    ##  link.
    ##
    dirname -- "$( realpath -- "${BASH_SOURCE[0]}" )"
)


##  Execute `source "${path}"` for each argument.
##
##  @method     source_all
##
##  @param      ...path     All the files to `source`.
##
function source_all
{
    local i

    for i in "${@}" ; do
        source -- "${i}"
    done
}

##  Declare the directory where this file resides.
##
##  @property   $IX_HOME
##
export IX_HOME="$( self_dir )"


##  Kick-start everything else.
##
source_all $( shopt -s nullglob; echo "${IX_HOME}/.bash_profile_"* )
