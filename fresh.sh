
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install github cli
brew install gh

# env management python
brew install pyenv
brew install pyenv-virtualenv

# dbt autocomplete
curl https://raw.githubusercontent.com/fishtown-analytics/dbt-completion.bash/master/dbt-completion.bash > ~/.dbt-completion.bash
echo 'source ~/.dbt-completion.bash' >> ~/.zshrc

# configure git
git config --global user.name "thleo"
read -p "Enter your org email: " email
git config --global user.email "$email"