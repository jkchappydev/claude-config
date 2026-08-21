# 워크로그 통합 회고 대상 프로젝트 (템플릿)

`worklog-weekly-review` 스킬이 **통합 모드**에서 대상으로 삼는 프로젝트 목록의 템플릿이다.
git에 커밋되는 공용 파일이라 실제 회사 프로젝트 경로는 넣지 않는다.

## 사용법

1. 이 파일을 같은 폴더에 `worklog-projects.local.md`로 복사한다 (그 파일은 `.gitignore` 대상).
2. `worklog-projects.local.md`에 제목·설명 없이 실제 프로젝트 루트 경로만 한 줄에 하나씩 채운다.
3. `worklog-weekly-review`는 **통합 모드에서만** `worklog-projects.local.md`를 읽는다. 이 템플릿 파일(`worklog-projects.md`)은 읽지 않는다.

등록된 프로젝트 경로가 존재하지 않거나 `docs/worklog/`가 없으면 해당 프로젝트는 건너뛴다.

## `worklog-projects.local.md` 예시

```
C:\path\to\project-a
C:\path\to\project-b
```
