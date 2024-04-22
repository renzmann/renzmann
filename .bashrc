#!/usr/bin/env bash

# In an interactive login shell, Bash first looks for the /etc/profile
# file. If found, Bash reads and executes it in the current shell. As
# a result, /etc/profile sets up the environment configuration for all
# users.  Similarly, Bash then checks if .bash_profile exists in the
# home directory. If it does, then Bash executes .bash_profile in the
# current shell. Bash then stops looking for other files such as
# .bash_login and .profile.  If Bash doesn’t find .bash_profile, then
# it looks for .bash_login and .profile, in that order, and executes
# the first readable file only.

# When an interactive shell that is not a login shell is started, Bash reads and
# executes commands from ~/.bashrc, if that file exists. This may be inhibited
# by using the --norc option. The --rcfile file option will force Bash to read
# and execute commands from file instead of ~/.bashrc.

# From the above, I set .bash_profile to just source this file, which
# in turn will make sure to grab any of the more common
# configurations, like $PATH, from the more general .profile

# Suppress the warning about zsh on mac
export BASH_SILENCE_DEPRECATION_WARNING=1

[[ -f /etc/bashrc ]] && . /etc/bashrc

# Things that need to be "sourced" instead of loaded on-demand
[[ -f $HOME/.git-prompt.sh ]] && . $HOME/.git-prompt.sh
# GIT_PS1_SHOWDIRTYSTATE="yes"
# GIT_PS1_SHOWUPSTREAM="auto"
# GIT_PS1_SHOWCOLORHINTS="yes"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# FIXME: these cause a big login time performance hit - any way to lazy-load them on demand?
# nvm setup bits
export NVM_DIR="$HOME/.nvm"
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Emacs `eat` integration
# [[ -n "$EAT_SHELL_INTEGRATION_DIR" ]] && source "$EAT_SHELL_INTEGRATION_DIR/bash"

# Late machine-specific specs
[ -f "$HOME/.locals" ] && source "$HOME/.locals"

# Prompt customization
PS1='\n┌─ \d [\@] (\s \v: \j jobs)'
PS1+='\n├─ \u@\h \w $(__git_ps1 "[ᓺ %s]")'
PS1+='\n└ $ '
