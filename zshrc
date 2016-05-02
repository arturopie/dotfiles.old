# Path to your oh-my-zsh configuration.
export ZSH=/Users/arturopie/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="my-theme"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source $HOME/.bash_aliases

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump brew bundler history-substring-search git rake-fast npm nulogy richard terminalapp zeus zsh_reload gem)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/opt/ibm/db2/V9.7/bin:/home/arturo/.rvm/gems/ree-1.8.7-2011.03/bin:/home/arturo/.rvm/gems/ree-1.8.7-2011.03@global/bin:/home/arturo/.rvm/rubies/ree-1.8.7-2011.03/bin:/home/arturo/.rvm/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/arturo/sqllib/bin:/home/arturo/sqllib/adm:/home/arturo/sqllib/misc:/home/arturo/sqllib/db2tss/bin
export PATH="$PATH:$HOME/Applications/packer_0.8.6_darwin_amd64"
export PATH="$PATH:$HOME/Applications/apache-maven-3.3.9/bin"
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
export CDPATH="$CDPATH:~/src/packmanager:~/src"

export CATALINA_HOME=/Users/arturopie/Applications/apache-tomcat-7.0.61

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export RUBYMINE=enabled
export RAILS_FOOTNOTES_EDITOR=rubymine

unsetopt correct_all
setopt hist_ignore_space hist_find_no_dups

kill_pm_processes() {
    echo "Killing ruby proccesses listening on 5555"
    lsof -P -i :5555 | sed -n 's/ruby *\([0-9]*\).*\:5555.*/\1/p' | xargs kill

    echo "Killing nginx proccesses listening on 3000"
    lsof -P -i :3000 | sed -n 's/nginx *\([0-9]*\).*\:3000.*/\1/p' | xargs kill
}

pm_build_production() {
    RAILS_ENV=production rake assets:precompile
    ./node_modules/gulp/bin/gulp.js release --no-uglify
}

eval "$(direnv hook zsh)"
