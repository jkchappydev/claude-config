# 워크로그 작업자 매핑 (템플릿)

`daily-worklog`/`worklog-weekly-review` 스킬이 Git author 이메일로 실제 작업자를 식별할 때 참고하는 매핑의 템플릿이다.
git에 커밋되는 공용 파일이라 실제 이메일·이름은 넣지 않는다.

## 사용법

1. 이 파일을 같은 폴더에 `worklog-members.local.md`로 복사한다 (그 파일은 `.gitignore` 대상).
2. `worklog-members.local.md`에 제목·설명 없이 표만 채운다.
3. 한 사람이 여러 Git 이메일을 쓰면, 같은 사용자ID·이름으로 행을 여러 개 등록한다.
4. 스킬은 **통합 모드에서만** `worklog-members.local.md`를 읽는다. 이 템플릿 파일(`worklog-members.md`)은 읽지 않는다.
5. 매핑에 없는 이메일은 이름을 추측하지 않는다 — Git author name이 있으면 그걸 쓰고, 없으면 이메일을 그대로 표시한다.

## `worklog-members.local.md` 예시

| 사용자ID | 이름 | Git 이메일 |
|---|---|---|
| developer-a | 홍길동 | developer-a@example.com |
| developer-b | 김개발 | developer-b@example.com |
| developer-b | 김개발 | developer-b@personal-email.com |
