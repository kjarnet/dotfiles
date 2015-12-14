This folder contains vim plugins loaded with
[pathogen](https://github.com/tpope/vim-pathogen).

The plugins are contained in
[git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
to be easily updated while kept out of the dotfiles repo.

If the main repository wasn't cloned with the --recursive argument,
this folder contains only empty folders.
To get the submodules, you then have to do
`git submodule init`
to initialize the submodule, then
`git submodule update`
to actually fetch it.

To update a submodule you can run
`git pull`
as normal from the submodule directory,
or, to pull all submodules at once,
you can do
`git submodule update --remote`
in a parent directory.



