""
""  This is a mere baseline `.vimrc`.  It has been set up to run first
""  using the `${VIMINIT}` and `${MYVIMRC}` environment variables.
""
""  This file will ensure that the default `~/.vimrc`, if it exists,
""  will also get `source`-ed.
""

""  Contribute to ensuring full-stack utf-8-ness when creating new
""  files.
""
""  See:
""
""    * http://vimdoc.sourceforge.net/htmldoc/options.html#%27fileencoding%27
""    * http://vimdoc.sourceforge.net/htmldoc/mbyte.html#UTF-8
""
""  >   * `'fileencoding'` `'fenc'`
""  >
""  >     `string` (default: `""`)
""  >     local to buffer
""  >     {only available when compiled with the |+multi_byte| feature}
""  >
""  >     Sets the character encoding for the file of this buffer.
""  >
""  >     When `'fileencoding'` is different from `'encoding'`,
""  >     conversion will be done when writing the file.  For reading
""  >     see below.  When `'fileencoding'` is empty, the same value as
""  >     `'encoding'` will be used (no conversion when reading or
""  >     writing a file). Conversion will also be done when
""  >     `'encoding'` and `'fileencoding'` are both a Unicode encoding
""  >     and `'fileencoding'` is not utf-8.  That's because internally
""  >     Unicode is always stored as utf-8.
""  >
""  >     _**WARNING:** Conversion can cause loss of information!  When
""  >     `'encoding'` is `"utf-8"` or another Unicode encoding,
""  >     conversion is most likely done in a way that the reverse
""  >     conversion results in the same text.  When `'encoding'` is
""  >     not `"utf-8"` some characters may be lost!_
""  >
""  >     See `'encoding'` for the possible values.  Additionally,
""  >     values may be specified that can be handled by the converter,
""  >     see [`mbyte-conversion`](http://vimdoc.sourceforge.net/htmldoc/mbyte.html#mbyte-conversion ).
""  >
""  >     When reading a file `'fileencoding'` will be set from
""  >     `'fileencodings'`.  To read a file in a certain encoding it
""  >     won't work by setting `'fileencoding'`, use the [`++enc`](http://vimdoc.sourceforge.net/htmldoc/editing.html#++enc )
""  >     argument.  One exception: when `'fileencodings'` is empty the
""  >     value of `'fileencoding'` is used.  For a new file the global
""  >     value of `'fileencoding'` is used.
""  >
""  >     Prepending `"8bit-"` and `"2byte-"` has no meaning here, they
""  >     are ignored.  When the option is set, the value is converted
""  >     to lowercase.  Thus you can set it with uppercase values too.
""  >     `'_'` characters are replaced with `'-'`.  If a name is
""  >     recognized from the list for `'encoding'`, it is replaced by
""  >     the standard name.  For example `"ISO8859-2"` becomes
""  >     `"iso-8859-2"`.
""  >
""  >     When this option is set, after starting to edit a file, the
""  >     `'modified'` option is set, because the file would be
""  >     different when written.
""  >
""  >     Keep in mind that changing `'fenc'` from a modeline happens
""  >     AFTER the text has been read, thus it applies to when the
""  >     file will be written.  If you do set `'fenc'` in a modeline,
""  >     you might want to set `'nomodified'` to avoid not being able
""  >     to `:q`.
""  >
""  >     This option can not be changed when `'modifiable'` is off.
""
set fileencoding=utf-8


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27expandtab%27
""
""  >   * `'expandtab'` `'et'`
""  >
""  >     `boolean` (default `off`)
""  >     local to buffer
""  >
""  >     In `Insert` mode: Use the appropriate number of spaces to
""  >     insert a `<Tab>`.  Spaces are used in indents with the `>`
""  >     and `<` commands and when `'autoindent'` is on.  To insert a
""  >     real tab when `'expandtab'` is on, use `CTRL-V<Tab>`.
""  >
""  >     See also [`:retab`](http://vimdoc.sourceforge.net/htmldoc/change.html#:retab )
""  >     and [`ins-expandtab`](http://vimdoc.sourceforge.net/htmldoc/insert.html#ins-expandtab ).
""  >     **NOTE:** This option is reset when `'compatible'` is set.
""
set expandtab


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27hlsearch%27
""
""  >   * `'hlsearch'` `'hls'`
""  >
""  >     `boolean` (default `off`)
""  >     global
""  >
""  >     When there is a previous search pattern, highlight all its
""  >     matches.  The type of highlighting used can be set with the
""  >     `'l'` occasion in the `'highlight'` option.  This uses the
""  >     "Search" highlight group by default.  Note that only the
""  >     matching text is highlighted, any offsets are not applied.
""  >
""  >     See also: [`'incsearch'`](http://vimdoc.sourceforge.net/htmldoc/options.html#%27incsearch%27)
""  >     and [`:match`](http://vimdoc.sourceforge.net/htmldoc/pattern.html#:match).
""  >     When you get bored looking at the highlighted matches, you can
""  >     turn it off with [`:nohlsearch`](http://vimdoc.sourceforge.net/htmldoc/pattern.html#:nohlsearch).
""  >     As soon as you use a search command, the highlighting comes
""  >     back.
""  >
""  >     [`'redrawtime'`](http://vimdoc.sourceforge.net/htmldoc/options.html#%27redrawtime%27)
""  >     specifies the maximum time spent on finding matches.
""  >     When the search pattern can match an end-of-line, Vim will try
""  >     to highlight all of the matched text.  However, this depends on
""  >     where the search starts.  This will be the first line in the
""  >     window or the first line below a closed fold.  A match in a
""  >     previous line which is not drawn may not continue in a newly
""  >     drawn line.
""  >     **NOTE:** This option is reset when `'compatible'` is set.
""
set hlsearch


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27shiftwidth%27
""
""  >   * `'shiftwidth'` `'sw'`
""  >
""  >     `number` (default `8`)
""  >     local to buffer
""  >
""  >     Number of spaces to use for each step of (auto)indent.  Used
""  >     for [`'cindent'`](http://vimdoc.sourceforge.net/htmldoc/options.html#%27cindent%27 ),
""  >     [`>>`](http://vimdoc.sourceforge.net/htmldoc/change.html#%3e%3e ),
""  >     [`<<`](http://vimdoc.sourceforge.net/htmldoc/change.html#%3c%3c ),
""  >     etc.
""
set shiftwidth=4


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27smarttab%27
""
""  >   * `'smarttab'` `'sta'`
""  >
""  >     `boolean` (default `off`)
""  >     global
""  >
""  >     When on, a `<Tab>` in front of a line inserts blanks
""  >     according to `'shiftwidth'`.  `'tabstop'` or `'softtabstop'`
""  >     is used in other places.  A `<BS>` will delete a
""  >     `'shiftwidth'` worth of space at the start of the line.
""  >     When off, a `<Tab>` always inserts blanks according to
""  >     `'tabstop'` or `'softtabstop'`.  `'shiftwidth'` is only used
""  >     for shifting text left or right [`shift-left-right`](http://vimdoc.sourceforge.net/htmldoc/change.html#shift-left-right ).
""  >     What gets inserted (a `<Tab>` or spaces) depends on the
""  >     `'expandtab'` option.  Also see [`ins-expandtab`](http://vimdoc.sourceforge.net/htmldoc/insert.html#ins-expandtab ).
""  >     When `'expandtab'` is not set, the number of spaces is
""  >     minimized by using `<Tab>`s.
""  >     **NOTE:** This option is reset when `'compatible'` is set.
""
set smarttab


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27softtabstop%27
""
""  >   * `'softtabstop'` `'sts'`
""  >
""  >     `number` (default `0`)
""  >     local to buffer
""  >
""  >     Number of spaces that a `<Tab>` counts for while performing
""  >     editing operations, like inserting a `<Tab>` or using `<BS>`.
""  >     It "feels" like `<Tab>`s are being inserted, while in fact a
""  >     mix of spaces and `<Tab>`s is used.  This is useful to keep
""  >     the `'ts'` setting at its standard value of 8, while being
""  >     able to edit like it is set to `'sts'`.  However, commands
""  >     like `x` still work on the actual characters.
""  >     When `'sts'` is zero, this feature is off.
""  >     `'softtabstop'` is set to 0 when the `'paste'` option is set.
""  >     See also [`ins-expandtab`](http://vimdoc.sourceforge.net/htmldoc/insert.html#ins-expandtab ).
""  >     When `'expandtab'` is not set, the number of spaces is
""  >     minimized by using `<Tab>`s. The `L` flag in `'cpoptions'`
""  >     changes how tabs are used when `'list'` is set.
""  >     **NOTE:** This option is set to `0` when `'compatible'` is
""  >     set.
""
set softtabstop=4


""  See: http://vimdoc.sourceforge.net/htmldoc/options.html#%27tabstop%27
""
""  >   * `'tabstop'` `'ts'`
""  >
""  >     `number` (default `8`)
""  >     local to buffer
""  >
""  >     Number of spaces that a `<Tab>` in the file counts for.  Also
""  >     see [`:retab`](http://vimdoc.sourceforge.net/htmldoc/change.html#:retab )
""  >     command, and `'softtabstop'` option.
""  >
""  >     Note: Setting `'tabstop'` to any other value than `8` can
""  >     make your file appear wrong in many places (e.g., when
""  >     printing it).
""  >
""  >     There are four main ways to use tabs in Vim:
""  >
""  >       1. Always keep `'tabstop'` at `8`, set `'softtabstop'` and
""  >          `'shiftwidth'` to `4` (or 3 or whatever you prefer) and
""  >          use `'noexpandtab'`.  Then Vim will use a mix of tabs
""  >          and spaces, but typing `<Tab>` and `<BS>` will behave
""  >          like a tab appears every `4` (or `3`) characters.
""  >       2. Set `'tabstop'` and `'shiftwidth'` to whatever you
""  >          prefer and use `'expandtab'`.  This way you will always
""  >          insert spaces.  The formatting will never be messed up
""  >          when `'tabstop'` is changed.
""  >       3. Set `'tabstop'` and `'shiftwidth'` to whatever you
""  >          prefer and use a [`modeline`](http://vimdoc.sourceforge.net/htmldoc/options.html#modeline )
""  >          to set these values when editing the file again.  Only
""  >          works when using Vim to edit the file.
""  >       4. Always set `'tabstop'` and `'shiftwidth'` to the same
""  >          value, and `'noexpandtab'`.  This should then work (for
""  >          initial indents only) for any tabstop setting that
""  >          people use. It might be nice to have tabs after the
""  >          first non-blank inserted as spaces if you do this
""  >          though.  Otherwise aligned comments will be wrong when
""  >          `'tabstop'` is changed.
""
""  This file favors option 1 but also sets `'expandtab'`.
""
set tabstop=8


""  Enable syntax highlighting.
""
""  See: http://vimdoc.sourceforge.net/htmldoc/syntax.html#:syntax-enable
""
""  >   * `:syntax enable`
""  >
""  >     This command switches on syntax highlighting.
""  >
""  >     What this command actually does is to execute the command
""  >
""  >     ```vimL
""  >     :source $VIMRUNTIME/syntax/syntax.vim
""  >     ```
""  >
""  >     If the `VIM` environment variable is not set, Vim will try to
""  >     find the path in another way (see [`$VIMRUNTIME`](http://vimdoc.sourceforge.net/htmldoc/starting.html#$VIMRUNTIME )).
""  >     Usually this works just fine.  If it doesn't, try setting the
""  >     `VIM` environment variable to the directory where the Vim
""  >     stuff is located.  For example, if your syntax files are in
""  >     the `"/usr/vim/vim50/syntax"` directory, set `$VIMRUNTIME` to
""  >     `"/usr/vim/vim50"`.  You must do this in the shell, before
""  >     starting Vim.
""  >
""  >   * `:syntax on`
""  >
""  >     The `:syntax enable` command will keep your current color
""  >     settings.  This allows using `:highlight` commands to set
""  >     your preferred colors before or after using this command.  If
""  >     you want Vim to overrule your settings with the defaults,
""  >     use: `:syntax on`.
""
syntax on


""  See:
""
""    * http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype
""    * http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-plugin-on
""    * http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on
""    * http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-overview
""
""  >   * `:filetype on`
""  >
""  >     Each time a new or existing file is edited, Vim will try to
""  >     recognize the type of the file and set the `'filetype'`
""  >     option.  This will trigger the `FileType` event, which can be
""  >     used to set the syntax highlighting, set options, etc.
""  >
""  >     _\[...\]_
""  >
""  >   * `:filetype plugin on`
""  >
""  >     If filetype detection was not switched on yet, it will be as
""  >     well.  This actually loads the file `"ftplugin.vim"` in
""  >     `'runtimepath'`.  The result is that when a file is edited
""  >     its plugin file is loaded (if there is one for the detected
""  >     filetype). [filetype-plugin](http://vimdoc.sourceforge.net/htmldoc/usr_43.html#filetype-plugin )
""  >
""  >     _\[...\]_
""  >
""  >   * `:filetype indent on`
""  >
""  >     If filetype detection was not switched on yet, it will be as
""  >     well.  This actually loads the file `"indent.vim"` in
""  >     `'runtimepath'`.  The result is that when a file is edited
""  >     its indent file is loaded (if there is one for the detected
""  >     filetype). [indent-expression](http://vimdoc.sourceforge.net/htmldoc/indent.html#indent-expression )
""
filetype plugin indent on


""  Continue with the default `~/.vimrc` if that exists.
""
if filereadable( glob( "~/.vimrc" ))
    source ~/.vimrc
endif
