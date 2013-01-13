# kjarnet's dotfiles

These are my dotfiles, mostly copied from [holman](https://github.com/holman/dotfiles) (including most of this readme).
Notable changes from holman's project include:

 * remove dependencies to homebrew
 * remove some mac and ruby-dev-stuff and add some linux and java-dev files.

## dependencies

 * git
 * zsh
 * ruby (install with [rvm](https://rvm.io/rvm/install/)
and if rvm doesn't work in e.g. gnome-terminal, enable login-shell (see [faq](https://rvm.io/support/faq/))).

## install

Run this:

```sh
git clone https://github.com/kjarnet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```
## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.

## add-ons

There are a few things I use to make my life awesome. They're not a required
dependency, but if you install them they'll make your life a bit more like a
bubble bath.

- If you want some more colors for things like `ls`, install grc: `sudo apt-get install
  grc`. (There was also a config-script for this that I've deleted - kjarnet).
- If you install the excellent [rbenv](https://github.com/sstephenson/rbenv) to
  manage multiple rubies, your current branch will show up in the prompt. Bonus.

