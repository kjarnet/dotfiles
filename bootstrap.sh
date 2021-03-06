#!/usr/bin/env bash
#
# bootstrap installs things.

DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ] && [ -f git/gitconfig.symlink.example ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail
    user ' - What is your work git email?'
    read -e git_workemail
    user ' - What is the name of your work folder?'
    read -e git_workfolder

    sed -e "s/AUTHORNAME/$git_authorname/g"\
	    -e "s/AUTHOREMAIL/$git_authoremail/g"\
	    -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g"\
	    -e "s/WORKFOLDER/$git_workfolder/g"\
	    git/gitconfig.symlink.example > git/gitconfig.symlink

    [[ -d $HOME/$git_workfolder ]] || mkdir $HOME/$git_workfolder
    echo -e "[user]\n  email = $git_workemail" > $HOME/$git_workfolder/.gitconfig

    success 'gitconfig set up'
  fi
}

setup_other () {
  if ! [ -f zsh/favfolder.zsh ] && [ -f zsh/favfolder.zsh.example ]
  then
    info 'set favorite folder'

    user ' - What is your favorite folder?'
    read -e favoritefolder

    escaped_favfolder=$(printf '%s\n' "$favoritefolder" | sed -e 's/[\/&]/\\&/g')
    sed -e "s/FAVFOLDER/${escaped_favfolder}/g"\
	    zsh/favfolder.zsh.example > zsh/favfolder.zsh

    success 'favorite folder set'
  fi
}


link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
  
  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.config-symlink' -not -path '*.git*')
  do
    [[ -d $HOME/.config ]] || mkdir $HOME/.config
    dst="$HOME/.config/$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

setup_gitconfig
setup_other
install_dotfiles

echo ''
echo '  All installed!'
