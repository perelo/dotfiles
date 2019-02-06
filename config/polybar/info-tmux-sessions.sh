#! /bin/sh

if sessionlist=$(tmux ls 2>/dev/null); then
    printf " "

    attached="0̲ 1̲ 2̲ 3̲ 4̲ 5̲ 6̲ 7̲ 8̲ 9̲"
    detached="0 1 2 3 4 5 6 7 8 9"

    echo "$sessionlist" | while read -r line; do
        session=$(echo "$line" | cut -d ':' -f 1)

        if echo "$line" | grep -q "(attached)"; then
            status=$attached
        else
            status=$detached
        fi

        icon=$(echo "$status" | cut -d ' ' -f $(($session+1)))
        printf "%s%s " "$icon"
    done

    printf "\n"
else
    printf " \n"
fi
