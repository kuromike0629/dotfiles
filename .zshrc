# Enable zsh-completions
if [ -e /usr/local/share/zsh-completioons ]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
fi
# Color setting
TERM=xterm-256color

# History setting
setopt histignorealldups
HISTFILE=~/.zsh_history HISTSIZE=1000000
SAVEHIST=1000000

# language setting
LANG=ja_JP.UTF-8

# Change keybind like vim
bindkey -v

# Use colort
autoload -Uz colors
colors

# Use completion
autoload -Uz compinit
compinit

# Extend cd command
setopt auto_cd

# Extend pushed
setopt auto_pushd
setopt pushd_ignore_dups

# Auto correct command typo
setopt correct

# Aliases
alias vi="vim"

# Custom Prompt
local SHOBON='(｀・ω・´%)'
local KIRI='(´・ω・｀%)'

case ${USERNAME} in
'root')
	PROMPT="%c#"
	RPROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%}) %(?.$SHOBON.$KIRI) %{${reset_color}%}"
	;;
*)
	PROMPT="%c$"
	RPROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%}) %(?.$SHOBON.$KIRI) %{${reset_color}%}"
	;;	
esac

# Enable cursor on compleation
zstyle ':completion:*:default' menu select=2

# Enable large capital match
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# History compleation
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

# Tmux settig
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
