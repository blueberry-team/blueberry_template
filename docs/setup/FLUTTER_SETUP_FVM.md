# FVM 설정 가이드

이 프로젝트는 **FVM (Flutter Version Management)**을 사용하여 Flutter 버전을 관리합니다.

FVM을 사용하면 프로젝트마다 다른 Flutter 버전을 사용할 수 있어 버전 충돌 문제를 방지할 수 있습니다.

## 목차

- [FVM 설치](#fvm-설치)
- [환경 변수 설정](#환경-변수-설정)
- [프로젝트 Flutter 버전 설치](#프로젝트-flutter-버전-설치)
- [IDE 설정](#ide-설정)
- [사용 방법](#사용-방법)

---

## FVM 설치

### Windows (PowerShell)

```powershell
dart pub global activate fvm
```

### macOS/Linux

```bash
dart pub global activate fvm
```

**설치 완료 후 안내 메시지 확인:**

설치가 완료되면 다음과 같은 메시지가 표시됩니다:

```
Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.
You can fix that by adding this to your shell's config file:
  export PATH="$PATH":"$HOME/.pub-cache/bin"
```

이 메시지가 나타나면 아래 환경 변수 설정을 진행하세요.

---

## 환경 변수 설정 (PATH에 없는 경우)

`fvm --version` 명령어가 작동하지 않으면 수동으로 PATH를 추가해야 합니다.

### Windows

**방법 1: PowerShell 명령어 (권장)**

```powershell
# 현재 사용자의 PATH에 추가
[System.Environment]::SetEnvironmentVariable('Path', $env:Path + ";$env:USERPROFILE\AppData\Local\Pub\Cache\bin", [System.EnvironmentVariableTarget]::User)

# PowerShell 재시작 후 확인
fvm --version
```

**방법 2: GUI로 설정**

1. **Windows 검색**에서 "환경 변수" 입력
2. **시스템 환경 변수 편집** 클릭
3. **사용자 변수** 섹션에서 **Path** 선택 후 **편집**
4. **새로 만들기** 클릭 후 다음 경로 추가:
   ```
   %USERPROFILE%\AppData\Local\Pub\Cache\bin
   ```
5. **확인** 클릭하여 저장
6. **PowerShell을 재시작**

### macOS/Linux (Zsh)

```bash
# ~/.zshrc에 추가
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

### macOS/Linux (Bash)

```bash
# ~/.bash_profile에 추가
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bash_profile
source ~/.bash_profile
```

### 설치 확인

터미널을 재시작한 후:

```bash
fvm --version
```

정상적으로 버전이 표시되면 설정 완료입니다.

---

## 프로젝트 Flutter 버전 설치

### 1. 프로젝트 디렉토리로 이동

```bash
cd blueberry_template
```

### 2. 프로젝트에 지정된 Flutter 버전 설치

```bash
fvm install
```

이 명령어는 `.fvm/fvm_config.json` 파일에 지정된 Flutter 버전 (3.35.6)을 설치합니다.

### 3. 전역 Flutter 버전 설정 (선택사항)

```bash
fvm global 3.35.6
```

이 명령어를 실행하면 시스템 전체에서 이 버전을 기본으로 사용합니다.

---

## IDE 설정

### Visual Studio Code

프로젝트 루트에 `.vscode/settings.json` 파일이 이미 설정되어 있습니다.

수동으로 설정하려면:

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "search.exclude": {
    "**/.fvm": true
  },
  "files.watcherExclude": {
    "**/.fvm": true
  }
}
```

### Android Studio

1. **Settings (또는 Preferences)** > **Languages & Frameworks** > **Flutter**
2. **Flutter SDK path**를 프로젝트의 `.fvm/flutter_sdk`로 설정
   - 예: `/Users/username/blueberry_template/.fvm/flutter_sdk`

---

## 사용 방법

### 의존성 설치

```bash
fvm flutter pub get
```

### 앱 실행

```bash
fvm flutter run
```

### 테스트 실행

```bash
fvm flutter test
```

### 코드 포맷팅

```bash
fvm dart format .
```

### 분석

```bash
fvm flutter analyze
```

### 빌드

```bash
# Android APK
fvm flutter build apk

# iOS (macOS만 가능)
fvm flutter build ios
```

---

## 유용한 FVM 명령어

### 설치된 Flutter 버전 목록 확인

```bash
fvm list
```

### 사용 가능한 Flutter 버전 확인

```bash
fvm releases
```

### 특정 버전 설치

```bash
fvm install 3.35.6
```

### 프로젝트 Flutter 버전 변경

```bash
fvm use 3.35.6
```

### FVM 캐시 정리

```bash
fvm list
fvm remove <version>
```

---

## 📚 참고 문서

- [FVM 공식 문서](https://fvm.app/)
- [FVM GitHub](https://github.com/leoafarias/fvm)
