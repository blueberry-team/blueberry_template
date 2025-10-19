# Flutter 환경 설정 가이드 (Windows)

Windows에서 Flutter 개발 환경을 처음 설정하는 분들을 위한 가이드입니다.

## 목차

- [시스템 요구사항](#시스템-요구사항)
- [Chocolatey 설치](#chocolatey-설치)
- [Flutter SDK 설치](#flutter-sdk-설치)
- [추가 도구 설치](#추가-도구-설치)
- [Android 라이선스 동의](#android-라이선스-동의)
- [설치 확인](#설치-확인)
- [다음 단계](#다음-단계)

---

## 시스템 요구사항

- **운영체제**: Windows 10 이상 (64-bit)
- **디스크 공간**: 최소 2.5GB (IDE 및 도구 제외)
- **도구**: PowerShell 5.0 이상

---

## Chocolatey 설치

Chocolatey는 Windows용 패키지 관리자로, Flutter 및 개발 도구를 쉽게 설치할 수 있습니다.

### 1. PowerShell을 관리자 권한으로 실행

### 2. 다음 명령어 실행

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 3. 설치 확인

```powershell
choco --version
```

---

## Flutter SDK 설치

### 방법 1: Chocolatey로 설치 (권장)

```powershell
# PowerShell 관리자 권한으로 실행
choco install flutter -y
```

설치가 완료되면 환경 변수가 자동으로 설정됩니다.

### 방법 2: 공식 설치 파일 다운로드

1. [Flutter 공식 사이트](https://docs.flutter.dev/get-started/install/windows) 접속
2. **Flutter SDK** 다운로드 (최신 stable 버전)
3. 원하는 위치에 압축 해제 (예: `C:\src\flutter`)
   - ⚠️ `C:\Program Files\`처럼 관리자 권한이 필요한 경로는 피하세요

**환경 변수 설정:**

1. **Windows 검색**에서 "환경 변수" 입력
2. **시스템 환경 변수 편집** 클릭
3. **사용자 변수** 섹션에서 **Path** 선택 후 **편집**
4. **새로 만들기** 클릭 후 Flutter bin 경로 추가:
   ```
   C:\src\flutter\bin
   ```
5. **확인** 클릭하여 저장

### 방법 3: Git으로 설치

```powershell
# PowerShell에서 실행
cd C:\src
git clone https://github.com/flutter/flutter.git -b stable
```

방법 2와 동일하게 환경 변수를 설정하세요.

---

## 추가 도구 설치

### Git 설치

**방법 1: Chocolatey로 설치 (권장)**

```powershell
choco install git -y
```

**방법 2: 수동 설치**

1. [Git for Windows](https://git-scm.com/download/win) 다운로드 및 설치
2. 설치 후 터미널에서 확인:
   ```bash
   git --version
   ```

### Visual Studio 설치 (Windows 앱 개발용 - 필수)

Windows 데스크톱 앱을 개발하려면 Visual Studio가 필수입니다.

1. [Visual Studio 2022 Community](https://visualstudio.microsoft.com/downloads/) 다운로드
2. 설치 프로그램 실행
3. **워크로드** 선택 화면에서 다음을 체크:
   - ✅ **Desktop development with C++** (데스크톱 C++ 개발)
4. **설치** 클릭
5. 설치 완료 후 재부팅 (필요 시)

**참고:** Android/iOS만 개발한다면 건너뛰어도 되지만, `flutter doctor`에 경고가 표시됩니다.

### Android Studio 설치 (Android 개발용)

1. [Android Studio](https://developer.android.com/studio) 다운로드 및 설치
2. 설치 중 **Android SDK**, **Android SDK Platform**, **Android Virtual Device** 체크
3. 첫 실행 시 **Standard Setup** 선택
4. Flutter 및 Dart 플러그인 설치:
   - **File > Settings > Plugins**
   - **Flutter** 검색 후 설치 (Dart는 자동 설치됨)

### Visual Studio Code 설치 (코드 에디터 - 권장)

1. [VS Code](https://code.visualstudio.com/) 다운로드 및 설치
2. Extensions 설치:
   - **Flutter** 검색 후 설치
   - **Dart** (Flutter 설치 시 자동 설치됨)

---

## Android 라이선스 동의

```bash
flutter doctor --android-licenses
```

모든 라이선스에 `y` 입력하여 동의

---

## 설치 확인

```bash
flutter doctor -v
```

모든 항목이 ✓로 표시되면 설정 완료입니다.

문제가 있다면 [Flutter Doctor 문제 해결](FLUTTER_TROUBLESHOOTING.md) 문서를 참고하세요.

---

## 다음 단계

환경 설정이 완료되었다면:

1. **[FVM 설정](FLUTTER_SETUP_FVM.md)** - 프로젝트별 Flutter 버전 관리 (권장)
2. **[Firebase 설정](FIREBASE_SETUP.md)** - Firebase & Crashlytics 설정 (선택사항)
3. 프로젝트 실행:
   ```bash
   fvm flutter run
   ```

---

## 📚 참고 문서

- [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install/windows)
- [Chocolatey 공식 문서](https://chocolatey.org/)
- [Android Studio 설치 가이드](https://developer.android.com/studio/install)
