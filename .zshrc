export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug 'mafredri/zsh-async'
zplug 'sindresorhus/pure'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-autosuggestions', defer:2
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

zplug load

zstyle :prompt:pure:git:stash show yes
zstyle ':vcs_info:git*' formats '%b' '%R' '%a' '%i'
zstyle ':vcs_info:git*' actionformats '%b' '%R' '%a' '%i'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

source $HOME/.zsh/aliases

for zsh_source in $HOME/.zsh/configs/*.zsh; do
  source $zsh_source
done

ensure_tmux_is_running

