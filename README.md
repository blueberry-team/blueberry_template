# Blueberry Template

Flutter 프로젝트를 빠르게 시작할 수 있는 심플한 템플릿

## ⚙️ Setup (설정)

- **[Flutter 환경 설정](docs/setup/FLUTTER_SETUP.md)** - Flutter 개발 환경 구축
  - [Windows](docs/setup/FLUTTER_SETUP_WINDOWS.md) | [macOS](docs/setup/FLUTTER_SETUP_MACOS.md) | [FVM](docs/setup/FLUTTER_SETUP_FVM.md) | [문제 해결](docs/setup/FLUTTER_TROUBLESHOOTING.md)

## 시작하기

### FVM 사용 (권장)

이 프로젝트는 FVM으로 Flutter 버전을 관리합니다 (v3.35.6).

```bash
# FVM 설치 (처음 한 번만)
dart pub global activate fvm

# 프로젝트 Flutter 버전 설치
fvm install

# 의존성 설치
fvm flutter pub get

# 앱 실행
fvm flutter run
```

## Flutter 유용한 커맨드

```bash
# 패키지 추가
fvm flutter pub add package_name

# 코드 포맷팅
fvm dart format .

# 빌드 캐시 삭제
fvm flutter clean

# 빌드
fvm flutter build apk                        # Android APK 빌드
fvm flutter build appbundle                  # Android App Bundle 빌드
```

## Git 유용한 커맨드

```bash
# 직전 커밋 취소 (변경사항은 staged 상태로 유지)
git reset --soft HEAD~1

# 강제 푸시 (주의: 협업 시 사용 금지)
git push --force

```

## 폴더 구조

```
lib/
├── core/
│   ├── controllers/    # 전역 컨트롤러
│   └── themes/         # 테마 설정
└── features/           # 기능별 모듈
    ├── todo/
    │   ├── controllers/
    │   ├── models/
    │   └── screens/
    └── github/         # API 연동 예제
        ├── controllers/
        ├── models/
        └── repositories/
```

## 주요 패키지

- `flutter_riverpod: ^3.0.3` - 상태 관리
- `easy_localization: ^3.0.8` - 다국어 지원
- `google_fonts: ^6.3.2` - 폰트
- `http: ^1.2.2` - HTTP 클라이언트
- `firebase_core: ^4.2.0` - Firebase 코어
- `firebase_crashlytics: ^5.0.3` - 크래시 리포팅
- `pedantic_mono: ^1.34.0` - 린트 규칙

## 📚 문서

- **[프로젝트 구조](docs/architecture/project-structure.md)** - 폴더 구조와 모듈화 전략
- **[스크린 & 위젯](docs/architecture/screens.md)** - 화면과 위젯 작성 가이드
- **[컨트롤러](docs/architecture/controllers.md)** - Riverpod 상태 관리 (Notifier, AsyncNotifier)
- **[레포지토리](docs/architecture/repositories.md)** - Repository 레이어 사용 가이드
- **[다국어화](docs/features/localization.md)** - easy_localization 사용법
- **[테마](docs/features/theming.md)** - 색상, 타이포그래피, 테마 전환
- **[에러 핸들링](docs/architecture/error-handling.md)** - 에러 처리와 Crashlytics

---

## 🔧 추가 설정 (선택사항)

- **[Firebase 설정](docs/setup/FIREBASE_SETUP.md)** - Firebase & Crashlytics 설정
- **[Claude Code MCP 설정](docs/setup/CLAUDE_CODE_MCP_SETUP.md)** - Figma 연동 설정

## 라이센스

MIT
