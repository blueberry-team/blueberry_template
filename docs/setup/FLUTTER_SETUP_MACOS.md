# Flutter 환경 설정 가이드 (macOS)

macOS에서 Flutter 개발 환경을 처음 설정하는 분들을 위한 가이드입니다.

## 목차

- [시스템 요구사항](#시스템-요구사항)
- [Homebrew 설치](#homebrew-설치)
- [Flutter SDK 설치](#flutter-sdk-설치)
- [Xcode 설정](#xcode-설정)
- [추가 도구 설치](#추가-도구-설치)
- [Android 라이선스 동의](#android-라이선스-동의)
- [설치 확인](#설치-확인)
- [다음 단계](#다음-단계)

---

## 시스템 요구사항

- **운영체제**: macOS 11 (Big Sur) 이상
- **디스크 공간**: 최소 2.8GB (IDE 및 도구 제외)
- **도구**: Xcode (iOS 개발용)

---

## Homebrew 설치

Homebrew는 macOS용 패키지 관리자로, Flutter 및 개발 도구를 쉽게 설치할 수 있습니다.

### 1. Homebrew 설치 명령어 실행

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. PATH 설정

설치 후 안내 메시지에 따라 PATH 설정:

```bash
# Apple Silicon (M1/M2/M3)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel Mac
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

### 3. 설치 확인

```bash
brew --version
```

---

## Flutter SDK 설치

### 방법 1: Homebrew로 설치 (권장)

```bash
brew install --cask flutter
```

설치가 완료되면 환경 변수가 자동으로 설정됩니다.

### 방법 2: 공식 설치 파일 다운로드

1. [Flutter 공식 사이트](https://docs.flutter.dev/get-started/install/macos) 접속
2. **Flutter SDK** 다운로드
3. 원하는 위치에 압축 해제:
   ```bash
   cd ~/development
   unzip ~/Downloads/flutter_macos_*.zip
   ```

**환경 변수 설정 (Zsh - macOS 기본 쉘):**

```bash
# ~/.zshrc 파일 편집
nano ~/.zshrc

# 아래 내용 추가
export PATH="$PATH:$HOME/development/flutter/bin"

# 저장 후 적용
source ~/.zshrc
```

### 방법 3: Git으로 설치

```bash
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
```

방법 2와 동일하게 환경 변수를 설정하세요.

---

## Xcode 설정

iOS 개발을 위해서는 Xcode가 필수입니다.

### 1. Xcode 설치

App Store에서 **Xcode** 설치 (또는 [Apple Developer](https://developer.apple.com/xcode/))

### 2. 명령줄 도구 설정

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### 3. 라이선스 동의

```bash
sudo xcodebuild -license accept
```

---

## 추가 도구 설치

### CocoaPods 설치 (iOS 의존성 관리)

**방법 1: Homebrew로 설치 (권장)**

```bash
brew install cocoapods
```

**방법 2: gem으로 설치**

```bash
sudo gem install cocoapods
```

### Android Studio 설치 (Android 개발용)

**방법 1: Homebrew로 설치 (권장)**

```bash
brew install --cask android-studio
```

**방법 2: 수동 설치**

1. [Android Studio](https://developer.android.com/studio) 다운로드 및 설치
2. 설치 중 **Android SDK**, **Android SDK Platform**, **Android Virtual Device** 체크
3. Flutter 및 Dart 플러그인 설치:
   - **Android Studio > Settings > Plugins**
   - **Flutter** 검색 후 설치

### Visual Studio Code 설치 (선택사항)

**방법 1: Homebrew로 설치**

```bash
brew install --cask visual-studio-code
```

**방법 2: 수동 설치**

1. [VS Code](https://code.visualstudio.com/) 다운로드 및 설치
2. Extensions 설치:
   - **Flutter**
   - **Dart**

---

## Android 라이선스 동의

Android 개발을 하는 경우에만 필요합니다.

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

- [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install/macos)
- [Homebrew 공식 문서](https://brew.sh/)
- [Xcode 설치 가이드](https://developer.apple.com/xcode/)
