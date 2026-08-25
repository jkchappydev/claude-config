# claude-config

개인용 Claude Code 전역 설정(`~/.claude`) 관리 저장소.

여러 기기(Mac / Windows)에서 Claude Code를 동일한 설정으로 쓰기 위해,
`~/.claude` 디렉토리 중 재사용 가능한 설정 파일만 골라 버전관리한다.

## 포함된 것

| 파일/폴더 | 설명 |
|---|---|
| `CLAUDE.md` | 전역 지침 (코드 주석 스타일, 프로젝트별 참조 규칙 등) |
| `settings.json` | model, statusLine, theme 등 기본 설정 |
| `statusline-command.sh` | 커스텀 statusline 스크립트 |
| `skills/` | 재사용 가능한 스킬 (Notion, Context7 등) |
| `rules/` | 전역 규칙 |
| `.mcp.json.example` | MCP 서버 설정 템플릿 (토큰은 플레이스홀더) |

## 새 기기에서 세팅하기

```bash
cd ~
git clone <이 저장소 주소> .claude
cd .claude

# MCP 설정 파일 생성 (토큰은 직접 채워넣기)
cp .mcp.json.example .mcp.json
# .mcp.json 열어서 ${NOTION_TOKEN} 자리에 실제 토큰 입력
```

## 업무 보고(daily-report / weekly-report) 설정

일일/주간 업무 보고는 프로젝트 Git 저장소가 아니라 `~/.claude` 전역에만 쌓인다 (`~/.claude/daily-report/`, `~/.claude/weekly-report/`). 새 기기에서 필요한 준비는 아래뿐이다.

1. 이 저장소를 클론하면 `skills/daily-report/`, `skills/weekly-report/`가 함께 세팅된다.
2. `CLAUDE.md`에 이미 업무 보고 규칙이 포함되어 있다.
3. 표시 이름을 한 번 등록한다: `git config --global report.name "홍길동"`
4. 각 프로젝트에서 `git config user.email`이 올바른지 확인한다 (파일명의 사용자ID로 쓰인다).

프로젝트 경로를 별도로 등록하는 과정은 없다 — `weekly-report`가 `~/.claude/daily-report/` 아래를 직접 훑는다.

## 제외된 것 (git에 올라가지 않음)

`.gitignore` 에 명시한 것 외에는 전부 기본 제외된다.
특히 아래 항목들은 인증정보/대화기록이라 절대 커밋하지 않는다:

- `.credentials.json`, `.mcp.json`, `backups/` — 인증 토큰
- `projects/`, `history.jsonl`, `sessions/` — 대화 기록 및 세션 데이터
- `references/` — 서버 접속 정보 등 인프라 민감 데이터
- `plugins/` — 마켓플레이스 clone (재설치로 복원 가능)
- 그 외 로컬 캐시/런타임 파일 (`cache/`, `shell-snapshots/`, `file-history/` 등)