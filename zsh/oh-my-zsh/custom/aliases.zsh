# Aliases

# Directory history
setopt autopushd pushdminus pushdsilent pushdtohome
alias dirsh='dirs -v'

# Mass move
autoload -U zmv
alias mmv='noglob zmv -W'

# Alias for apt-get update/apt-get upgrade
alias aptupdate='sudo apt update && sudo apt --assume-yes upgrade'

# Interactive version of move and copy
alias mv='mv -i'
alias cp='cp -i'

# Alias for ps
alias psgrep='ps ax | grep'

# Alias for directory size listing
alias dirsize='du -h -s'

# get my IP using http://canihazip.com/s
# http://n3mesisfixx.blogspot.it/2013/02/
#    what-is-my-public-ip-from-command-line.html
alias canihazip='curl -w "\n" https://canihazip.com/s'
alias getip='canihazip'

# Show IP address
# alias showip='function _showip(){ /sbin/ifconfig $1 | grep "inet addr:" |
#                                     cut -d: -f2 | awk "{print \$1}";
#                                 }; _showip'
# shellcheck disable=SC2142
alias showip='function _showip(){ ip_regex="s#^(\w+)\s*.+inet addr:([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) .+#\1\t\2#g";
								  /sbin/ifconfig $1 | grep -B1 "inet addr:" |
                                  tr "\n" "--" | sed "s/----/\n/g" |
                                  sed -r "$ip_regex";
                                  echo "";
                                }; _showip'

# Alias to generate random password
alias genpass="</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' \
               | head -c32; echo ''"

# Microsoft Azure completion
alias azure-activate='nvm use stable && . <(azure --completion)'

# Show which port is listening on
alias whichport='sudo netstat -tulpn'

# strip color from shell output
# See:
# https://unix.stackexchange.com/questions/111899/
#   how-to-strip-color-codes-out-of-stdout-and-pipe-to-file-and-stdout/
#   111936#111936
alias stripcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

# maintain colors through pipes
alias 'forcecolors_grep'='grep --color=always'
alias 'forcecolors_ls'='ls --color=always'
alias 'forcecolors'='unbuffer'

# ssh remove key from authorized_keys
# shellcheck disable=SC2139
alias ssh-remove="ssh-keygen -f '$HOME/.ssh/known_hosts' -R"

# count number of columns in CSV file
# shellcheck disable=SC2142
alias columncount='function _columncount(){
				  local mincol=$(awk -F"${2:-,}" "{print NF}" $1 | sort -nu | head -n 1;)
				  local maxcol=$(awk -F"${2:-,}" "{print NF}" $1 | sort -nu | tail -n 1;)
				  echo "$mincol $maxcol"
                }; _columncount'

# Run gpg2 instead of gpg
alias gpg=gpg2


# nuovo comando 'purge'
# shellcheck disable=SC2139
alias purge="$HOME/.scripts/purge.sh"
# shellcheck disable=SC2139
alias purge-build="$HOME/.scripts/purge-build.sh"

# shrinkpdf
# See:
# https://github.com/CristianCantoro/shrinkpdf
# shellcheck disable=SC2139
alias shrinkpdf="$HOME/.scripts/shrinkpdf"

# Linuxbrew update and upgrade
alias brewupdate='brew update && brew upgrade'

# BFG Repo-Cleaner
# https://rtyley.github.io/bfg-repo-cleaner/
alias bfg='java -jar /opt/BFG_repocleaner/bfg.jar'
