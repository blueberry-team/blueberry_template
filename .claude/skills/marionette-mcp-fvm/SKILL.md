---
name: marionette-mcp-fvm
description: FVM(Flutter Version Management)을 쓰는 Flutter 프로젝트의 `.mcp.json`에 Marionette MCP 항목을 추가/패치한다. 핵심은 (특히 Windows에서) `env.HOME` 주입 — FVM의 cli_completion이 `HOME=null`일 때 NPE로 죽어서 MCP 서버 spawn이 실패하는 문제를 회피한다. Windows / macOS / Linux 모두 지원. 사용자가 "이 프로젝트에 marionette 추가", "fvm 프로젝트에 마리오네트 설정", "마리오네트 mcp 프로젝트 설정", "fvm + marionette 설정", "다른 fvm 프로젝트에도 marionette 쓰고싶어" 같은 요청을 할 때 활성화. Flutter/Dart/FVM 관련.
---

# Marionette MCP — FVM 프로젝트 설정

FVM을 쓰는 Flutter 프로젝트의 **프로젝트 scope `.mcp.json`**에 marionette MCP 항목을 추가/패치한다. user scope(전역) 등록이 필요하면 대신 [[marionette-mcp-global]] skill을 사용.

**대상 OS**: Windows, macOS, Linux 모두 지원. 단 `.mcp.json` 형식이 OS별로 달라야 한다(아래 참조).

## 핵심: 왜 `env.HOME`이 필요한가

FVM은 시작 시 `cli_completion` 패키지로 shell completion을 자동 설치하려 한다. 이때 `_resolveHome()`이 `HOME` 환경변수를 null check operator(`!`)로 까는데, 자식 프로세스에 `HOME`이 전달되지 않으면 NPE로 죽는다:

```
Unhandled exception:
Null check operator used on a null value
#0  _resolveHome (package:cli_completion/src/installer/completion_installation.dart:462:49)
#1  CompletionInstallation._shellRCFilePath (...)
#4  CompletionCommandRunner.tryInstallCompletionFiles (...)
#6  FvmCommandRunner.runCommand (...)
```

결과: MCP 서버 자체가 안 뜸 → `-32000 Connection closed`.

**OS별 발생 가능성:**

| OS                | `HOME` 기본 전달                                                                 | env.HOME 주입 필요? |
| ----------------- | -------------------------------------------------------------------------------- | ------------------- |
| **Windows**       | ❌ Claude Code가 자식 프로세스에 `HOME`을 안 넘김 (Windows는 `USERPROFILE` 사용) | **필수**            |
| **macOS / Linux** | ✅ shell이 보통 `HOME`을 자동 전달                                               | 권장 (안전망)       |

## 목표 설정 형태

### Windows

```json
"marionette": {
  "command": "cmd",
  "args": ["/c", "fvm dart run marionette_mcp"],
  "env": { "HOME": "<USERPROFILE 값>" }
}
```

- `cmd /c` 가 필요한 이유: Windows의 `fvm`은 `.bat` 래퍼라 Node spawn API가 shell 없이는 실행 못 함.
- `HOME` 값은 실행 환경의 `$env:USERPROFILE` 결과를 그대로 사용 — **하드코딩 금지**.
- JSON에서 `\` → `\\` 이스케이프. 예: `C:\Users\alice` → `"C:\\Users\\alice"`.

### macOS / Linux

```json
"marionette": {
  "command": "fvm",
  "args": ["dart", "run", "marionette_mcp"],
  "env": { "HOME": "<HOME 값>" }
}
```

- `fvm`이 실행 파일이라 shell wrapper 없이 직접 호출 가능.
- `HOME` 값은 `$HOME` 결과 그대로 (예: `/Users/alice`, `/home/alice`). 이스케이프 불필요.
- shell이 보통 `HOME`을 전달하지만, env 명시는 **재현성/안전망** 목적.

> `.mcp.json` 파일 자체에는 한 가지 OS의 형태만 담긴다. 팀이 OS 혼용이면 `.mcp.json`을 `.gitignore`에 두고 각자 로컬 관리, 또는 `.mcp.json.example`을 두 OS용으로 제공하는 방식을 권한다.

## 사전 점검 (반드시 먼저 실행)

명령을 보여주고 `실행해드릴까요?` 물어본 뒤 확인받고 진행한다. CLAUDE.md의 Command Execution 규칙 준수.

1. **OS 확인** — 어떤 형태로 `.mcp.json`을 패치할지 결정:
   - PowerShell: `$PSVersionTable.Platform` (Win32NT / Unix)
   - bash/zsh: `uname -s` (Darwin / Linux)
2. **프로젝트가 FVM 사용 중인지** — `pubspec.yaml` + `.fvmrc` 또는 `.fvm/` 존재.
3. **FVM/Dart 동작** — `fvm dart --version` 정상 응답.
4. **marionette_mcp 의존성**:
   - Windows: `Select-String -Path pubspec.yaml -Pattern 'marionette_mcp|marionette_flutter'`
   - macOS/Linux: `grep -E 'marionette_mcp|marionette_flutter' pubspec.yaml`

   없으면 추가가 필요함을 알리고 사용자 승인 후:

   ```
   fvm flutter pub add marionette_flutter
   fvm flutter pub add dev:marionette_mcp
   ```

5. **`.mcp.json` 존재 여부**:
   - Windows: `Test-Path .mcp.json`
   - macOS/Linux: `test -f .mcp.json && echo exists`
6. **사용자 홈 경로 확인** (하드코딩 절대 금지):
   - Windows: `$env:USERPROFILE`
   - macOS/Linux: `echo $HOME`

## 패치 절차

### Case A — `.mcp.json`이 없는 경우

전체 파일을 생성. 위 "목표 설정 형태"에서 현재 OS에 맞는 한 블록을 골라 `mcpServers` 안에 넣는다. `HOME` 값은 사전 점검 6번에서 얻은 실제 경로(Windows는 `\\` 이스케이프).

### Case B — `.mcp.json`은 있지만 marionette 항목이 없는 경우

`mcpServers` 객체에 marionette 키만 추가. 다른 서버 항목은 **절대 건드리지 않는다**.

### Case C — `.mcp.json`에 marionette 항목이 이미 있지만 `env.HOME`이 없는 경우 (가장 흔함)

기존 항목에 `env` 필드만 주입:

```diff
 "marionette": {
   "command": "cmd",
-  "args": ["/c", "fvm dart run marionette_mcp"]
+  "args": ["/c", "fvm dart run marionette_mcp"],
+  "env": { "HOME": "<현재 OS의 홈 경로>" }
 }
```

`command`/`args`는 기존 값 유지 (사용자가 커스텀했을 수 있음). `env`가 이미 있으면 `HOME` 키만 추가/덮어쓰기.

### 편집 도구

- **`Edit`** 도구로 정확한 라인만 패치. 전체 파일 `Write` 재작성은 다른 MCP 서버 설정을 잃을 위험이 있어 피한다.
- 들여쓰기는 기존 파일 스타일(2-space)을 따른다.

## 검증

1. **JSON 유효성**:
   - Windows: `Get-Content .mcp.json -Raw | ConvertFrom-Json | Out-Null`
   - macOS/Linux: `python3 -m json.tool .mcp.json > /dev/null` 또는 `jq . .mcp.json > /dev/null`
2. **Claude Code 재시작 필수** — `.mcp.json` 변경은 새 세션에서만 인식됨.
3. 재시작 후 `/mcp` 명령으로 `marionette: connected` 확인.
4. 실패 시 **MCP 서버 로그** 확인 — 가장 최신 `.jsonl` 파일 끝의 `Server stderr:` 라인이 실제 실패 원인:
   - Windows: `%LOCALAPPDATA%\claude-cli-nodejs\Cache\<project-slug>\mcp-logs-marionette\`
   - macOS: `~/Library/Caches/claude-cli-nodejs/<project-slug>/mcp-logs-marionette/`
   - Linux: `~/.cache/claude-cli-nodejs/<project-slug>/mcp-logs-marionette/` (배포판에 따라 다를 수 있음)

## 트러블슈팅

| 증상                                                                                                        | 원인                                                 | 대응                                                                                                          |
| ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `Null check operator used on a null value` + `_resolveHome`                                                 | `env.HOME` 누락 (주로 Windows)                       | 본 skill 적용                                                                                                 |
| `The current Dart SDK version is X.Y.Z. Because <proj> requires SDK version ^A.B.C, version solving failed` | 시스템 PATH의 dart가 pubspec 요구 버전보다 낮음      | FVM SDK 업그레이드 또는 시스템 dart 업그레이드                                                                |
| `Can't load Kernel binary: Invalid kernel binary format version`                                            | FVM 자체의 캐시된 snapshot이 새 dart와 호환 안 됨    | `dart pub global activate fvm` 으로 FVM 재컴파일                                                              |
| `spawn fvm ENOENT` (macOS/Linux)                                                                            | `fvm`이 PATH에 없음 (셸이 spawn 환경과 다를 때 흔함) | 절대 경로 지정 (`/opt/homebrew/bin/fvm` 등) 또는 `command: "sh", args: ["-c", "fvm dart run marionette_mcp"]` |
| MCP가 새 세션에서도 안 잡힘                                                                                 | 캐시 또는 변경 미반영                                | Claude Code 완전 종료 후 재실행                                                                               |

## 가드레일

- 사용자가 명시적으로 요청하지 않는 한 명령을 자동 실행하지 않는다 (CLAUDE.md 규칙).
- `.mcp.json`을 수정할 때 marionette 외 다른 서버는 절대 변경하지 않는다.
- `pubspec.yaml`에 marionette 의존성이 없다면, 자동으로 추가하지 말고 먼저 사용자에게 확인한다.
- 사용자 홈 경로를 추측하지 말고, 현재 OS의 명령으로 실제 값을 얻어 사용한다 (Windows: `$env:USERPROFILE`, Unix: `$HOME`).
- main.dart의 `MarionetteBinding.ensureInitialized()` 추가는 본 skill의 책임 범위 밖이다 — 별도로 안내만 한다.

## 관련

- [[marionette-mcp-global]] — user scope(전역) 등록이 필요할 때
