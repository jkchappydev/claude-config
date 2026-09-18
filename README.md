# ai-config

Claude Code(`~/.claude`)와 Codex(`~/.codex`)의 개인 전역 설정을 한 저장소에서 관리한다.

여러 기기(Mac / Windows)에서 두 도구를 **같은 지침·같은 설정**으로 쓰는 것이 목적이다.
설정 원본은 이 저장소에만 두고, 실제 경로에는 심볼릭 링크를 걸어 각 도구가 원래 자리에서 읽게 한다.

## 구조

```
~/ai-config/
  claude/
    CLAUDE.md              # Claude Code 전역 지침 → codex/AGENTS.md 를 import 만 함
    settings.json          # model, permissions, statusLine, hooks 등
    statusline-command.sh  # 상태줄 스크립트
    rules/                 # 항상 로드되는 추가 규칙
    skills/                # 전역 스킬
  codex/
    AGENTS.md              # ★ 공통 개발 지침 본문 (두 도구가 함께 보는 단일 원본)
  install.sh               # 심볼릭 링크 생성
```

링크는 아래와 같이 걸린다.

| 실제 경로 (도구가 읽는 위치) | 저장소 원본 |
|---|---|
| `~/.claude/CLAUDE.md` | `claude/CLAUDE.md` |
| `~/.claude/settings.json` | `claude/settings.json` |
| `~/.claude/statusline-command.sh` | `claude/statusline-command.sh` |
| `~/.claude/rules` | `claude/rules` |
| `~/.claude/skills` | `claude/skills` |
| `~/.codex/AGENTS.md` | `codex/AGENTS.md` |

## 지침은 AGENTS.md 한 곳에만 쓴다

Codex는 `~/.codex/AGENTS.md`를 전역 지침으로 직접 읽고, Claude Code는 `~/.claude/CLAUDE.md`의
`@~/ai-config/codex/AGENTS.md` import를 통해 같은 파일을 읽는다. 따라서 **공통 규칙은 반드시
`codex/AGENTS.md`에 쓴다.** `claude/CLAUDE.md`에 직접 쓴 내용은 Codex가 보지 못한다.

`CLAUDE.md`의 import 경로를 상대경로(`@../...`)로 바꾸면 안 된다 — `~/.claude/CLAUDE.md`가
심볼릭 링크이므로 기준 디렉터리가 달라질 수 있다. 홈 기준 경로(`@~/...`)를 유지한다.

프로젝트 단위 지침은 여전히 도구별로 갈린다. Claude Code는 프로젝트의 `CLAUDE.md`,
Codex는 프로젝트의 `AGENTS.md`를 읽는다.

## 새 기기에서 세팅하기

```bash
git clone https://github.com/jkchappydev/ai-config.git ~/ai-config
cd ~/ai-config
./install.sh
```

`install.sh`는 여러 번 실행해도 안전하다. 링크 자리에 기존 실제 파일이 있으면
`~/.ai-config-backup-<시각>/`으로 옮긴 뒤 링크로 교체한다.

Windows(Git Bash)에서는 심볼릭 링크 생성에 권한이 필요하다. 개발자 모드를 켜거나,
관리자 터미널에서 아래처럼 실행한다.

```bash
MSYS=winsymlinks:nativestrict ./install.sh
```

## 기기 전용으로 두는 것 (git 제외)

| 경로 | 내용 |
|---|---|
| `~/.claude/rules/*.local.md` | 그 기기에서만 적용할 규칙. 매 세션 자동 로드됨 |
| `~/.claude/references/` | 서버 SSH 접속 정보 등. `remote-server-check`가 읽음 |
| `~/.claude/skills/synced/` | Claude Code가 만드는 동기화 캐시 |
| `~/.codex/config.toml` | 모델·프로젝트 신뢰 설정. 기기별 경로가 들어가서 공유하지 않음 |

## 도구가 관리하므로 추적하지 않는 것

`~/.claude` 아래의 `.credentials.json`, `projects/`, `history.jsonl`, `sessions/`,
`plugins/`, `backups/`, 각종 캐시는 링크 대상이 아니므로 애초에 저장소에 들어오지 않는다.
`~/.codex`의 `auth.json`, `*.sqlite`, `logs/`도 마찬가지다.
