export PS1="%d ~ 🍰 # "

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Git branch in prompt.

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ('$branch')'
  fi
}

setopt prompt_subst

# Config for prompt. PS1 synonym.
prompt='%n ♥ %2/ $(git_branch_name) > ~ 🍰 #'

