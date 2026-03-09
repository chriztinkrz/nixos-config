function install
    set -l pkgs (yay -Slq | fzf --multi --preview 'yay -Si {1}')
    if test -n "$pkgs"
        yay -S $pkgs
    end
end
