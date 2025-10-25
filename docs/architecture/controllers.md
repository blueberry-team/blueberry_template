# 컨트롤러 작성 가이드

## NotifierProvider (동기 상태)

로컬 UI 상태, 리스트, 카운터 등에 사용합니다.

### 기본 예제

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

### 리스트 상태 관리

```dart
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

### UI에서 사용

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

## AsyncNotifierProvider (비동기 상태)

API 호출, 데이터베이스 작업 등 비동기 초기화가 필요한 경우 사용합니다.

### 실제 프로젝트 예제 (GitHub API)

```dart
// features/github/controllers/github_controller.dart
final githubProvider = AsyncNotifierProvider<GitHubNotifier, GithubRepoModel>(
  GitHubNotifier.new,
);

class GitHubNotifier extends AsyncNotifier<GithubRepoModel> {
  final _repository = GitHubRepository();

  @override
  Future<GithubRepoModel> build() {
    return _repository.getRepo(
      owner: 'blueberry-team',
      repo: 'blueberry_template',
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getRepo(
        owner: 'blueberry-team',
        repo: 'blueberry_template',
      ),
    );
  }
}
```

### UI에서 사용

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryAsync = ref.watch(githubProvider);

    // .when 대신 hasValue 사용 (간결함)
    return Scaffold(
      appBar: AppBar(
        title: repositoryAsync.hasValue
            ? Text(repositoryAsync.value!.name)
            : Text('Loading...'),
      ),
      body: repositoryAsync.when(
        data: (repo) => Text(repo.description),
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
```

## 왜 AsyncNotifierProvider를 사용하나?

- ✅ 새로고침, 재시도 등 메서드 추가 가능
- ✅ FutureProvider보다 유연함

## 주의사항

❌ **사용하지 말 것:**

- `StateNotifierProvider` (Riverpod 2.0 구식 패턴)
- 단순 비동기 데이터를 위한 `FutureProvider` (AsyncNotifierProvider 권장)
