# .bashrc

source_if_exists() {
    if [ -f "$1" ]; then
        source "$1"
    fi
}

source_if_exists $HOME/.git-completion.bash
source_if_exists $HOME/.git-prompt.sh
source_if_exists $(brew --prefix)/etc/bash_completion

export EDITOR="vim"

prompt_bad_exit() {
  local exit_status=$?
  if (( $exit_status != 0 )); then
      echo -e "\033[0;31mEXIT STATUS $exit_status\033[0m"
  fi
}

export PROMPT_COMMAND="prompt_bad_exit"
export PS1='[\u@\h \w$(__git_ps1 " (%s)")]\$ '

if (ls --version | grep -q 'GNU'); then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi

alias grep='grep --color=auto'
alias vim='vim -O'
alias gg="git grep"

