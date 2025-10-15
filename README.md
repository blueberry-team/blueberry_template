# Blueberry Template

Flutter 프로젝트를 빠르게 시작할 수 있는 심플한 템플릿

## 특징

- 클린한 폴더 구조 (core/features)
- 다크/라이트 테마 (Material 3)
- Riverpod 2.0+ 상태 관리
- 다국어 지원
- 커스텀 디자인 시스템

## 문서

- **[개발 가이드](GUIDE.md)**

## 시작하기

```bash
# 의존성 설치
fvm flutter pub get

# 앱 실행
fvm flutter run
```

## 폴더 구조

```
lib/
├── core/
│   ├── controllers/    # 전역 컨트롤러
│   └── themes/         # 테마 설정
└── features/           # 기능별 모듈
    └── todo/
        ├── controllers/
        ├── models/
        └── screens/
```

## 주요 패키지

- `flutter_riverpod: ^2.6.1` - 상태 관리
- `easy_localization: ^3.0.8` - 다국어 지원
- `google_fonts: ^6.2.1` - 폰트
- `pedantic_mono: ^1.33.0` - 린트 규칙

## 라이센스

MIT
