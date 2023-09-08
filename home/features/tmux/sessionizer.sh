#!/usr/bin/env bash

__fzfcmd() {
	[ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
		echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

sessions=()
IFS=$'\n'

for codedir in $(echo "$HOME/code/;$HOME/Projects/" | tr ";" "\n" | xargs -i{} find "{}" -maxdepth 1 -mindepth 1 -type d); do
	if [ "$(git -C "$codedir" rev-parse --is-bare-repository --quiet 2>/dev/null)" = "true" ]; then
		sessions+=("$(git -C "$codedir" branch -r | tr -d " " | sed -e "s/^origin\///" | xargs printf "worktree: %s @ $codedir\n")")
	else
		sessions+=("code: $codedir")
	fi
done

RESULT=$(
	(
		tmux list-sessions -F 'session: #{session_name}: #{session_windows} window(s) #{?session_grouped, (group ,}#{session_group}#{?session_grouped,),} #{?session_attached, (attached),}'
		printf "%s\n" ${sessions[@]}
	) | $(__fzfcmd) --reverse
)

TYPE="${RESULT%%:*}"
VAL="${RESULT#*: }"
echo "type: '$TYPE'"
echo "val: '$VAL'"
case "$TYPE" in
session)
	SESSION="${VAL%%:*}"
	;;
worktree)
	WT="${VAL%% @*}"
	DIR="${VAL##* @ }"
	[ ! -d "$WT" ] && git -C "$DIR" worktree add "$WT"
	DIR+="/$WT"
	SESSION="$WT"
	;;
code) ;&
path)
	SESSION=$(basename "$VAL" | tr . - | tr ' ' - | tr ':' - | tr '[:upper:]' '[:lower:]')
	DIR=$VAL
	;;
*)
	echo Nothing selected
	;;
esac

echo "using: '$SESSION' '$DIR'"
[ -n "$DIR" ] && [ ! $(tmux has-session -t="$SESSION" >/dev/null) ] && tmux new-session -d -s "$SESSION" -c "$DIR"

[ -z "$SESSION" ] && exit 0
echo "session: '$SESSION'"

# Attach to session
if [ -z "$TMUX" ]; then
	tmux attach -t $SESSION
else
	tmux switch-client -t $SESSION
fi
