# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
## PROMPT
export PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\[\033[35m\]\[\033[33m\]\w\[\033[36m\]`__git_ps1` [`ahead_behind`]\[\033[0m\]\n$ '
## ENV VARIABLES
export LESS=-RiXsj5Q
export EDITOR=nvim

set -o vi
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
shopt -s checkwinsize

## ALIASES
if [ -f ~/..bash_aliases ]; then
  . ~/.bash_aliases
fi
if [ -f ~/.bash_git ]; then
  . ~/.bash_git
fi

## FUNCTIONS
function ahead_behind {
    curr_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null);
    curr_remote=$(git config branch.$curr_branch.remote 2> /dev/null);
    curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3 2> /dev/null);
    git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch 2> /dev/null | tr -s '\t' '|';
}


# >>> coursier install directory >>>
export PATH="$PATH:/home/manmohan/.local/share/coursier/bin"
# <<< coursier install directory <<<
