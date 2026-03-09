#!/usr/bin/env bash 
# Check version of bash for variable indirection 
case $BASH_VERSION in ''|[123].*|4.[012]) rofi -e "ERROR: Bash 4.3+ needed" ; exit 1;; esac

# Check for required executables
command -v fd >/dev/null 2>&1 || { echo >&2 "I require 'fd' but it's not installed.  Aborting."; exit 1; }
command -v choose >/dev/null 2>&1 || { echo >&2 "I require 'choose' but it's not installed.  Aborting."; exit 1; }
command -v xsel >/dev/null 2>&1 || { echo >&2 "I require 'xsel' but it's not installed.  Aborting."; exit 1; }

SCRIPTPATH=$(realpath "$(dirname "$0")")
: "${XDG_CONFIG_HOME:="$HOME"/.config}"
: "${CONFIG_DIR:="$XDG_CONFIG_HOME/rofi-file-selector/"}"

# To enable mocking in test
: "${_ROFI:=rofi}"
: "${_CHOOSEEXE:="$SCRIPTPATH/chooseexe.sh"}"

MENU=(home)
d_home=("$HOME")
o_home=( )
FD_OPTIONS=( )

if [[ -f "$CONFIG_DIR/config.sh" ]]
then
   source "$CONFIG_DIR/config.sh"
elif [[ -f "$SCRIPTPATH/config.sh" ]]
then
   source "$SCRIPTPATH/config.sh"
fi

if [[ ${#MENU[@]} -gt 1 ]]
then
   res=$(printf "%s\n" "${MENU[@]}" | "$_ROFI" -dmenu)
else
   res="${MENU[0]}"
fi

# declare dirs as being an indirection upon d_$res
declare -n dirs="d_$res"
declare -n files="f_$res"
declare -n options="o_$res"

# --- 1. Define the file list generator ---
get_file_list() {
    if [[ -n "${files[*]}" ]]; then
        printf -- '%s\n' "${files[@]}"
    fi
    if [[ -n $dirs ]]; then
        "$SCRIPTPATH/fd_cache.sh" "${FD_OPTIONS[@]}" "${options[@]}" '.' "${dirs[@]}" 
    fi
}

# --- 2. Run Rofi and capture the selection AND the exit code ---
# We use a temp file or a variable trick to get both the choice and the key pressed
selection=$(get_file_list | "$_ROFI" -theme-str "listview {lines: 8; }" \
    -dmenu -sort -sorting-method fzf -i -p "" \
    -mesg "<i>Ctrl+d: Open Folder | Ctrl+c: Copy Path</i>" \
    -kb-custom-1 "Ctrl+d" \
    -kb-custom-2 "Ctrl+c" \
    -keep-right)

exit_code=$?

# --- 3. Handle the Exit Codes ---
if [[ -n "$selection" ]]; then
    case $exit_code in
        0) # User pressed ENTER
            setsid xdg-open "$selection" >/dev/null 2>&1 &
            ;;
        10) # User pressed Ctrl+d (Custom 1)
            # Open the folder containing the file
            folder=$(dirname "$selection")
            setsid xdg-open "$folder" >/dev/null 2>&1 &
            ;;
        11) # User pressed Ctrl+c (Custom 2)
            # 1. Clear current selection and pipe to clipboard
            echo -n "$selection" | xsel --clipboard --input
            
            # 2. (Optional) Backup for primary selection (middle-click paste)
            echo -n "$selection" | xsel --primary --input
            
            # Send a notification so you know it actually happened
            if command -v notify-send >/dev/null; then
                notify-send "Rofi Selector" "Copied: $(basename "$selection")"
            fi
            ;;
    esac
fi