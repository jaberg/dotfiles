

# -- systemwide .profile
test -f /etc/profile && source /etc/profile

# common bourne shell config
source $HOME/.shrc

. .virtualenv/base/bin/activate
export PYTHONPATH=~/cvs/PYTHONPATH:$PYTHONPATH

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w $(parse_git_branch)\$\[\033[00m\] '

