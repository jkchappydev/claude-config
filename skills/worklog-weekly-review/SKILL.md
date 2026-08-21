---
name: worklog-weekly-review
description: 이번 주 프로젝트 워크로그를 모아 주간보고를 작성한다. 개별 프로젝트에서는 현재 프로젝트를, 전역 ~/.claude에서는 등록된 모든 프로젝트를 통합해 정리한다.
---

# 주간 워크로그 회고

## 동작 방식

- **기본**: 현재 프로젝트의 `docs/worklog/YYYY-MM-DD.md`(이번 주 월~일)만 정리한다.
- **통합 모드**: 사용자가 "통합 회고", "여러 프로젝트"를 요청했거나, 실행 위치가 전역 `~/.claude`면 통합 모드로 동작한다. 전역에서는 항상 통합 모드다.

## 통합 모드

- 대상: `~/.claude/references/worklog-projects.local.md`에 등록된 프로젝트.
- 등록된 프로젝트 경로가 존재하지 않거나 `docs/worklog/`가 없으면 해당 프로젝트는 건너뛴다.
- `worklog-projects.local.md`가 없으면, 템플릿(`worklog-projects.md`)을 복사해서 만들라고 안내하고 종료한다.
- `worklog-projects.md`는 git에 커밋되는 템플릿일 뿐이므로 대상 목록으로 읽지 않는다.

## 저장

- 개별 프로젝트: `docs/worklog/weekly/YYYY-Www.md`
- 전역 `~/.claude`: `~/.claude/worklog-weekly/YYYY-Www.md`

대상 기간에 워크로그가 하나도 없으면 파일을 만들지 않고 종료한다.

## 작성 형식

```markdown
# YYYY-Www 주간보고 (YYYY-MM-DD ~ YYYY-MM-DD)

## 완료된 작업
- ...

## 진행 중 / 이슈
- [이슈명]: 현재 상황 → 다음 액션

## 다음 주 예정
- ...
```

통합 주간보고는 각 항목 안에서 프로젝트별로 구분한다.

## 작성 원칙

- 날짜별 내용을 단순 나열하지 않고, 중복을 제거해 작업 단위로 통합한다.
- 완료된 작업은 무엇을 했고 결과가 어땠는지 드러나게 쓴다.
- 진행 중인 이슈는 현재 상황과 다음 액션을 함께 쓴다.
- 기존 일별 워크로그는 수정하지 않는다.
