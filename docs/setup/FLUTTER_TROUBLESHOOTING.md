# Flutter Doctor 문제 해결

`flutter doctor -v` 실행 후 나타나는 일반적인 문제와 해결 방법입니다.

## 목차

- [Android 관련 문제](#android-관련-문제)
- [iOS 관련 문제 (macOS)](#ios-관련-문제-macos)
- [Windows 앱 개발 관련](#windows-앱-개발-관련)
- [디바이스 연결 문제](#디바이스-연결-문제)
- [완료된 설정 예시](#완료된-설정-예시)

---

## Android 관련 문제

### ❌ cmdline-tools component is missing

**문제:**

```
✗ cmdline-tools component is missing
```

**해결 방법:**

1. Android Studio 실행
2. **Settings (또는 Preferences)** > **Appearance & Behavior** > **System Settings** > **Android SDK**
3. **SDK Tools** 탭 클릭
4. **Android SDK Command-line Tools (latest)** 체크
5. **Apply** 클릭하여 설치

---

### ❌ Android license status unknown

**문제:**

```
✗ Android license status unknown
```

**해결 방법:**

```bash
flutter doctor --android-licenses
```

모든 라이선스에 `y` 입력하여 동의

---

## iOS 관련 문제 (macOS)

### ❌ Xcode not installed

**문제:**

```
✗ Xcode - develop for iOS and macOS
```

**해결 방법:**

1. App Store에서 Xcode 설치
2. 명령줄 도구 설정:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   sudo xcodebuild -license accept
   ```

---

### ❌ CocoaPods not installed

**문제:**

```
✗ CocoaPods not installed
```

**해결 방법:**

**Homebrew로 설치 (권장):**

```bash
brew install cocoapods
pod setup
```

**gem으로 설치:**

```bash
sudo gem install cocoapods
pod setup
```

---

## Windows 앱 개발 관련

### ⚠️ Visual Studio not installed

**문제:**

```
! Visual Studio - develop for Windows
```

**해결 방법 (Windows 데스크톱 앱 개발 시):**

1. [Visual Studio 2022 Community](https://visualstudio.microsoft.com/downloads/) 다운로드
2. 설치 시 **Desktop development with C++** 워크로드 선택
3. 설치 완료 후 `flutter doctor` 재실행

**참고:** Android/iOS만 개발한다면 이 경고는 무시해도 됩니다.

---

## 디바이스 연결 문제

### ⚠️ Connected device not found

**문제:**

```
! No devices available
```

**해결 방법:**

#### Android 에뮬레이터 생성

1. Android Studio 실행
2. **Tools > Device Manager**
3. **Create Device** 클릭
4. 원하는 디바이스 선택 (예: Pixel 7)
5. 시스템 이미지 다운로드 (최신 API 레벨 권장)
6. **Finish** 클릭
7. 에뮬레이터 실행

#### iOS 시뮬레이터 실행 (macOS)

```bash
open -a Simulator
```

#### 실제 디바이스 연결

**Android:**

1. 설정 > 휴대전화 정보 > 빌드 번호 7회 탭 (개발자 옵션 활성화)
2. 설정 > 개발자 옵션 > USB 디버깅 ON
3. USB 케이블로 연결
4. 컴퓨터 신뢰 허용

**iOS (macOS):**

1. Mac과 iPhone을 케이블로 연결
2. iPhone에서 "이 컴퓨터를 신뢰하십니까?" 메시지에서 **신뢰** 선택
3. Mac 암호 입력

---

## 완료된 설정 예시

모든 설정이 완료되면 다음과 같이 표시됩니다:

```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.35.6, on macOS 14.0)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.0)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.1)
[✓] VS Code (version 1.85)
[✓] Connected device (3 available)
[✓] Network resources

• No issues found!
```

---

## 추가 도움말

문제가 해결되지 않는 경우:

1. [Flutter 공식 트러블슈팅 가이드](https://docs.flutter.dev/get-started/install)
2. [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
3. [Flutter Discord 커뮤니티](https://discord.gg/flutter)
4. [Stack Overflow - Flutter 태그](https://stackoverflow.com/questions/tagged/flutter)
