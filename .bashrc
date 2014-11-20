# Prompt
PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

# Aliase
alias l='ls -G'
alias ll='ls -lhG'
alias la='ls -lhaG'
alias ..='cd ..'
alias ...='cd ../..'
alias tailf='tail -f'

alias tma='tmux attach -d -t'
alias git-tmux='tmux new -s $(basename $pwd))'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
