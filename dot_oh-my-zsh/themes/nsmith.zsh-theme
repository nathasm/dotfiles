function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  echo '○'
}

#PROMPT='%{$fg[cyan]%}%m%{$reset_color%}:%~$(git_prompt_info)%{$reset_color%}
#$(prompt_char) '
RPROMPT='[%@]'
PROMPT='
%(?.%F{green}^_^ .%F{red}ಠ_ಠ ) %{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_info)%{$reset_color%}
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red])%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
