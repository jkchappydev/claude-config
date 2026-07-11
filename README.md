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

## 제외된 것 (git에 올라가지 않음)

`.gitignore` 에 명시한 것 외에는 전부 기본 제외된다.
특히 아래 항목들은 인증정보/대화기록이라 절대 커밋하지 않는다:

- `.credentials.json`, `.mcp.json`, `backups/` — 인증 토큰
- `projects/`, `history.jsonl`, `sessions/` — 대화 기록 및 세션 데이터
- `references/` — 서버 접속 정보 등 인프라 민감 데이터
- `plugins/` — 마켓플레이스 clone (재설치로 복원 가능)
- 그 외 로컬 캐시/런타임 파일 (`cache/`, `shell-snapshots/`, `file-history/` 등)