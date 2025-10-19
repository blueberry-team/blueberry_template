# 스크린 & 위젯 작성 가이드

## 스크린 작성

### 기본 구조

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

### 주요 규칙

1. **ConsumerWidget 사용**: Riverpod 상태를 읽기 위해 필수
2. **const 생성자**: 가능한 모든 곳에 const 사용
3. **다국어화**: 하드코딩된 문자열 대신 `.tr()` 사용
4. **테마 접근**: `context.colors`로 색상 접근

### 예시: 실제 프로젝트의 SampleScreen

```dart
class SampleScreen extends ConsumerWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('sample.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => TodoItem(todos[index]),
      ),
    );
  }
}
```

## 위젯 작성

### 재사용 가능한 위젯

```dart
/// 커스텀 버튼 위젯
class CustomButton extends StatelessWidget {
  /// [CustomButton] 생성자
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 핸들러
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

### Feature 전용 위젯

Feature 내에서만 사용하는 위젯은 `widgets/` 폴더에:

```
features/todo/
└── widgets/
    ├── todo_item.dart
    └── todo_input_field.dart
```

### 공통 위젯

여러 feature에서 사용하는 위젯은 `lib/core/widgets/`에:

```
lib/core/widgets/
├── loading_indicator.dart
└── error_view.dart
```
