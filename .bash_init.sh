##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Assess whether this is a login shell
##
##  @method     is_login
##
##  @return     {status}    0 if this shell is a login shell.

function is_login
{
    shopt -q login_shell
}


##  Assess whether this is an interactive shell
##
##  @method     is_login
##
##  @return     {status}    0 if this shell is an interactive shell.

function is_interactive
{
    [[ "${-}" =~ i ]]
}


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
##  @return     {stdout}    The resolved canonical absolute path to the
##                          given `${path}`.
##
hash realpath 2>/dev/null                           \
    ||  {
        readlink -f . 2>/dev/null                   \
    &&  function realpath { readlink -f "$@{}" ; }  \
    ||  {
        greadlink -f . 2>/dev/null                  \
    &&  function realpath { greadlink -f"${@}" ; }  \
    ||  function realpath { python -c 'import os,sys; print( os.path.realpath( sys.argv[ 2 if sys.argv[1] == "--" else 1 ] ))' "${@}" ; }
    }
}


##  Output the canonical absolute path to the containing directory of
##  the current script.
##
##  @method     self_dir
##
##  @return     {stdout}    The canonical absolute path to the
##                          containing directory of the currently
##                          executing script.
##
function self_dir
{
    ##  `${BASH_SOURCE[0]}` contains the path to this script's file as
    ##  it was invoked.
    ##
    ##  See: https://www.gnu.org/software/bash/manual/bashref.html#index-BASH_005fSOURCE
    ##
    ##  > An array variable whose members are the source filenames
    ##  > where the corresponding shell function names in the
    ##  > `FUNCNAME` array variable are defined. The shell function
    ##  > `${FUNCNAME[$i]}` is defined in the file `${BASH_SOURCE[$i]}`
    ##  > and called from `${BASH_SOURCE[$i+1]}`.
    ##
    ##  It could be a relative path; elements of the path could be
    ##  symbolic links; it could be a symbolic link itself.
    ##
    dirname -- "$( realpath -- "${BASH_SOURCE[0]}" )"
}


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
IX_HOME="$( self_dir )"


##  Kick-start everything else.
##
source_all $( shopt -s nullglob; printf '%s ' "${IX_HOME}/.bash_init_"*".sh" )
