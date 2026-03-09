for line in (grep '^color' ~/.cache/wal/colors.sh)
    set parts (echo $line | sed "s/\\['\\(.*\\)'] = '\\(.*\\)'/\\1 \\2/")
    set -g $parts
end
