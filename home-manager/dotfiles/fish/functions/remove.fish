function remove
    set -l pkgs (yay -Qq | fzf --multi --preview 'yay -Qi {1}')
    if test -n "$pkgs"
        yay -Rns $pkgs
    end
end
