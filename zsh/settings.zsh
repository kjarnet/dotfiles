bindkey -v
setopt globdots

# Indicate vim mode
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=2\C-G";;  # underscore cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

echo "applied settings"

