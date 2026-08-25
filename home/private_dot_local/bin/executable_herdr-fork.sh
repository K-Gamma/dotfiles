#!/usr/bin/env bash
#
# herdr-fork-claude-session [direction]
#
# Fork the current Claude Code session into a new Herdr pane.
# The fork inherits this session's full conversation history under a NEW session
# ID; the original session is left unchanged (see `claude --fork-session`).
#
#   direction   right (default) | down | left | up  -- which way to split off the new pane
#               left/up are implemented as split right/down then swap the new pane
#               with the original so it ends up on the requested side.
#
# Requirements: run from inside a Herdr-managed pane (HERDR_ENV=1). The session
# ID comes from CLAUDE_CODE_SESSION_ID; if that is unset, it falls back to the
# session ID of the currently focused Herdr Claude agent. Needs python3 for JSON.
set -euo pipefail

if [ "${HERDR_ENV:-}" != "1" ]; then
    echo "herdr-fork-claude-session: not running inside Herdr (HERDR_ENV != 1)" >&2
    exit 1
fi

sid="${CLAUDE_CODE_SESSION_ID:-}"
if [ -z "$sid" ]; then
    # Fall back to the session ID of the currently focused Herdr agent.
    if ! sid=$(herdr agent list |
        python3 -c "
import sys, json
agents = json.load(sys.stdin)['result']['agents']
focused = [a for a in agents if a.get('focused')]
if not focused:
    sys.exit('no focused agent found')
a = focused[0]
if a.get('agent') != 'claude':
    sys.exit(\"focused agent is '%s', not claude\" % a.get('agent'))
print(a['agent_session']['value'])
"); then
        echo "herdr-fork-claude-session: CLAUDE_CODE_SESSION_ID is not set and could not resolve the focused Claude session" >&2
        exit 1
    fi
fi

direction="${1:-right}"
case "$direction" in
    right | down)
        split_dir="$direction"
        swap_dir=""
        ;;
    left)
        split_dir="right"
        swap_dir="left"
        ;;
    up)
        split_dir="down"
        swap_dir="up"
        ;;
    *)
        echo "herdr-fork-claude-session: direction must be 'right', 'down', 'left' or 'up', got '$direction'" >&2
        exit 1
        ;;
esac

pane=$(herdr pane split --current --direction "$split_dir" --cwd "$PWD" --no-focus |
    python3 -c "import sys, json; print(json.load(sys.stdin)['result']['pane']['pane_id'])")

if [ -n "$swap_dir" ]; then
    herdr pane swap --pane "$pane" --direction "$swap_dir" >/dev/null
fi

short_sid="${sid%%-*}"
name="claude-fork-${short_sid}"

if ! herdr agent start "$name" --kind claude --pane "$pane" -- \
    --resume "$sid" --fork-session >/dev/null; then
    echo "herdr-fork-claude-session: agent start failed for pane $pane" >&2
    exit 1
fi

echo "forked session $sid -> pane $pane ($name)"
