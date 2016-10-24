##
##  Please ensure that any changes this file makes to the environment
##  are done idempotently.
##

##
##  Recursive command line side-by-side diff and helpers.
##

##  Only when this is an interactive shell.
##
is_interactive || return


##  Output the terminal's current column width.
##
##  @method     term_width
##
##  @return     {stdout}
##
alias term_width='tput cols'


##  Recursive side-by-side `diff -ry` output post-processed to
##  highlight _only_ what changed.
##
##  Adjusts output to the available terminal width.
##
##  Ignores these patterns by default:
##
##    * `.DS_store`
##    * `.git`
##    * `.m2`
##    * `.npm`
##    * `.sass-cache`
##    * `.svn`
##    * `dist`
##    * `node_modules`
##
##  Note that the `diff` command will unhesitatingly accept option
##  parameters presented after its path arguments; this tool however
##  will just get confused.
##
##  @method     diffr
##
##  @param      ...option   options to pass on to `diff`
##
##  @param      path1       first path argument to pass on to `diff`
##  @param      path2       second path argument to pass on to `diff`
##
##                          `path1` and `path2` are either two files or
##                          two directories.
##
##  @return     {stdout}    pipe this to `dless`
##
function diffr ()
{
    if [[ "${#}" -lt 2 || -z "${@: -2:1}" || -z "${@: -1:1}" ]] ; then

        echo "Need at least two non-empty arguments" >&2
        return 1
    fi


    ##  See: https://www.gnu.org/software/diffutils/manual/diffutils.html#diff-Options
    ##
    ##      Note however that your system's version may vary.
    ##
    ##  >   * `-d` / `--minimal`
    ##  >
    ##  >     Try hard to find a smaller set of changes.
    ##  >
    ##  >   * `-r` / `--recursive`
    ##  >
    ##  >    Recursively compare any subdirectories found.
    ##  >
    ##  >   * `-s` / `--report-identical-files`
    ##  >
    ##  >     Report when two files are the same.
    ##  >     With `-y`, identical files are still shown, though not
    ##  >     reported as such.
    ##  >
    ##  >   * `--strip-trailing-cr`
    ##  >
    ##  >     Strip trailing carriage return on input.
    ##  >
    ##  >   * `-t` : --expand-tabs
    ##  >
    ##  >     Expand tabs to spaces in output.
    ##  >     Tabs mess up side-by-side diffs. Just pray that tabs were
    ##  >     used for the default 8 stops.
    ##  >
    ##  >   * `-w` : --ignore-all-space
    ##  >
    ##  >     Ignore all white space.
    ##  >
    ##  >   * `-W `_`<NUM>`_ / `--width=`_`<NUM>`_
    ##  >
    ##  >     Output at most `<NUM>` (default 130) print columns.
    ##  >
    ##  >   * `-x`_`<PAT>` / `--exclude=`_`<PAT>`_
    ##  >
    ##  >     Exclude files that match `<PAT>`.
    ##  >
    ##  >   * `-y` : --side-by-side
    ##  >
    ##  >     Output in two columns.
    ##
    local opts=(            \
        --strip-trailing-cr \
        -drstwy             \
        -W "$(term_width)"  \
                            \
        -x .DS_store        \
        -x .git             \
        -x .m2              \
        -x .npm             \
        -x .sass-cache      \
        -x .svn             \
        -x dist             \
        -x node_modules     \
    )

    ##  Pass identical arguments to both `diff` and `perl` so the perl
    ##  script will know how `diff` was invoked.
    ##
    \diff "${opts[@]}" "${@}" | perl -e '

        use strict;
        use warnings;

        use Term::ANSIColor;

        ##  The path arguments to the `diff` command as regexes.
        ##
        my $src     = $ARGV[-2];
        my $src_re  = qr{ \Q$src\E }xo;

        my $dst     = $ARGV[-1];
        my $dst_re  = qr{ \Q$dst\E }xo;

        ##  Derive width of one column; (term-width - gutter) div 2.
        ##
        my $column  = ( ( grep( /-W/...//, @ARGV ))[1] - 3 ) >> 1;

        ##  Styling sequences;
        ##
        my $red     = color( "reset red" );
        my $grn     = color( "reset green" );
        my $blu     = color( "reset blue" );
        my $mga     = color( "reset magenta" );
        my $cyn     = color( "reset cyan" );
        my $rst     = color( "reset" );

        my $sto     = color( "bold on_bright_yellow" );

        sub highlight
        {
            my ( $path, $buf ) = (@_);

            ##  Reconstruct and print colorized report line, prepending
            ##  a heading new line.
            ##
            print(
                "\n"
            ,   $mga,  "diff "
            ,   $red,  $src, $sto, $path
            ,   $mga,  " "
            ,   $grn,  $dst, $sto, $path
            ,   $rst
            ,   "\n"
            );

            ##  Output colorized differences.
            ##
            for ( @$buf )
            {
                print, next unless ( m{ ^ ( .{$column} [ ] ) ( [(</|\\>)] ) ( (?: [ ] .* )? \n ) }xomg );

                my( $src, $sign, $dst ) = ( $1, $2, $3 );

                for ( $sign )
                {
                    print(       $src, $grn, $sign,       $dst, $rst ), last if m{ [>)] }x;
                    print( $red, $src,       $sign, $rst, $dst       ), last if m{ [(<] }x;
                    print( $cyn, $src,       $sign,       $dst, $rst ), last if m{ [/|\\] }x;
                }
            }

            ##  Output a separating extra new line.
            ##
            print( "\n" );

            return;
        }

        ##  Because of files without a trailing newline at their EOF,
        ##  the report lines that `diff` outputs may not always start
        ##  at a new line; so the r.e. below does not require this.
        ##
        my $m_diff =
            qr{
                (d)iff
                \ .*?
                \ ${src_re} ( .*? )
                \ ${dst_re} \g{-1}
                \n
            }x
        ;
        my $m_src_only =
            qr{
                (O)nly\ in
                \ ${src_re} ( .*? ) :
                \ ( [^/\n]+ )
                \n
            }x
        ;
        my $m_dst_only =
            qr{
                Onl(y)\ in
                \ ${dst_re} ( .*? ) :
                \ ( [^/\n]+ )
                \n
            }x
        ;
        my $m_binary =
            qr{
                (B)inary\ files
                \ ${src_re} ( .*? )
                \ and
                \ ${dst_re} \g{-1}
                \ differ
                \n
            }x
        ;
        my $m_files =
            qr{
                (F)iles
                \ ${src_re} ( .*? )
                \ and
                \ ${dst_re} \g{-1}
                \ are\ identical
                \n
            }x
        ;
        my $matcher =
            (
                length( $src ) > length( $dst )
            ?   qr{ (?| $m_src_only | $m_dst_only | $m_binary | $m_files | $m_diff ) }x
            :   qr{ (?| $m_dst_only | $m_src_only | $m_binary | $m_files | $m_diff ) }x
            )
        ;

        my ( $type, $path, $file ) = ( "d", "", "" );

        my @buf;

        while ( <STDIN> )
        {
            push( @buf, $_ ), next unless ( m{ ${matcher} }xomg );

            if ( "F" eq $1 && $path eq $2 )
            {
                ##  Diff betweeen identical files, skip.
                ##
                @buf = ();
                next;
            }

            if ( $-[0] != 0 )
            {
                ##  The report line did not begin at line start.
                ##  I.e., the last line of some file omitted a trailing
                ##  newline.
                ##
                push( @buf, substr( $_, 0, $-[0] ) . "\n" );
            }

            if ( @buf )
            {
                highlight( $path, \@buf );
                @buf = ();
            }

            ( $type, $path, $file ) = ( $1, $2, $3 );

            if ( "B" eq $type )
            {
                ##  Reconstruct and print colorized report line
                ##
                print(
                    $mga,  "Binary files "
                ,   $red,  $src, $sto, $path
                ,   $mga,  " and "
                ,   $grn,  $dst, $sto, $path
                ,   $mga,  " differ"
                ,   $rst
                ,   "\n"
                );
            }
            elsif ( "O" eq $type )
            {
                ##  Reconstruct and print colorized report line
                ##
                print(
                    $blu,  "Only in "
                ,   $red,  $src, ": ", $sto, ( $path ? ( $path, "/" ) : () ), $file
                ,   $rst
                ,   "\n"
                );
            }
            elsif ( "y" eq $type )
            {
                ##  Reconstruct and print colorized report line
                ##
                print(
                    $blu,  "Only in "
                ,   $grn,  $dst, ": ", $sto, ( $path ? ( $path, "/" ) : () ), $file
                ,   $rst
                ,   "\n"
                );
            }
        }

        ##  This is either the last- _and_ a `diff` report line, _or_
        ##  the `diff` command was on files instead of directories and
        ##  so no report line was ever found.
        ##
        highlight( $path, \@buf ) if @buf;

    ' -- "${opts[@]}" "${@}"
}


##  Pagination with an apt search pattern for `diffr` output.
##
##  @method     dless
##
##  @param      ...option   options to pass on to `less`
##
##  @return     {stdout}
##
function dless ()
{
    local column=$(( ( $(term_width) - 3 ) / 2 ))

    less -j5 -Rp "^.{${column}} ([/|\\\\]( .*)?|[(<])\$|^ {${column}} [>)]( .*)?\$|^Only in .*|^Binary files .*" "$@"
}
