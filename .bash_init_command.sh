##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##


##  Normalize whitespace.
##
##  Output the positional parameters separated by one space each.
##
##  @method     nws
##
##  @param      ...arg
##
##  @return     {stdout}
##
function nws
(
    printf '%s' "${*}"
)

##  Safely append commands to an existing command-value if it does not
##  already appear to exist in there.  Each command if appended will be
##  separated from any existing non-empty value by a ';'.
##
##  @method     command_inject
##
##  @param      command     The command value to modify
##  @param      ...inject   The commands to inject
##
##  @return     {stdout}    The altered `${command}` argument.
##
function command_inject
{
    local command inject

    command="$( nws ${1} )"; shift

    for inject in "${@}" ; do

        inject="$( nws $inject )"

        [[ ${command} != *"${inject}"* ]] && command="${command};${inject}"

    done

    printf '%s' "${command#;}"
}
