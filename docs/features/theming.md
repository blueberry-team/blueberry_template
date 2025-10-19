# 테마 시스템

## 색상 사용

### ThemeExtension 기반 커스텀 색상

프로젝트는 `AppColors` ThemeExtension을 사용합니다.

**현재 정의된 색상:**

- `surface` - 배경색
- `textPrimary` - 주요 텍스트
- `textSecondary` - 보조 텍스트
- `primary` - 주요 색상
- `secondary` - 보조 색상
- `error` - 에러 색상
- `success` - 성공 색상
- `warning` - 경고 색상

### 사용법

```dart
// ✅ GOOD: context.colors extension 사용
final colors = context.colors;

Text('Hello', style: TextStyle(color: colors.textPrimary));
Container(color: colors.primary);
```

### 투명도 적용 (Flutter 3.27+)

```dart
// ✅ GOOD: withValues 사용
Container(
  color: colors.primary.withValues(alpha: 0.8),  // 80% 투명도
)

// ❌ DEPRECATED: withOpacity 사용 금지
colors.primary.withOpacity(0.8);
```

### 새 색상 추가

`lib/core/themes/app_colors.dart` 수정:

```dart
static const light = AppColors(
  // 기존 색상들...
  divider: Color(0xFFE0E0E0),     // 새 색상 추가
  disabled: Color(0xFF9E9E9E),    // 비활성 상태
);

static const dark = AppColors(
  // 다크모드 색상...
  divider: Color(0xFF424242),
  disabled: Color(0xFF757575),
);
```

## 타이포그래피

### 현재 정의된 스타일

- `heading` - 32px, 일반 (큰 제목)
- `title` - 20px, 볼드 (중간 제목)
- `body` - 16px, 일반 (본문)
- `caption` - 14px, 일반 (작은 텍스트)

### 사용법

```dart
// ✅ GOOD: AppTypography 사용
Text('제목', style: AppTypography.heading);
Text('타이틀', style: AppTypography.title);
Text('본문', style: AppTypography.body);
Text('설명', style: AppTypography.caption);

// ✅ GOOD: 색상과 함께 사용
Text(
  '제목',
  style: AppTypography.heading.copyWith(
    color: context.colors.textPrimary,
  ),
);
```

### 새 스타일 추가

`lib/core/themes/app_typography.dart` 수정:

```dart
static const subtitle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: 'Noto Sans KR',
);
```

## 테마 토글

### ThemeController 사용

```dart
// 현재 테마 확인
final themeMode = ref.watch(themeControllerProvider);
final isDark = themeMode == ThemeMode.dark;

// 테마 전환
IconButton(
  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
  onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
);
```

### ThemeController 구현

`lib/core/controllers/theme_controller.dart`:

```dart
final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;  // 기본값

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
```

## Material 3

이 프로젝트는 Material 3 디자인을 사용합니다.

### 주요 특징

- Tone-based 색상 시스템
- Dynamic Color (기기 색상 따라가기) 지원 가능
- 새로운 컴포넌트 스타일

### AppTheme 정의

`lib/core/themes/app_theme.dart`:

```dart
static ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    extensions: const [AppColors.light],
    // ...
  );
}

static ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    extensions: const [AppColors.dark],
    // ...
  );
}
```

## 주의사항

❌ **하지 말 것:**

```dart
Container(color: Color(0xFF2196F3));  // 하드코딩된 색상
Text('제목', style: TextStyle(fontSize: 32));  // 직접 크기 지정
```

✅ **이렇게 하세요:**

```dart
Container(color: context.colors.primary);
Text('제목', style: AppTypography.heading);
```
