#!/bin/sh

command -v fzf >/dev/null 2>&1 || return

FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height ${FZF_TMUX_HEIGHT:-90%}
  --info=inline --keep-right
  --bind=ctrl-l:accept,ctrl-u:kill-line,change:top,alt-j:preview-page-down,alt-k:preview-page-up
  --bind=ctrl-z:ignore"

# Check which clipboard tool is installed.
if command -v xsel >/dev/null 2>&1; then
  SEND_TO_CLIPBOARD="xsel --input --clipboard"
elif command -v xclip >/dev/null 2>&1; then
  SEND_TO_CLIPBOARD="xclip -in -selection c"
elif command -v pbcopy >/dev/null 2>&1; then
  SEND_TO_CLIPBOARD="pbcopy"
elif command -v clip.exe >/dev/null 2>&1; then
  SEND_TO_CLIPBOARD="clip.exe"
fi

[ -z "${SEND_TO_CLIPBOARD+x}" ] || FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='ctrl-y:execute-silent(echo {..} | ${SEND_TO_CLIPBOARD})+abort'"

export FZF_DEFAULT_OPTS

if command -v rg >/dev/null 2>&1; then
  FZF_GREP_COMMAND="rg --smart-case --line-number --no-heading --hidden --iglob '!.{git,hg,bzr,svn}/' --no-messages --"
elif command -v ag >/dev/null 2>&1; then
  FZF_GREP_COMMAND="ag --line-number --no-heading --hidden --ignore .git/ --silent"
else
  FZF_GREP_COMMAND="command grep --recursive --exclude-dir=.git"
fi

if command -v rg > /dev/null; then
  FZF_PREVIEWER="[ ! -z {} ] && rg --pretty --context 3 -- {q} {1}"
elif command -v bat > /dev/null; then
  FZF_PREVIEWER="bat --color=always --style=${BAT_STYLE:-numbers} --pager=never --highlight-line {2} -- {1}"
else
  FZF_PREVIEWER='head -- {1}'
fi

# --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
FZF_GREP_OPTS="--bind=ctrl-z:ignore \
  --height ${FZF_TMUX_HEIGHT:-90%} \
  --preview-window 'up,60%,border-bottom' \
  --preview='"${FZF_PREVIEWER:-head -- {1}}"' \
  ${FZF_DEFAULT_OPTS-}"

# From https://news.ycombinator.com/item?id=38471822
fzf_grep() {
  GREP_PREFIX="${FZF_GREP_COMMAND:-"command grep --recursive --exclude-dir=.git"} 2> /dev/null"

  local result file
  result="$(
    FZF_DEFAULT_COMMAND="$GREP_PREFIX '$1'" \
    FZF_DEFAULT_OPTS="$FZF_GREP_OPTS" \
      fzf --sort \
        --disabled --query="$1" \
        --bind "change:reload:$GREP_PREFIX {q}" \
        --delimiter ':'
  )" &&
    file=${result%%:*} &&
    printf '%q ' "$file"  # escape special chars
}
fs() {
  GREP_PREFIX="${FZF_GREP_COMMAND:-"command grep --recursive --exclude-dir=.git"} 2> /dev/null"

  local result file
  result="$(
    FZF_DEFAULT_COMMAND="$GREP_PREFIX '$1'" \
    FZF_DEFAULT_OPTS="$FZF_GREP_OPTS" \
      fzf --sort \
        --disabled --query="$1" \
        --bind "change:reload:$GREP_PREFIX {q}" \
        --delimiter ':'
  )" &&
    file=${result%%:*}

  if [ -f "$file" ]; then
    line=${result#*:}
    line=${line%%:*}
    ${EDITOR:-vim} +"${line}" "$file"
  fi
}

command -v rga >/dev/null 2>&1 || return

export FZF_RGA_COMMAND="rga --smart-case --hidden --no-ignore --iglob '!.{git,hg,bzr,svn}/' --files-with-matches --"

# From https://github.com/phiresky/ripgrep-all/wiki/fzf-Integration
fzf_rga() {
  RGA_PREFIX="${FZF_RGA_COMMAND:-rga --smart-case --hidden --no-ignore --iglob \!.\{git,hg,bzr,svn\}/ --files-with-matches --} 2> /dev/null"
  PREVIEWER='[ ! -z {} ] && rga --pretty --context 3 {q} {}'

  local result
  result="$(
    FZF_DEFAULT_COMMAND="$RGA_PREFIX '$1'" \
    FZF_DEFAULT_OPTS="$FZF_GREP_OPTS" \
      fzf --sort --preview="$PREVIEWER" \
        --disabled --query="$1" \
        --bind "change:reload:$RGA_PREFIX {q}" \
        --preview-window="70%:wrap"
  )" &&
    file=${result%%:*} &&
    printf '%q ' "$file"  # escape special chars
}
fo() {
  RGA_PREFIX="${FZF_RGA_COMMAND:-rga --smart-case --hidden --no-ignore --iglob \!.\{git,hg,bzr,svn\}/ --files-with-matches --} 2> /dev/null"
  PREVIEWER='[ ! -z {} ] && rga --pretty --context 3 {q} {}'

  local result
  result="$(
    FZF_DEFAULT_COMMAND="$RGA_PREFIX '$1'" \
    FZF_DEFAULT_OPTS="$FZF_GREP_OPTS" \
      fzf --sort --preview="$PREVIEWER" \
        --disabled --query="$1" \
        --bind "change:reload:$RGA_PREFIX {q}" \
        --preview-window="70%:wrap"
  )"
  if [ -f "$result" ]; then
    echo "opening $result ..."
    xdg-open "$result"
  fi
}
