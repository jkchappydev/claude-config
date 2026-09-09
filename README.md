# claude-config

개인용 Claude Code 전역 설정(`~/.claude`) 관리 저장소.

여러 기기(Mac / Windows)에서 Claude Code를 동일한 설정으로 쓰기 위해,
`~/.claude` 디렉토리 중 재사용 가능한 설정 파일만 골라 버전관리한다.

## 공유 설정 (git 추적 · 모든 기기 공통)

| 경로 | 내용 |
|---|---|
| `C:\Users\JungGeunChan\.claude\CLAUDE.md` | 모든 기기·프로젝트에 적용되는 지침. 언어 설정, 코딩 스타일, 아키텍처, 코드 주석 스타일, 커밋 규칙, Git 워크트리 워크플로우, 애플리케이션 실행/종료 정책, 기기 전용 설정을 어디에 둘지 |
| `C:\Users\JungGeunChan\.claude\README.md` | 이 문서. 저장소 구조와 파일별 역할 |
| `C:\Users\JungGeunChan\.claude\settings.json` | model, theme, language, permissions, statusLine, hooks, 플러그인 등 Claude Code 동작 설정 |
| `C:\Users\JungGeunChan\.claude\statusline-command.sh` | 상태줄 스크립트. 표준입력 JSON을 node로 파싱해 모델명·컨텍스트 사용률·예상 비용을 한 줄로 출력 |
| `C:\Users\JungGeunChan\.claude\.gitignore` | 무엇을 공유하고 무엇을 기기 전용으로 둘지 결정. 화이트리스트 방식 |
| `C:\Users\JungGeunChan\.claude\rules\context7.md` | 라이브러리·프레임워크·CLI 문서는 Context7 MCP로 조회하라는 규칙 |
| `C:\Users\JungGeunChan\.claude\skills\context7-mcp\SKILL.md` | Context7으로 라이브러리 문서를 찾는 절차 |
| `C:\Users\JungGeunChan\.claude\skills\jenkins-build-diagnose\SKILL.md` | Jenkins 빌드/배포 실패 원인 진단. SSH로 접속해 빌드 결과와 콘솔 로그 조회 (조회 전용) |
| `C:\Users\JungGeunChan\.claude\skills\remote-server-check\SKILL.md` | 원격 서버 기동 여부·헬스체크·최근 에러 로그 확인 (조회 전용) |

## 이 기기 전용 (git 제외 · 다른 기기로 넘어가지 않음)

| 경로 | 내용 |
|---|---|
| `C:\Users\JungGeunChan\.claude\rules\report.local.md` | 업무 보고 규칙. 커밋 시 업무 보고 연동, 일일/주간 보고 작성 원칙, 저장 경로. 매 세션 자동 로드됨 |
| `C:\Users\JungGeunChan\.claude\skills\daily-report\SKILL.md` | 일일 업무 보고 작성 절차 (작성자 식별, 작업 단위 정리, 정보 출처 우선순위) |
| `C:\Users\JungGeunChan\.claude\skills\weekly-report\SKILL.md` | 일일 보고를 취합해 주간 업무 보고를 만드는 절차 |
| `C:\Users\JungGeunChan\.claude\skills\REPORT_SKILL_README.md` | 위 두 보고 스킬의 설계 배경과 상세 규칙 |
| `C:\Users\JungGeunChan\.claude\references\jenkins-server.md` | Jenkins 서버 SSH 접속 정보(IP, 사용자, 키 경로, 호스트키 지문)와 job별 파이프라인 방식. `jenkins-build-diagnose`가 읽음 |
| `C:\Users\JungGeunChan\.claude\references\lifebooks-servers.md` | 인생서가 서버 SSH 접속 정보와 헬스체크 정보(컨테이너명, 로그 경로). `remote-server-check`가 읽음 |

## 데이터 (설정 아님)

| 경로 | 내용 |
|---|---|
| `C:\Users\JungGeunChan\Desktop\daily-report\` | 날짜별 일일 업무 보고 (`YYYY-MM-DD-{사용자ID}.md`) |
| `C:\Users\JungGeunChan\Desktop\weekly-report\` | 주간 업무 보고 (`YYYY-Www.md`) |

## 새 기기에서 세팅하기

```bash
cd ~
git clone <이 저장소 주소> .claude
```

클론하면 공유 설정만 들어온다. 위 "이 기기 전용" 항목은 없는 상태이므로 필요한 것만 직접 만든다.

- `references/`가 비어 있으면 `remote-server-check`, `jenkins-build-diagnose`가 접속 정보를 찾지 못한다.
- 업무 보고를 그 기기에서도 쓰려면 `rules/*.local.md`와 보고 스킬을 따로 만들어야 한다.

## Claude Code가 관리하는 것 (커밋하지 않음)

- `.credentials.json` — 인증 토큰
- `projects/`, `history.jsonl`, `sessions/` — 대화 기록 및 세션 데이터
- `backups/` — 설정 자동 백업
- `plugins/` — 마켓플레이스 clone (재설치로 복원 가능)
- 그 외 로컬 캐시/런타임 파일 (`cache/`, `shell-snapshots/`, `file-history/`, `paste-cache/` 등)
