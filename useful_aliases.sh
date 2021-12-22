
# use ". ./useful_aliases.sh" to pick these up

alias DI='docker images -a'
alias DIR='docker image rm'
alias DIRMN='docker images -a | grep none | awk '\''{print $3}'\'' | xargs -L1 docker image rm'
alias DPS='docker ps -a'
alias DPSRE='docker ps -a | grep Exited | awk '\''{print $1}'\'' | xargs -L1 docker rm'

