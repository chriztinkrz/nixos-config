function clock --wraps='tty-clock -c -C 6 -D -t' --description 'alias clock tty-clock -c -C 6 -D -t'
    tty-clock -c -C 6 -D -t $argv
end
