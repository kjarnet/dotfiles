# Kjarnet's Dotfiles

These are my dotfiles, mostly copied from [holman](https://github.com/holman/dotfiles) (including most of this readme).
Notable changes from holman's project include:

 * removed dependencies to homebrew
 * removed most zsh stuff and use [antigen](http://antigen.sharats.me) instead

## Dependencies

 * git
 * zsh
 * vim

## Install

Run this:

```sh
git clone --recursive https://github.com/kjarnet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
chsh -s $(which zsh)
```

The `--recursive` argument is for cloning all git submodules as well.
Submodules are used for vim pathogen plugins.
You can read more about that [here](vim/vim.symlink/bundle/README.md).

Note that this will also install nvm (node version manager) through
[zsh-nvm](https://github.com/lukechilds/zsh-nvm).

You then need to install node with

```sh
nvm install node
# or
nvm install --lts
# or
nvm install <version>
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
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **zsh/\*.zsh**: Any files ending in `.zsh` get loaded by zshrc.


