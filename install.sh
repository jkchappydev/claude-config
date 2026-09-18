#!/usr/bin/env bash
# ~/.claude, ~/.codex 의 설정 파일을 이 저장소로 심볼릭 링크한다.
# 여러 번 실행해도 안전하며, 기존 실제 파일은 백업 후 교체한다.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.ai-config-backup-$(date +%Y%m%d-%H%M%S)"

# 저장소 경로 : 홈 기준 링크 경로
LINKS=(
  "claude/CLAUDE.md:.claude/CLAUDE.md"
  "claude/settings.json:.claude/settings.json"
  "claude/statusline-command.sh:.claude/statusline-command.sh"
  "claude/rules:.claude/rules"
  "claude/skills:.claude/skills"
  "codex/AGENTS.md:.codex/AGENTS.md"
)

link_one() {
  local src="$REPO/$1" dest="$HOME/$2"

  if [ ! -e "$src" ]; then
    echo "건너뜀 (저장소에 없음): $1"
    return
  fi

  # 이미 같은 곳을 가리키는 링크면 그대로 둠
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "이미 연결됨: ~/$2"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  # 기존 파일·디렉터리·잘못된 링크는 백업으로 옮김
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP/$(dirname "$2")"
    mv "$dest" "$BACKUP/$2"
    echo "백업: ~/$2 -> $BACKUP/$2"
  fi

  ln -s "$src" "$dest"
  echo "연결: ~/$2 -> $src"
}

for pair in "${LINKS[@]}"; do
  link_one "${pair%%:*}" "${pair##*:}"
done

echo
echo "=== 연결 상태 ==="
for pair in "${LINKS[@]}"; do
  dest="$HOME/${pair##*:}"
  if [ -L "$dest" ]; then
    printf '  %-34s -> %s\n' "~/${pair##*:}" "$(readlink "$dest")"
  else
    printf '  %-34s (링크 아님)\n' "~/${pair##*:}"
  fi
done
