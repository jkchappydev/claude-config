---
name: jenkins-build-diagnose
description: 사용자가 "빌드 왜 실패했어?", "배포 확인해줘", "젠킨스 로그 봐줘" 등 Jenkins 빌드/배포 실패 원인을 물어볼 때 사용한다. SSH로 Jenkins 서버에 접속해 파일시스템 기반으로 빌드 결과와 콘솔 로그를 조회한다. 항상 조회 전용으로만 동작한다.
---

# Jenkins 빌드/배포 실패 진단 가이드

## 0. 절대 원칙 (읽기 전용)

- Jenkins의 "Build Now" 등 **빌드를 재실행/트리거하는 행위는 절대 하지 않는다.**
- 오직 조회만 한다: 파일 읽기(`build.xml`, `permalinks`), `curl`(GET, `consoleText`).

## 1. 대상 job 파악

- Jenkins 서버 접속 정보와 job 매핑은 `~/.claude/references/jenkins-server.md`를 참고한다.
- 사용자가 말한 앱/브랜치가 어떤 job 디렉터리에 대응하는지 애매하면, `ssh <jenkins서버> "ls /var/lib/jenkins/jobs"`로 실제 목록을 보여주고 고르게 한다.
- job 이름에 한글/공백이 있으면 이후 `consoleText` 조회 시 URL 인코딩이 필요하다.

## 2. 빌드 결과 확인

1. `ssh <jenkins서버> "cat '/var/lib/jenkins/jobs/<job>/builds/permalinks'"`로 `lastCompletedBuild`, `lastFailedBuild`, `lastSuccessfulBuild`, `lastUnsuccessfulBuild` 번호를 파악한다.
2. 진단 대상 빌드 번호를 정한다 — 사용자가 특정 번호를 지정하지 않으면 `lastCompletedBuild`를 기본값으로 쓴다.
3. `ssh <jenkins서버> "grep -o '<result>.*</result>' '/var/lib/jenkins/jobs/<job>/builds/<번호>/build.xml'"`로 결과를 확인한다 (SUCCESS / FAILURE / UNSTABLE / ABORTED / NOT_BUILT).

## 3. 실패 시 원인 추출

- `ssh <jenkins서버> "curl -s 'http://localhost:1080/job/<job(URL 인코딩)>/<번호>/consoleText'"`로 콘솔 로그를 가져온다. 원본 `log` 파일은 ANSI/바이너리가 섞여 지저분하므로 쓰지 않는다.
- 로그 전체를 그대로 보여주지 말고, 실제 에러가 발생한 지점(마지막 스택트레이스, `script returned exit code`, gradle/maven 에러 메시지 등)과 그게 어느 stage(`Jenkinsfile`의 stage 이름 기준)에서 났는지를 추려서 보고한다.
- 어느 stage에서 실패했는지 애매하면, 해당 job이 참조하는 `Jenkinsfile`(`lifebooks-gitops/jenkins/Jenkinsfile-*` 또는 job 자체 레포의 Jenkinsfile)을 같이 열어서 stage 구조와 대조한다.

## 4. 성공 시에도 "진짜 배포됐는지" 구분해서 보고

`jenkins-server.md`의 파이프라인 방식 구분을 반드시 확인한다:

- **GitOps/ArgoCD 방식** job이면: "Jenkins는 성공했지만 이건 GitOps manifest 갱신까지고, 실제 반영은 ArgoCD sync 확인이 필요하다"고 명시한다. 이 스킬은 ArgoCD sync 상태까지는 조회하지 않는다.
- **직접 배포(sshPublisher) 방식** job이면: "Jenkins 성공 = 배포 완료"로 보고한다.
- 어느 방식인지 `jenkins-server.md`에 없는 job이면, 짐작하지 말고 콘솔 로그에 `sshPublisher` 또는 `Update GitOps Manifest`류 stage가 있는지 확인해서 판단하고, 확인된 내용을 `jenkins-server.md`에 추가해 둔다.

## 5. 결과 보고 형식

```
## <job명> 빌드 진단 (#<번호>)

- 결과: SUCCESS / FAILURE / ...
- 실패 지점: <stage명> — <핵심 에러 1~3줄>
- 배포 상태: 배포 완료 / GitOps manifest 갱신까지 완료(ArgoCD sync 별도 확인 필요) / 실패로 배포 안 됨
```
