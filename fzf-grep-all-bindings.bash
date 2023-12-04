#!/bin/bash

command -v fzf >/dev/null 2>&1 || return

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/fzf-grep-all.sh

__fzf_grep__() {
  local selected
  selected="$(fzf_grep "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -m emacs -x '"\eg": " __fzf_grep__"'
bind -m vi-insert -x '"\eg": " __fzf_grep__"'
bind -m vi-command -x '"\eg": " __fzf_grep__"'

__fzf_rga__() {
  local selected
  selected="$(fzf_rga "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -m emacs -x '"\C-g": " __fzf_rga__"'
bind -m vi-insert -x '"\C-g": " __fzf_rga__"'
bind -m vi-command -x '"\C-g": " __fzf_rga__"'
