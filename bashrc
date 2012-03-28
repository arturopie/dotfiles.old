# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
    *)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='rgrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#Git tab completion
if [ -f ~/git-completion.bash ]; then 
    source ~/git-completion.bash
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;33m\]\$(__git_ps1 \" (%s)\")\[\033[01;36m\] \$\[\033[00m\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Use this to know if the shell is being executed from emacs
# if [ "$EMACS" = 't' ] ; then

# fi

# this makes emacs prompt ugly
#     export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

export HISTCONTROL=ignoreboth

#To use github
SSH_AUTH_SOCK=0

# to use no fast-forward by deafult
git() {
  if [[ $@ == merge* ]]; then

    if [[ $@ == *--no-ff* ]]; then
      command git "$@"
      return
    fi

    if [[ $@ == *--ff* ]]; then
      command git "$@"
    else
      command git "$@" --no-ff
    fi

  else
    command git "$@"
  fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# to use bundle exec when using rake 0.8.7
rake() { if [ -e ./Gemfile.lock ]; then bundle exec rake "$@"; else /usr/bin/env rake "$@"; fi; }

#to use db2
export PATH=/opt/ibm/db2/V9.7/bin:$PATH

# The following three lines have been added by UDB DB2.
if [ -f /home/arturo/sqllib/db2profile ]; then
    . /home/arturo/sqllib/db2profile
fi

# to avoid locking the terminal when opening emacs, emacsclient, or evince
emacs() {
    if [[ $@ == *-nw* ]]; then
        command emacs "$@"
    else
        command emacs "$@" &
    fi
}

emacsclient() {
    if [[ $@ == *-nw* ]]; then
        command emacsclient "$@"
    else
        command emacsclient "$@" &
    fi
}

evince() {
    command evince "$@" &
}
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
