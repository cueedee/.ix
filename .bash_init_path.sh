##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  A duplication-aware `${PATH}`-like value transformer.
##
##  Output the `${path}` argument from which each `${item}` argument is
##  removed in order and subsequently appended or prependend back in if
##  so instructed.
##
##  Caveat: If the `${path}` value contains any empty items, they'll
##  get removed.
##
##  @method     path_mod
##
##  @param      path        The `${PATH}`-like value to modify
##  @param      ...item     Items to remove and optionally re-inject:
##                            * A leading ':' instructs to prepend;
##                            * A trailing ':' instructs to append;
##
##  @return     {stdout}    The altered `${path}`.
##
function path_mod
(
    local item path

    ##  Needed for fancier patterns.
    ##
    shopt -s extglob

    ##  Ensure the temporary working `${path}` has leading and trailing
    ##  colons to ease manipulation hereafter.
    ##  Ensure it doesn't have any colon duplications.
    ##
    path=":${1}:"; shift
    path="${path//:+(:)/:}"

    ##  Process any item arguments in order; removing first, then
    ##  prepending or appending it back in, if so instructed.
    ##
    for item in "$@" ; do
        case "${item}" in
            :*)
                path="${item}${path//${item}:/:}"
                ;;

            *:)
                path="${path//:${item}/:}${item}"
                ;;

            *)
                path="${path//:${item}:/:}"
                ;;
        esac
    done

    ##  Remove the leading and trailing colons added earlier, returning
    ##  the final result.
    ##
    path="${path#:}"
    printf '%s' "${path%:}"
)

##  Items of `${PATH}` after this, in order:
##
##    * `${IX_HOME}/bin`
##    * `/usr/local/bin`
##    * Items of `${PATH}` excluding the ones listed.
##
##  https://www.gnu.org/software/bash/manual/bashref.html#index-PATH
##
##  @property   env.$PATH
##
export PATH=$( path_mod "${PATH}"   \
                                    \
    :/usr/local/bin                 \
    :"${IX_HOME}"/bin               \
)
