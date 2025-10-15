# 개발 가이드

## 린트 설정

### 커스텀 규칙

`analysis_options.yaml`에서 관리:

```yaml
linter:
  rules:
    require_trailing_commas: false
    cascade_invocations: false
```

---

## 테마

### 색상 사용

```dart
final colors = context.colors;

Text('Hello', style: TextStyle(color: colors.primary));
Container(color: colors.surface);
```

### 타이포그래피

```dart
Text('제목', style: AppTypography.heading);  // 32px
Text('타이틀', style: AppTypography.title);   // 20px bold
Text('본문', style: AppTypography.body);      // 16px
Text('설명', style: AppTypography.caption);   // 14px
```

### 테마 토글

```dart
final isDark = ref.watch(themeControllerProvider) == ThemeMode.dark;

IconButton(
  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
  onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
);
```

---

## Riverpod

### Provider 생성

```dart
final counterProvider = NotifierProvider<CounterController, int>(
  CounterController.new,
);

class CounterController extends Notifier<int> {
  @override
  int build() => 0;  // 초기값

  void increment() => state++;
  void decrement() => state--;
}
```

### 사용

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 읽기
    final count = ref.watch(counterProvider);

    return Column(
      children: [
        Text('$count'),
        ElevatedButton(
          // 메서드 호출
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: Text('+'),
        ),
      ],
    );
  }
}
```

### 리스트 상태 관리 예제

```dart
class Todo {
  const Todo(this.title, {this.isDone = false});
  final String title;
  final bool isDone;
}

final todoProvider = NotifierProvider<TodoController, List<Todo>>(
  TodoController.new,
);

class TodoController extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [];

  void add(String title) {
    state = [...state, Todo(title)];
  }

  void toggle(int index) {
    final updated = List<Todo>.from(state);
    final todo = updated[index];
    updated[index] = Todo(todo.title, isDone: !todo.isDone);
    state = updated;
  }

  void remove(int index) {
    final updated = List<Todo>.from(state);
    updated.removeAt(index);
    state = updated;
  }
}
```

---

## 다국어화

### 번역 파일

`assets/translations/ko.json`:
```json
{
  "app_title": "블루베리 TODO",
  "welcome": "환영합니다, {}님!",
  "items_count": "{} 개"
}
```

### 사용

```dart
Text('app_title'.tr());
Text('welcome'.tr(args: ['홍길동']));
Text('items_count'.tr(args: ['5']));
```

### 언어 변경

```dart
context.setLocale(Locale('ko'));  // 한국어
context.setLocale(Locale('en'));  // 영어
```

### 새 언어 추가

1. `assets/translations/ja.json` 파일 생성
2. `main.dart`에 추가:

```dart
EasyLocalization(
  supportedLocales: const [
    Locale('ko'),
    Locale('en'),
    Locale('ja'),  // 추가
  ],
  // ...
)
```

---