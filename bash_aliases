# some more ls aliases
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    # type 'alert' after initiating a long running command
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    alias uw-news='ssh -L 1190:news.uwaterloo.ca:119 uw-server'

    function kill-cmd() { ps xa | grep "$@" | grep -v grep | awk '{print $1}' | sudo xargs kill ;}

    alias karma='node_modules/.bin/karma'

    alias xrun='xvfb-run -a'

    alias acceptance='xvfb-run --auto-servernum --server-num=1 --server-args="-screen 0, 1280x1024x24" bundle exec rspec'

    alias gfailed='rake gorgon:failed_deprecated'

    alias jstest='xrun bundle exec rake jstest:all'
