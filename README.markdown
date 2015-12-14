# Kjarnet's Dotfiles

These are my dotfiles, mostly copied from [holman](https://github.com/holman/dotfiles) (including most of this readme).
Notable changes from holman's project include:

 * removed dependencies to homebrew
 * removed some mac and ruby-dev-stuff and added some linux and java-dev files.

## Dependencies

 * git
 * zsh
 * ruby (install with [rvm](https://rvm.io/rvm/install/)
and if rvm doesn't work in e.g. gnome-terminal, enable login-shell (see [faq](https://rvm.io/support/faq/))).

## Install

Run this:

```sh
git clone --recursive https://github.com/kjarnet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```

The `--recursive` argument is for cloning all git submodules as well.
Submodules are used for vim pathogen plugins.
You can read more about that [here](vim/vim.symlink/bundle/README.md).

To enable Tern.js vim-plugin,
you need to also have node and npm installed.
For ubuntu, do:

```sh
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

```

and then do this additional step:

```sh
cd ~/.dotfiles/vim/vim.symlink/bundle/tern_for_vim
npm install
```

## Contents

There are a few special files in the hierarchy.

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


