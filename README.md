# .ix
My distributable, normalized and annotated \*nix shell environment initialization config - i.e., my "dotfiles".

-----------------------------------------------------------------------

## About `bash` initialization

[tl;dr](#setup)

From [the GNU bash manual](https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files):

> When bash is invoked as an _**interactive login** shell_, or as a _**non-interactive** shell **with the `--login` option**_, *\[...\]* it looks for `~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and reads and executes commands from the first one that exists and is readable.
> *\[...\]*
> When an _**interactive** shell that is **not a login** shell_ is started, bash reads and executes commands from `~/.bashrc`, if that file exists.

Disregarding name variants and the exact conditions that make a shell a login- or interactive shell, the above descriptions boil down to this mapping:

interactive: | login:  | initializations read from:
:----------: | :-----: | :-------------------------
   `true`    | `true`  | `~/.bash_profile`
   `false`   | `true`  | `~/.bash_profile`
   `true`    | `false` | `~/.bashrc`


### _Where will I put initializations that need to run either when the shell is only a login shell, only an interactive shell, or both? (#1)_

If we take no other measures, we really have no other choice than to put them in _both_ files; which isn't particularly [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself).

_What if we'd `source ~/.bashrc` from `~/.bash_profile`, similar to what [the bash manual suggests we'd do](https://www.gnu.org/software/bash/manual/bash.html#Invoked-as-an-interactive-non_002dlogin-shell)?_

```bash
[[ -f ~/.bashrc ]] && source ~/.bashrc
```

The mapping would then become:

interactive: | login:  | initializations read from:
:----------: | :-----: | :-------------------------------
   `true`    | `true`  | `~/.bash_profile`<br>`~/.bashrc`
   `false`   | `true`  | `~/.bash_profile`<br>`~/.bashrc`
   `true`    | `false` |                      `~/.bashrc`

and we can put these initializations in our `~/.bashrc` to have them run in either case.


### _But where will I put initializations that need to run when the shell is only an interactive shell? (#2)_

Before we dealt with [question #1][Q1] this one had an easy answer, but now we can't really put these anywhere, can we? Not unless we take additional measures.

_What if we'd test whether the shell is a **login** shell and bisect `~/.bashrc` initializations based on the outcome?_

```bash
if shopt -q login_shell; then
    ##  is-login
    ...
else
    ##  is-not-login
    ...
fi
```

Then the mapping would look like:

interactive: | login:  | initializations read from:
:----------: | :-----: | :------------------------------------------------
   `true`    | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_
   `false`   | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_
   `true`    | `false` |                      `~/.bashrc`_`#is-not-login`_

and it's easy to see where these initializations should now go.


### _Where will I now put initializations that need to run either when the shell is only a login shell, only an interactive shell, or both? (#3)_

Well spotted! We just broke the solution for [question #1][Q1].

_What about we leave a common section in addition to bisecting `~/.bashrc`?_

```bash
if shopt -q login_shell; then
    ##  is-login
    ...
else
    ##  is-not-login
    ...
fi

##  is-either
...
```

Then the mapping would look like:

interactive: | login:  | initializations read from:
:----------: | :-----: | :-----------------------------------------------------------------------------
   `true`    | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_    <br>`~/.bashrc`_`#is-either`_
   `false`   | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_    <br>`~/.bashrc`_`#is-either`_
   `true`    | `false` |                      `~/.bashrc`_`#is-not-login`_<br>`~/.bashrc`_`#is-either`_


### Have we got it covered?

Let's see...

initialization kind    | where it should go
---------------------- | -----------------------------------
login-shell only       | `~/.bash_profile`
interactive-shell only | `~/.bashrc`_`#is-not-login`_
either (or both)       | `~/.bashrc`_`#is-either`
both only              | `~/.bashrc`_`#is-logi`...wait, no!_

Initializations in `~/.bashrc`_`#is-login`_ will _also_ run when the shell is _only_ a _**login** shell_.

_How about we test on the shell's interactive-ness too?_

```bash
if shopt -q login_shell; then
    if [[ $"{-}" =~ 'i' ]] ; then
        ##  is-login && is-interactive
        ...
    else
        ##  is-login && is-not-interactive
        ...
    fi
    ##  is-login, regardless
    ...
else
    ##  is-not-login
    ...
fi

##  is-either
...
```

_That would certainly "work", but..._

interactive: | login:  | initializations read from:
:----------: | :-----: | :---------------------------------------------------------------------------------------------------------------
   `true`    | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_<br>`~/.bashrc`_`#is-interactive`_    <br>`~/.bashrc`_`#is-either`_
   `false`   | `true`  | `~/.bash_profile`<br>`~/.bashrc`_`#is-login`_<br>`~/.bashrc`_`#is-not-interactive`_<br>`~/.bashrc`_`#is-either`_
   `true`    | `false` |                      `~/.bashrc`_`#is-not-login`_                                  <br>`~/.bashrc`_`#is-either`_


### _Will you remember_ any _of this when you have to modify these initializations, years, month or even weeks from now?_

There was a reason for writing all of this down :).


### _Uhm, is there actually a need for keeping a separate `~/.bash_profile` now?_

Um, not really, no...


### _Wouldn't it be easier to have just a single initialization file to replace both `~/.bash_profile`_ and _`~/.bashrc` and have initializations decide for themselves when they should be run? <br>You could even bundle in a few test functions to help with that._

Welcome to **[.ix](#setup)**!

[Q1]: #where-will-i-put-initializations-that-need-to-run-either-when-the-shell-is-only-a-login-shell-only-an-interactive-shell-or-both-1
[Q2]: #but-where-will-i-put-initializations-that-need-to-run-when-the-shell-is-only-an-interactive-shell-2
[Q3]: #where-will-i-now-put-initializations-that-need-to-run-either-when-the-shell-is-only-a-login-shell-only-an-interactive-shell-or-both-3

-----------------------------------------------------------------------

## Setup

Check out .ix into `~/.ix`; e.g.:

```bash
$ git clone https://github.com/cueedee/.ix.git ~/.ix
```


### ...as needed

Manual invocation whenever deemed appropriate is always possible.

```bash
$ source ~/.ix/.bash_init.sh
```

All initializations are idempotent.  It doesn't matter if they are invoked once or many times over.


### ...once and for all

*Either* inject this line wherever you see fit into your `~/.bash_profile`, your  `~/.bashrc`, or both:

```bash
source ./.ix/.bash_init.sh
```

*Or*, if you have no additional local initializations to perform, simply use `~/.ix/.bash_init.sh` as a direct substitute for either your `~/.bash_profile`, your  `~/.bashrc`, or both:

```bash
$ ln -s ./.ix/.bash_init.sh ~/.bash_profile
$ ln -s ./.ix/.bash_init.sh ~/.bashrc
```

As [discussed above](#about-bash-initialization), it makes sense to have a single initialization file to function as both `~/.bash_profile` as well as `~/.bashrc`.

If somehow you'd like to stick with having two separate files, traditionally `source`-ing your `~/.bashrc` from your `~/.bash_profile` and still like to benefit from the `.ix` config, then that is certainly possible; the `.ix` initializations are idempotent so it doesn't really matter if they are done twice.

If however you think that's wasteful, you could arrange to avoid that yourself; e.g.:

  * **`~/.bash_profile`** :

    ```bash
    source ~/.ix/.bash_init.sh
    ...
    __IX_DID_RUN=1 source ~/.bashrc
    ```

  * **`~/.bashrc`** :

    ```bash
    [[ -z "${__IX_DID_RUN:+1}" ]] && source ~/.ix/.bash_init.sh
    ```

-----------------------------------------------------------------------

## Further reading

  * `rbenv`'s comprehensive [unix shell initialization](https://github.com/rbenv/rbenv/wiki/Unix-shell-initialization) guide.
