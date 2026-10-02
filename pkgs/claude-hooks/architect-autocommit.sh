# PostToolUse hook for the architect: auto-commit every change to the project memory repo.
# Deliberately no errexit (the package sets only nounset + pipefail): a failing git call must never fail the hook.
MEM="${CLAUDE_MEMORY_DIR:-${CLAUDE_CONFIG_DIR:-$HOME/.claude}/memory}"
input="$(cat)"
path="$(jq -r '.tool_input.file_path // empty' <<<"$input")"
real="$(realpath "$MEM" 2>/dev/null)" || exit 0
# Never let git walk up into an enclosing repo (e.g. a dotfiles repo containing the data dir).
GIT_CEILING_DIRECTORIES="$(dirname "$real")"
export GIT_CEILING_DIRECTORIES
cd "$real" || exit 0
top="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
[ "$top" = "$real" ] || exit 0
git add -A >/dev/null 2>&1
git diff --cached --quiet && exit 0
rel="${path#"$MEM"/}"
rel="${rel#"$real"/}"
git commit -q --no-verify -m "architect: update ${rel:-memory}" >/dev/null 2>&1 || true
exit 0
