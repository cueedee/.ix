# .ix
My distributable common *nix shell enviroment config.

## Setup

Check out .ix into `~/.ix`. Eg:

```bash
$ git clone https://github.com/cueedee/.ix.git ~/.ix
```

### Either once and for all

Either inject this line into your own `~/.bash_profile` wherever you see fit:

```bash
source ./.ix/.bash_profile
```

Or simply use `~/.ix/.bash_profile` as a direct substitute:

```bash
$ cd ~ && ln -s ./.ix/.bash_profile .
```

### Or on an as needed basis

Resort to manually invocation at the appropriate time if all of the above methods are deemed too intrusive:

```bash
$ source ~/.ix/.bash_profile
```
