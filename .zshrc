export PS1="%d ~ 🍰 # "

autoload -Uz compinit
compinit
# Completion for kitty
#kitty + complete setup zsh | source /dev/stdin

# Git branch in prompt.

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ['$branch']'
  fi
}

setopt prompt_subst

# env in prompt
function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# Config for prompt. PS1 synonym.
export VIRTUAL_ENV_DISABLE_PROMPT=0
prompt='$(virtualenv_info) %n ♥ %2/ $(git_branch_name) > ~ 🍰 # '
prompt='%F{blue%}[%D{%Y/%m/%f} %D{%K:%M:%S}] '$prompt

# shortcuts
# shell
alias edit_shell_profile="echo '>>>' vi ~/.zshrc; vi ~/.zshrc"

# AWS
alias run_aws_staging="echo NOW RUNNING IN STAGING ; echo '>>>' ENVIRONMENT=staging AWS_PROFILE=staging ;ENVIRONMENT=staging AWS_PROFILE=staging "
alias run_aws_prod="echo NOW RUNNING IN PRODUCTION ; echo '>>>' ENVIRONMENT=production AWS_PROFILE=production ;ENVIRONMENT=production AWS_PROFILE=production "

# git
alias get="git"
alias gut="git"
alias fresh_please="echo ### checkout main and pull latest updates; git checkout main && git pull"
alias fresh_please_master="echo ### checkout '*master*' and pull latest updates; git checkout master && git pull"
alias nbranch="echo '>>>' git checkout -b; git checkout -b"

# pyenv
alias env_up="echo '>>>' pyenv activate; pyenv activate"


# dbt
alias docs_gen="echo '>>>' dbt docs generate; dbt docs generate"
alias defer_model_run="echo '>>>' dbt run --defer --state ci_state/artifacts/ -m; dbt run --defer --state ci_state/artifacts/ -m"
alias full_refresh_defer_model_run="echo '>>>' dbt run --full-refresh --defer --state ci_state/artifacts/ -m; dbt run --full-refresh --defer --state ci_state/artifacts/ -m"
alias full_refresh_model_run="echo '>>>' dbt run --full-refresh -m; dbt run --full-refresh -m"
alias dbtt="echo '>>>' dbt test -m;dbt test -m"
alias dbt_local="echo NOW RUNNING IN STAGING ; echo '>>>' ENVIRONMENT=staging AWS_PROFILE=staging dbt ;ENVIRONMENT=staging AWS_PROFILE=staging dbt "
alias dbtlocal="echo NOW RUNNING IN STAGING ; echo '>>>' ENVIRONMENT=staging AWS_PROFILE=staging dbt ;ENVIRONMENT=staging AWS_PROFILE=staging dbt "
alias dbtprod="echo NOW RUNNING IN PRODUCTION ; echo '>>>' ENVIRONMENT=production AWS_PROFILE=production dbt ;ENVIRONMENT=production AWS_PROFILE=production dbt "
alias dbt_prod="echo NOW RUNNING IN PRODUCTION ; echo '>>>' ENVIRONMENT=production AWS_PROFILE=production dbt ;ENVIRONMENT=production AWS_PROFILE=production dbt "


# other
alias prep_defer="echo '>>>' make ci_state; make ci_state"

# CORPORATE AUTHENTICATION
alias rsauth="echo '>>>' rscreds staging ORGNAME --user dleong
aws --endpoint-url https://redshift-fips.us-east-1.amazonaws.com redshift get-cluster-credentials --cluster-identifier staging-ORGNAME --db-user dleong --db-name ORGNAME --duration-seconds 3600 --profile staging; rscreds staging ORGNAME --user dleong
aws --endpoint-url https://redshift-fips.us-east-1.amazonaws.com redshift get-cluster-credentials --cluster-identifier staging-ORGNAME --db-user dleong --db-name ORGNAME --duration-seconds 3600 --profile staging"
alias rsprod="echo '>>>' rscreds production ORGNAME --user dleong
aws --endpoint-url https://redshift-fips.us-east-1.amazonaws.com redshift get-cluster-credentials --cluster-identifier production-ORGNAME --db-user dleong --db-name ORGNAME --duration-seconds 3600 --profile production; rscreds production ORGNAME --user dleong
aws --endpoint-url https://redshift-fips.us-east-1.amazonaws.com redshift get-cluster-credentials --cluster-identifier production-ORGNAME --db-user dleong --db-name ORGNAME --duration-seconds 3600 --profile production"
alias dbcreds_staging="echo '>>>' dbcreds staging ORGNAME; dbcreds staging ORGNAME"
alias dbcreds_prod="echo '>>>' dbcreds production ORGNAME; dbcreds production ORGNAME"
alias deliverycreds_staging="echo '>>>' TYPE=writer ENGINE=psql CLUSTER=delivery DB_NAME=delivery DB_USER=migration dbcreds staging; TYPE=writer ENGINE=psql CLUSTER=delivery DB_NAME=delivery DB_USER=migration dbcreds staging"
alias deliverycreds_prod="echo '>>>' TYPE=writer ENGINE=psql CLUSTER=delivery DB_NAME=delivery DB_USER=migration dbcreds production; TYPE=writer ENGINE=psql CLUSTER=delivery DB_NAME=delivery DB_USER=migration dbcreds production"

# FUNCTIONS ⚡️
# checkout feature branch and rebase against main
function chre ()
{
    echo ">>> git checkout $1 && git rebase main"
    git checkout $1
    git rebase main
    echo "$1 is up to date with prod"
    return 0
}
# run aws commands in prod without setting config
function awsprod ()
{
    echo '>>>' aws $@ --profile production; aws $@ --profile production
    
}

# list out production models in dbt
function dbtList_models() {
  MODELVAR=$1
  echo ">>> ENVIRONMENT=production AWS_PROFILE=production dbt list -s $MODELVAR --resource-type model"
  ENVIRONMENT=production AWS_PROFILE=production dbt list -s $MODELVAR --resource-type model
}

# test function
function test ()
{
    # read terminal_input_command
    echo '>>>' aws s3 ls --profile production
    aws s3 ls --profile production
}

# add pyenv to path
# eval "$(pyenv init --path)"
# autocomplete shims
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# shell completion for pyenv-virtualenv
if 
which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; 
fi

eval $(/opt/homebrew/bin/brew shellenv) # Use /usr/local/bin/brew for macOS Intel
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pyenv paths
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# brew python path
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# dbt config - ORGNAME
# source ~/code/dbt/install/dbt_filter.sh

# OPTIONAL: Automatically update bootstrap
git -C ~/code/dotfiles reset --hard origin/main > /dev/null 2>&1
git -C ~/code/dotfiles pull > /dev/null 2>&1

# Source library functions from bootstrap
source ~/code/dotfiles/bootstrap.sh

# Created by `pipx` on 2023-05-16 13:50:17
export PATH="/Users/dleong/.pyenv/versions/3.9.4:$PATH:/Users/dleong/.local/bin:"

# alias python=/usr/bin/python3

# add docker to path
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source ~/.dbt-completion.bash

# add timestamp to prompt
prompt='%F{blue%}[%D{%Y/%m/%f} %D{%K:%M:%S}] '$prompt