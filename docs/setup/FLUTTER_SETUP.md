# Flutter 환경 설정 가이드

Flutter 개발 환경을 처음 설정하는 분들을 위한 가이드입니다.

운영체제에 맞는 가이드를 선택하세요.

---

## ✅ 설정 체크리스트

### Windows

- [ ] Chocolatey 설치
- [ ] Flutter SDK 설치 (via Chocolatey)
- [ ] Git 설치
- [ ] Visual Studio 설치 (C++ 개발 도구)
- [ ] Android Studio 설치 + Flutter 플러그인
- [ ] VS Code 설치 + Flutter Extension (선택)
- [ ] Android 라이선스 동의
- [ ] FVM 설치
- [ ] 프로젝트 Flutter 버전 설치 (`fvm install`)
- [ ] `flutter doctor -v` 확인
- [ ] `fvm run` 커맨드 실행

### macOS

- [ ] Homebrew 설치
- [ ] Flutter SDK 설치 (via Homebrew)
- [ ] Xcode 설치
- [ ] Xcode 명령줄 도구 설정
- [ ] CocoaPods 설치
- [ ] Android Studio 설치 + Flutter 플러그인
- [ ] VS Code 설치 + Flutter Extension (선택)
- [ ] Android 라이선스 동의
- [ ] FVM 설치
- [ ] 프로젝트 Flutter 버전 설치 (`fvm install`)
- [ ] `flutter doctor -v` 확인
- [ ] `fvm run` 커맨드 실행

---

## 📖 설정 가이드

### 1️⃣ Flutter SDK 설치

운영체제에 맞는 설치 가이드를 따라하세요:

- **[Windows 환경 설정](FLUTTER_SETUP_WINDOWS.md)** - Chocolatey를 사용한 설치 방법
- **[macOS 환경 설정](FLUTTER_SETUP_MACOS.md)** - Homebrew를 사용한 설치 방법

### 2️⃣ FVM 설정 (필수)

Flutter SDK 설치 후 FVM을 설정하세요:

- **[FVM 설정 가이드](FLUTTER_SETUP_FVM.md)** - 프로젝트별 Flutter 버전 관리

### 3️⃣ 문제 해결

`flutter doctor` 실행 시 문제가 발생하면:

- **[Flutter Doctor 문제 해결](FLUTTER_TROUBLESHOOTING.md)** - 일반적인 문제와 해결 방법

---

## 빠른 설치 요약

### Windows

```powershell
# 1. Chocolatey 설치 (관리자 권한 PowerShell)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 2. Flutter 설치
choco install flutter -y
choco install git -y

# 3. FVM 설치
dart pub global activate fvm

# 4. 프로젝트 Flutter 버전 설치
cd blueberry_template
fvm install
fvm flutter pub get
```

### macOS

```bash
# 1. Homebrew 설치
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Flutter 설치
brew install --cask flutter
brew install cocoapods

# 3. FVM 설치
dart pub global activate fvm

# 4. 프로젝트 Flutter 버전 설치
cd blueberry_template
fvm install
fvm flutter pub get
```

---

## 📚 참고 문서

- [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install)
- [FVM 공식 문서](https://fvm.app/)
- [Chocolatey 공식 문서](https://chocolatey.org/) (Windows)
- [Homebrew 공식 문서](https://brew.sh/) (macOS)
