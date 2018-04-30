export PATH="/usr/local/:/usr/local/bin:/usr/bin:$PATH:/usr/local/sbin:/var/lib/gems/1.8/bin"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#Set the time zone
TZ='America/Chicago'; export TZ

#Enable coloring for terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#Momentum pictures
alias momentum_pics='cp ~/Library/Application\ Support/Google/Chrome/Default/Extensions/laookkfknpbbblfpciffpaejjkokdgca/0.50.2_0/backgrounds/* ~/Pictures/'

#Set up aliases
alias clean="find . -type f -name "*.un~" -exec rm -f '{}' \;"
alias la="ls -Gla"
alias ls="ls -G"
alias ntp='sudo /usr/sbin/ntpdate -v north-america.pool.ntp.org'
alias portscan="nmap -T5 -A"
alias netstat="netstat -tulpn"
alias startpostgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias killrockets="sed -i '' -e 's/\:\([a-zA-Z_]*\)[[:blank:]]=\>/\1\:/g' \$(ack -l \"\:([a-zA-Z_]*)(\s*)\=\>\")"
alias addspaces="sed -i '' -e 's/\([a-zA-Z0-9]\)\([*+]\)\([a-zA-Z0-9]\)/\1 \2 \3/g' \$(ack -l \"([^ ])([\+\*])([^ ])\")"
alias addspacesbetweensymbols="sed -i '' -e 's/\([a-zA-Z0-9]\)\([:]\)\([0-9]\)/\1\2 \3/g' \$(ack -l \"([^ ])([:])([^ ])\")"
alias addspacesminus="sed -i '' -e 's/\([a-zA-Z0-9]\)\([-]\)\([a-zA-Z0-9]\)/\1 \2 \3/g'"
alias addspacescomma="sed -i '' -e 's/\([a-zA-Z0-9]\)\([,]\)\([a-zA-Z0-9]\)/\1\2 \3/g'"
alias addspaceshashes="sed -i '' -e 's/\v\{\([^ ]\)\(.*\)\([^ ]\)\}/\{ \1\2\3 \}/g'"

if which hub > /dev/null; then
  alias git='hub'
fi

#git aliases
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff --color"
alias gp="git push"
alias gs="git status"
alias amend="git commit --amend"

#rails aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

#Override some commands for xens
if [ -f /etc/debian_version ]; then
  alias la='ls -lA --color=auto'
  alias ls='ls --color=auto'
fi

#Yiya specific commands
if [ -d ~/rails_projects/Yiya ]; then
  alias dbdump='heroku pgbackups:capture --app yiya && curl -o db_dumps/$(date +"%Y%m%d%H%M").dmp `heroku pgbackups:url --app yiya`'
fi

#Yiya specific commands
if [ -d /export/portfolio ]; then
  alias portdbdmp='pg_dump  -U netcredit__read_only -h proddb-portfolio.netcredit.com portfolio_prod_nc > portfolio-sandbox.sql'
fi

if which brew > /dev/null; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# add tab completion for git
if [ ! -f ~/.git-completion.bash ]; then
  (cd ~ && wget -O .git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash --no-check-certificate)
fi
source ~/.git-completion.bash

#install janus plugins
if [ ! -f ~/.vimrc.after ]; then
  curl -Lo- https://bit.ly/janus-bootstrap | bash
fi

#Sets the command line to use vi mode
set -o vi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# git branch on PS1
parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'; }
PS1="\[\033[01;37m\]♛ \[\033[38;5;186m\]\w\[\033[38;5;210m\] \$(parse_git_branch)\[\e[0m\]> "

# Make openSSL work
unset C_INCLUDE_PATH
