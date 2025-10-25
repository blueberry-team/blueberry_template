# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Blueberry Template is a Flutter starter template (Korean-language project) with clean architecture, Material 3 theming, Riverpod 3.0 state management, easy_localization, and Firebase Crashlytics.

- **Flutter Version:** 3.35.6 (managed via FVM)
- **Primary Language:** Korean (documentation and comments in Korean)
- **State Management:** Riverpod 3.0
- **Min SDK:** 3.8.1

## Development Commands

### Setup & Dependencies

```bash
# Install Flutter version via FVM (required for this project)
fvm install

# Install dependencies
fvm flutter pub get

# Add new packages (always use this instead of manual pubspec.yaml edits)
fvm flutter pub add package_name
fvm flutter pub add package_name --dev  # for dev dependencies
```

### Running & Testing

```bash
# Run the app
fvm flutter run

# Run tests with coverage
flutter test --coverage

# Run a specific test file
flutter test test/path/to/test_file.dart

# Run a specific test by name
flutter test --name "test name"

# Lint analysis
flutter analyze --no-fatal-infos

# Format code
dart format .

# Build Android APK
flutter build apk
```

### Code Generation (when using freezed, json_serializable, etc.)

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Architecture Overview

### Feature-Based Modular Structure

This codebase follows a **feature-first architecture** where each feature is self-contained:

```
lib/
├── core/              # Global app concerns
│   ├── controllers/   # Global state (e.g., ThemeController)
│   └── themes/        # Design system (AppColors, AppTypography, AppTheme)
└── features/          # Feature modules (isolated & independent)
    ├── todo/
    ├── github/
    └── [feature]/
        ├── controllers/  # Riverpod state management
        ├── models/       # Data models
        ├── screens/      # UI screens
        ├── widgets/      # Feature-specific widgets (optional)
        └── repositories/ # API/data layer (optional - see guidelines below)
```

### When to Create a Repository Layer

**Create `repositories/` when:**
- Making REST API calls (see `features/github/repositories/github_repository.dart` as example)
- Implementing GraphQL queries
- Working with local databases (SQLite, Hive)
- Need to abstract complex data operations shared across multiple controllers
- Using Firebase/Supabase SDKs but want to organize code better (코드 정리 목적으로 Repository 생성 가능)

**Skip `repositories/` when:**
- Managing simple UI state only
- The abstraction doesn't add value (YAGNI 원칙)

**Example: REST API pattern (github feature)**

```dart
// ✅ Repository 계층 (features/github/repositories/github_repository.dart)
class GitHubRepository {
  static const _baseUrl = 'https://api.github.com';

  Future<GithubRepoModel> getRepo({
    required String owner,
    required String repo,
  }) async {
    final url = Uri.parse('$_baseUrl/repos/$owner/$repo');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load repository: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return GithubRepoModel.fromJson(data);
  }
}

// ✅ Controller에서 Repository 사용 (features/github/controllers/github_controller.dart)
final githubProvider = AsyncNotifierProvider<GitHubNotifier, GithubRepoModel>(
  GitHubNotifier.new,
);

class GitHubNotifier extends AsyncNotifier<GithubRepoModel> {
  final _repository = GitHubRepository();

  @override
  Future<GithubRepoModel> build() {
    return _repository.getRepo(owner: 'blueberry-team', repo: 'blueberry_template');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getRepo(owner: 'blueberry-team', repo: 'blueberry_template'),
    );
  }
}
```

### Provider 작성 규칙

**동기(Synchronous) 상태 - NotifierProvider**

```dart
// ✅ GOOD: 동기 상태는 NotifierProvider 사용
final todoProvider = NotifierProvider<TodoController, List<Todo>>(
  TodoController.new,
);

class TodoController extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [];  // 동기 초기값

  void add(String title) {
    state = [...state, Todo(title)];
  }
}
```

**비동기(Asynchronous) 상태 - AsyncNotifierProvider**

```dart
// ✅ GOOD: 비동기 상태는 AsyncNotifierProvider 사용
final userProvider = AsyncNotifierProvider<UserController, User?>(
  UserController.new,
);

class UserController extends AsyncNotifier<User?> {
  final _userRepository = UserRepository();
  final _authRepository = AuthRepository();

  @override
  Future<User?> build() async {
    // 비동기 초기화 (API 호출, DB 읽기 등)
    return await _userRepository.getCurrentUser();
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _authRepository.signIn(email, password);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await _authRepository.signOut();
    state = const AsyncData(null);
  }
}
```

**사용 예시:**

```dart
// 동기 Provider
final todos = ref.watch(todoProvider);

// 비동기 Provider
final userAsync = ref.watch(userProvider);
userAsync.when(
  data: (user) => Text(user?.name ?? 'Guest'),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

**❌ BAD: 구식 패턴**
```dart
// StateNotifierProvider (Riverpod 2.0 이전)
final todoProvider = StateNotifierProvider<TodoController, List<Todo>>(...);

// FutureProvider (간단한 경우 외에는 AsyncNotifierProvider 사용 권장)
final userProvider = FutureProvider<User?>(...);
```

### Riverpod 3.0 주요 기능

**자동 재시도 (Automatic Retry)**
- Provider 초기화 실패 시 자동으로 exponential backoff로 재시도
- 네트워크 일시적 문제 해결에 유용

**Mutations (실험적)**
- UI에서 side effect 처리 (form 제출, 저장 등)
- loading/error 상태 자동 관리

**오프라인 지속성 (실험적)**
- Provider 데이터 로컬 캐싱
- 앱 재시작 시 복원

```dart
// 예: Mutation 사용
final saveTodoMutation = Mutation<void, String>(
  (ref, title) async {
    final todoRepository = TodoRepository();
    await todoRepository.save(title);
  },
);

// Widget에서 사용
ref.read(saveTodoMutation).future('New todo');
if (saveTodoMutation.isLoading) CircularProgressIndicator();
```

### Widget에서 사용

```dart
// ✅ GOOD: ConsumerWidget 사용
class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, i) => TodoItem(todos[i]),
    );
  }
}

// ✅ GOOD: 메서드 호출
ref.read(todoProvider.notifier).add('New todo');
```

## 디자인 시스템

### 색상 사용

프로젝트는 **ThemeExtension 기반 커스텀 색상 시스템**을 사용합니다.

**현재 정의된 AppColors:**
- `surface`, `textPrimary`, `textSecondary`
- `primary`, `secondary`
- `error`, `success`, `warning`

```dart
// ✅ GOOD: context.colors extension 사용
final colors = context.colors;
Container(color: colors.primary);
Text('Hello', style: TextStyle(color: colors.textPrimary));

// ✅ GOOD: 색상에 투명도 적용 (Flutter 3.27+)
Container(
  color: colors.primary.withValues(alpha: 0.8),  // 80% 투명도
)

// ⚠️ DEPRECATED: withOpacity 사용 금지 (Flutter 3.27+)
colors.primary.withOpacity(0.8);  // 이렇게 하지 마세요!

// ❌ BAD: 하드코딩된 색상
Container(color: Color(0xFF2196F3));
```

**투명도 적용 가이드 (Material 3):**
- Flutter 3.27+에서는 `withOpacity()` 대신 `withValues(alpha:)` 사용
- Material 3는 tone-based surface 시스템 사용 (elevation 기반 opacity 대신)
- 버튼/상호작용 상태에서는 여전히 opacity 사용

```dart
// 새 색상이 필요한 경우 AppColors에 추가
static const light = AppColors(
  // 기존 색상들...
  divider: Color(0xFFE0E0E0),        // 새 색상 추가 예시
  disabled: Color(0xFF9E9E9E),       // 비활성 상태 색상
);
```

### 타이포그래피

**현재 정의된 AppTypography:**
- `heading` - 32px, 일반 (큰 제목)
- `title` - 20px, 볼드 (중간 제목)
- `body` - 16px, 일반 (본문)
- `caption` - 14px, 일반 (작은 텍스트)

```dart
// ✅ GOOD: AppTypography 사용
Text('제목', style: AppTypography.heading);
Text('타이틀', style: AppTypography.title);
Text('본문', style: AppTypography.body);
Text('설명', style: AppTypography.caption);

// ✅ GOOD: 색상과 함께 사용
Text('제목', style: AppTypography.heading.copyWith(
  color: context.colors.textPrimary,
));

// ⚠️ ACCEPTABLE: 새로운 스타일 필요 시 AppTypography에 추가
// lib/core/themes/app_typography.dart에 추가:
static const subtitle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: 'Noto Sans KR',
);

// ❌ BAD: 직접 크기 지정
Text('제목', style: TextStyle(fontSize: 32));
```

### 간격

```dart
// ⚠️ 프로젝트에 AppSpacing이 정의되어 있지 않음
// 필요시 lib/core/themes/app_spacing.dart 생성 권장:
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

// 현재는 직접 값 사용
SizedBox(height: 16);
Padding(padding: EdgeInsets.all(24));
```

## 다국어화 (easy_localization)

### 번역 키 규칙

- 파일 위치: `assets/translations/ko.json`, `assets/translations/en.json`
- 키 네이밍: `feature.component.text` (예: `todo.add_button`, `common.cancel`)

```dart
// ✅ GOOD: 번역 키 사용
Text('todo.add_button'.tr());
Text('common.welcome'.tr(args: [userName]));

// ❌ BAD: 하드코딩된 문자열
Text('추가하기');
```

## 코드 스타일

### 문서화

```dart
/// Todo 항목을 관리하는 컨트롤러
///
/// 추가, 삭제, 완료 상태 변경 기능을 제공합니다.
class TodoController extends Notifier<List<Todo>> {
  /// 새로운 할 일을 추가합니다.
  ///
  /// [title]이 비어있으면 추가하지 않습니다.
  void add(String title) {
    if (title.isEmpty) return;
    state = [...state, Todo(title)];
  }
}
```

### const 사용

```dart
// ✅ GOOD: const 생성자 최대한 활용
const SizedBox(height: 16);
const Padding(padding: EdgeInsets.all(8));

// ⚠️ OK: const로 만들 수 없는 경우
SizedBox(height: dynamicValue);
```

### 린트 규칙

프로젝트는 `pedantic_mono` 기반이며, 다음 규칙을 완화했습니다:

```yaml
# analysis_options.yaml
linter:
  rules:
    require_trailing_commas: false  # trailing comma 선택사항
    cascade_invocations: false      # cascade 강제 안 함
```

## 파일 생성 가이드

### 새 기능(Feature) 추가 시

1. `lib/features/[feature_name]/` 디렉토리 생성
2. 다음 하위 구조 생성:
   - `screens/` - UI 화면
   - `controllers/` - Riverpod 상태 관리
   - `models/` - 데이터 모델
   - `widgets/` - 해당 기능 전용 위젯 (선택)

### 새 화면(Screen) 추가 시

```dart
/// [FeatureName] 메인 화면
class FeatureNameScreen extends ConsumerWidget {
  /// [FeatureNameScreen] 생성자
  const FeatureNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: Text('feature.title'.tr())),
      body: const Center(child: Text('Content')),
    );
  }
}
```

### 새 모델(Model) 추가 시

**간단한 모델:**
```dart
/// [ModelName] 데이터 모델
class ModelName {
  /// [ModelName] 생성자
  const ModelName({
    required this.id,
    required this.name,
  });

  /// 고유 식별자
  final String id;

  /// 이름
  final String name;
}
```

## 금지 사항

❌ **하지 말아야 할 것들:**

1. `setState` 사용 (Riverpod 사용)
2. `Provider` 패키지 사용 (Riverpod만 사용)
3. 하드코딩된 색상/폰트/문자열
4. 글로벌 변수 남용
5. 과도한 추상화 (YAGNI 원칙)
6. 영어 doc comment (한국어 사용)

## 개발 워크플로우

### 패키지 추가
**⚠️ 중요: 패키지는 반드시 명령어로 추가**

```bash
# ✅ GOOD: 명령어로 패키지 추가
fvm flutter pub add package_name
fvm flutter pub add package_name --dev  # dev dependency

# ❌ BAD: pubspec.yaml 직접 수정 금지
```

**이유:**
- `fvm flutter pub add`는 자동으로 최신 호환 버전을 찾아 추가
- pubspec.yaml 포맷팅 유지
- 의존성 충돌 자동 해결
- 즉시 패키지 다운로드

### 의존성 설치
```bash
fvm flutter pub get
```

### 앱 실행
```bash
fvm flutter run
```

### 코드 생성 (freezed, json_serializable 등)
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### 분석
```bash
fvm flutter analyze
```

## 네이밍 컨벤션

### 파일명 (snake_case)

```
✅ GOOD:
- user_controller.dart
- auth_repository.dart
- sample_screen.dart
- custom_button.dart
- app_colors.dart

❌ BAD:
- UserController.dart (PascalCase)
- authRepository.dart (camelCase)
- sample-screen.dart (kebab-case)
```

### 폴더명 (snake_case)

```
✅ GOOD:
lib/
├── features/
│   ├── user_profile/
│   ├── todo/
│   └── settings/

❌ BAD:
├── userProfile/ (camelCase)
├── user-profile/ (kebab-case)
```

### 클래스명 (PascalCase + 접미사)

**Controller (상태 관리)**
```dart
✅ GOOD:
- TodoController (동기)
- UserController (비동기)
- ThemeController
- AuthController

❌ BAD:
- TodoNotifier
- TodoProvider
- TodoState
```

**파일명 매핑:**
- `TodoController` → `todo_controller.dart`
- `UserProfileController` → `user_profile_controller.dart`

**Screen (화면)**
```dart
✅ GOOD:
- SampleScreen
- HomeScreen
- UserProfileScreen

파일명: sample_screen.dart
```

**Model (데이터)**
```dart
✅ GOOD:
- User
- Todo
- Product

파일명: user.dart, todo.dart
```

**Widget (재사용 컴포넌트)**
```dart
✅ GOOD:
- CustomButton
- LoadingIndicator
- UserAvatar

파일명: custom_button.dart
```

**Repository (데이터 계층)**
```dart
✅ GOOD:
- UserRepository
- TodoRepository
- AuthRepository

파일명: user_repository.dart
```

### Provider 변수명 (camelCase)

```dart
✅ GOOD:
final todoProvider = NotifierProvider<TodoController, List<Todo>>(...);
final userProvider = AsyncNotifierProvider<UserController, User?>(...);
final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(...);

❌ BAD:
final TodoProvider = ...  (PascalCase)
final todo_provider = ...  (snake_case)
```

## 요약

- **상태 관리**: Riverpod 3.0
  - 동기: NotifierProvider
  - 비동기: AsyncNotifierProvider
  - Mutations, 자동 재시도
- **디자인 시스템**:
  - AppColors (ThemeExtension) - `context.colors` 사용
  - AppTypography (heading/title/body/caption)
  - 투명도: `withValues(alpha:)` 사용 (Flutter 3.27+)
- **다국어**: easy_localization (`.tr()`)
- **구조**: core/ (전역) + features/ (기능별)
- **네이밍**:
  - 파일/폴더: snake_case
  - 클래스: PascalCase + 접미사 (Controller, Screen, Repository)
  - Provider 변수: camelCase + Provider 접미사
- **스타일**: 심플, const 최대 활용, 문서화
- **모델**: 간단한 경우 plain class, 복잡한 경우 freezed 사용