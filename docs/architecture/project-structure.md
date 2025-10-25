# 프로젝트 구조

## 전체 구조

```
lib/
├── core/                      # 앱 전역 설정 및 유틸리티
│   ├── controllers/           # 전역 컨트롤러 (테마 등)
│   │   └── theme_controller.dart
│   ├── themes/                # 테마 관련
│   │   ├── app_colors.dart    # 색상 팔레트
│   │   ├── app_theme.dart     # Material Theme
│   │   └── app_typography.dart # 타이포그래피
│   └── extensions/            # 확장 메서드 (선택)
│
└── features/                  # 기능별 모듈화
    ├── todo/                  # 예시: TODO 기능
    │   ├── controllers/       # 상태 관리 (Riverpod)
    │   │   └── todo_controller.dart
    │   ├── models/            # 데이터 모델
    │   │   └── todo_model.dart
    │   └── screens/           # UI 화면
    │       └── sample_screen.dart
    └── github/                # 예시: GitHub API 기능
        ├── controllers/       # 상태 관리
        │   └── github_controller.dart
        ├── models/            # 데이터 모델
        │   └── github_repo_model.dart
        └── repositories/      # REST API 호출
            └── github_repository.dart
```

## 기능별 모듈 구조

각 기능(feature)은 독립적으로 관리됩니다:

```
features/[feature_name]/
├── controllers/    # 비즈니스 로직 및 상태 관리
├── models/         # 데이터 구조 정의
├── screens/        # 화면 UI
├── widgets/        # 재사용 가능한 위젯 (선택)
└── repositories/   # REST API 호출 등 (선택)
```

**예시: 새로운 "프로필" 기능 추가**

```
features/profile/
├── controllers/
│   └── profile_controller.dart
├── models/
│   └── user_model.dart
└── screens/
    ├── profile_screen.dart
    └── edit_profile_screen.dart
```

## 핵심 원칙

- **Feature-First**: 기능별로 독립적인 모듈 구성
- **응집도**: 관련된 파일들은 같은 feature 폴더에
- **재사용성**: core에는 여러 feature에서 공통으로 사용하는 것만
