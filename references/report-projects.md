# 주간 업무 보고 대상 프로젝트

`weekly-report` 통합 모드에서 확인할 프로젝트 목록이다.

실제 프로젝트 경로는 `report-projects.local.md`에 작성한다.
이 파일은 공용 템플릿이므로 실제 회사 경로는 넣지 않는다.

## 사용법

1. 이 파일을 같은 폴더에 `report-projects.local.md`로 복사한다.
2. `report-projects.local.md`에 프로젝트 루트 경로를 한 줄에 하나씩 적는다.
3. `weekly-report`는 통합 모드에서 `report-projects.local.md`만 읽는다.

경로가 없거나 `docs/report/` 폴더가 없는 프로젝트는 건너뛴다.

## 예시

```text
C:\path\to\project-a
C:\path\to\project-b
```
