#
# Colors
#

__WINCENT[BASE16_CONFIG]=$NVIM/.base16

# Takes a hex color in the form of "RRGGBB" and outputs its luma (0-255, where
# 0 is black and 255 is white).
#
# Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colors
luma() {
    emulate -L zsh

    local COLOR_HEX=$1

    if [ -z "$COLOR_HEX" ]; then
        echo "Missing argument hex color (RRGGBB)"
        return 1
    fi

    # Extract hex channels from background color (RRGGBB).
    local COLOR_HEX_RED=$(echo "$COLOR_HEX" | cut -c 1-2)
    local COLOR_HEX_GREEN=$(echo "$COLOR_HEX" | cut -c 3-4)
    local COLOR_HEX_BLUE=$(echo "$COLOR_HEX" | cut -c 5-6)

    # Convert hex colors to decimal.
    local COLOR_DEC_RED=$((16#$COLOR_HEX_RED))
    local COLOR_DEC_GREEN=$((16#$COLOR_HEX_GREEN))
    local COLOR_DEC_BLUE=$((16#$COLOR_HEX_BLUE))

    # Calculate perceived brightness of background per ITU-R BT.709
    # https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
    # http://stackoverflow.com/a/12043228/18986
    local COLOR_LUMA_RED=$((0.2126 * $COLOR_DEC_RED))
    local COLOR_LUMA_GREEN=$((0.7152 * $COLOR_DEC_GREEN))
    local COLOR_LUMA_BLUE=$((0.0722 * $COLOR_DEC_BLUE))

    local COLOR_LUMA=$(($COLOR_LUMA_RED + $COLOR_LUMA_GREEN + $COLOR_LUMA_BLUE))

    echo "$COLOR_LUMA"
}

color() {
    emulate -L zsh

    local SCHEME="$1"
    local BASE16_DIR=~/.config/base16-shell/scripts
    local BASE16_CONFIG_PREVIOUS="${__WINCENT[BASE16_CONFIG]}.previous"
    local STATUS=0

    __color() {
        SCHEME=$1
        local FILE="$BASE16_DIR/base16-$SCHEME.sh"
        if [[ -e "$FILE" ]]; then
            local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
            local LUMA=$(luma "$BG")
            local LIGHT=$((LUMA > 127.5))
            local BACKGROUND=dark
            if [ "$LIGHT" -eq 1 ]; then
                BACKGROUND=light
            fi

            if [ -e "$__WINCENT[BASE16_CONFIG]" ]; then
                cp "$__WINCENT[BASE16_CONFIG]" "$BASE16_CONFIG_PREVIOUS"
            fi

            echo "$SCHEME" >! "$__WINCENT[BASE16_CONFIG]"
            echo "$BACKGROUND" >> "$__WINCENT[BASE16_CONFIG]"
            sh "$FILE"

            if [ -n "$TMUX" ]; then
                local CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
                if [ -n "$BG" -a -n "$CC" ]; then
                    command tmux set -a window-active-style "bg=#$BG"
                    command tmux set -a window-style "bg=#$CC"
                    command tmux set -g pane-active-border-style "bg=#$CC"
                    command tmux set -g pane-border-style "bg=#$CC"
                fi
            fi
        else
            echo "Scheme '$SCHEME' not found in $BASE16_DIR"
            STATUS=1
        fi
    }

    if [ $# -eq 0 ]; then
        if [ -s "$__WINCENT[BASE16_CONFIG]" ]; then
            cat "$__WINCENT[BASE16_CONFIG]"
            local SCHEME=$(head -1 "$__WINCENT[BASE16_CONFIG]")
            __color "$SCHEME"
            return
        else
            SCHEME=help
        fi
    fi

    case "$SCHEME" in
    help)
        echo 'color [tomorrow-night|ocean|grayscale-light|...]'
        echo
        echo 'Available schemes:'
        color ls
        return
        ;;
    ls)
        find "$BASE16_DIR" -name 'base16-*.sh' | \
            sed -E 's|.+/base16-||' | \
            sed -E 's/\.sh//' | \
            column
            ;;
    -)
        if [[ -s "$BASE16_CONFIG_PREVIOUS" ]]; then
            local PREVIOUS_SCHEME=$(head -1 "$BASE16_CONFIG_PREVIOUS")
            __color "$PREVIOUS_SCHEME"
        else
            echo "warning: no previous config found at $BASE16_CONFIG_PREVIOUS"
            STATUS=1
        fi
        ;;
    *)
        __color "$SCHEME"
        ;;
    esac

    unfunction __color
    return $STATUS
}

function () {
    emulate -L zsh

    if [[ -s "$__WINCENT[BASE16_CONFIG]" ]]; then
        local SCHEME=$(head -1 "$__WINCENT[BASE16_CONFIG]")
        local BACKGROUND=$(sed -n -e '2 p' "$__WINCENT[BASE16_CONFIG]")
        if [ "$BACKGROUND" != 'dark' -a "$BACKGROUND" != 'light' ]; then
            echo "warning: unknown background type in $__WINCENT[BASE16_CONFIG]"
        fi
        color "$SCHEME"
    else
        # Default.
        # color default-dark
    fi
}
