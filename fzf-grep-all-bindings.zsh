#!/bin/zsh

command -v fzf >/dev/null 2>&1 || return

# ZSH variant of CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${${(%):-%N}:A:h}"/fzf-grep-all.sh

fzf-grep-widget() {
  LBUFFER="${LBUFFER}$(fzf_grep)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N             fzf-grep-widget
bindkey -M emacs '\Eg' fzf-grep-widget
bindkey -M vicmd '\Eg' fzf-grep-widget
bindkey -M viins '\Eg' fzf-grep-widget

fzf-rga-widget() {
  LBUFFER="${LBUFFER}$(fzf_rga)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N            fzf-rga-widget
bindkey -M emacs '^G' fzf-rga-widget
bindkey -M vicmd '^G' fzf-rga-widget
bindkey -M viins '^G' fzf-rga-widget
