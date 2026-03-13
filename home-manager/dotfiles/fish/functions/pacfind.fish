function pacfind --wraps="sudo pacman -S \$(pacman -Slq | fzf -m --preview 'pacman -Si {1}')" --description "alias pacfind=sudo pacman -S \$(pacman -Slq | fzf -m --preview 'pacman -Si {1}')"
    sudo pacman -S $(pacman -Slq | fzf -m --preview 'pacman -Si {1}') $argv
end
