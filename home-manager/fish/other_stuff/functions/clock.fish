function clock --wraps='tty-clock -c -C 2 -D -t' --description 'alias clock tty-clock -c -C 2 -D -t'
    tty-clock -c -C 2 -D -t $argv
end
