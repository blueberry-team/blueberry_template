# Blueberry Template

Flutter 프로젝트를 빠르게 시작할 수 있는 심플한 템플릿

## 특징

- 클린한 폴더 구조 (core/features)
- 다크/라이트 테마 (Material 3)
- Riverpod 3.0 상태 관리
- 다국어 지원
- 커스텀 디자인 시스템
- Firebase Crashlytics 통합

## 📚 문서

### Architecture (아키텍처)

- **[프로젝트 구조](docs/architecture/project-structure.md)** - 폴더 구조와 모듈화 전략
- **[스크린 & 위젯](docs/architecture/screens.md)** - 화면과 위젯 작성 가이드
- **[컨트롤러](docs/architecture/controllers.md)** - Riverpod 상태 관리 (Notifier, AsyncNotifier)
- **[서비스](docs/architecture/services.md)** - Service 레이어 사용 가이드
- **[에러 핸들링](docs/architecture/error-handling.md)** - 에러 처리와 Crashlytics

### Features (기능)

- **[다국어화](docs/features/localization.md)** - easy_localization 사용법
- **[테마](docs/features/theming.md)** - 색상, 타이포그래피, 테마 전환

### Setup (설정)

- **[Firebase 설정](docs/FIREBASE_SETUP.md)** - Firebase & Crashlytics 설정
- **[Claude Code MCP 설정](docs/CLAUDE_CODE_MCP_SETUP.md)** - Figma 연동 설정

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

### FVM 없이 사용

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
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
        └── services/
```

## 주요 패키지

- `flutter_riverpod: ^3.0.3` - 상태 관리
- `easy_localization: ^3.0.8` - 다국어 지원
- `google_fonts: ^6.3.2` - 폰트
- `http: ^1.2.2` - HTTP 클라이언트
- `firebase_core: ^4.2.0` - Firebase 코어
- `firebase_crashlytics: ^5.0.3` - 크래시 리포팅
- `pedantic_mono: ^1.34.0` - 린트 규칙

## 라이센스

MIT
