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

# shortcuts
# mostly dbt
alias get="git"
alias gut="git"
alias fresh_please="echo ### checkout main and pull latest updates; git checkout master && git pull"
alias full_refresh_model_run="echo '>>>' dbt run --full-refresh -m; dbt run --full-refresh -m"
alias edit_shell_profile="echo '>>>' vi ~/.zshrc; vi ~/.zshrc"
alias docs_gen="dbt docs generate"
