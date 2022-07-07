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
prompt='%n ♥ %2/ $(git_branch_name) > ~ 🍰 # '

# shortcuts
# shell
alias edit_shell_profile="echo '>>>' vi ~/.zshrc; vi ~/.zshrc"

# git
alias get="git"
alias gut="git"
alias fresh_please="echo ### checkout main and pull latest updates; git checkout master && git pull"
alias nbranch="echo '>>>' git checkout -b; git checkout -b"



# dbt
alias docs_gen="dbt docs generate"
alias defer_model_run="echo '>>>' dbt run --defer --state ci_state/artifacts/ -m; dbt run --defer --state ci_state/artifacts/ -m"
alias full_refresh_defer_model_run="echo '>>>' dbt run --full-refresh --defer --state ci_state/artifacts/ -m; dbt run --full-refresh --defer --state ci_state/artifacts/ -m"
alias full_refresh_model_run="echo '>>>' dbt run --full-refresh -m; dbt run --full-refresh -m"
alias dbtt="echo '>>>' dbt test -m;dbt test -m"

# other
alias prep_defer="echo '>>>' make ci_state; make ci_state"

# FUNCTIONS ⚡️
# checkout feature branch and rebase against master
function chre ()
{
    echo ">>> git checkout $1 && git rebase master"
    git checkout $1
    git rebase master
    echo "$1 is up to date with prod"
    return 0
}

# add pyenv to path
eval "$(pyenv init --path)"
# autocomplete shims
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
