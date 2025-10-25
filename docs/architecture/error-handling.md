# 에러 핸들링 가이드

## Firebase Crashlytics

이 프로젝트는 Firebase Crashlytics를 사용하여 앱 크래시를 자동으로 수집합니다.

### 초기 설정 (main.dart)

```dart
void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase 초기화
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Flutter 에러 처리
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // 비동기 에러 처리
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    runApp(const MyApp());
  }, (error, stack) {
    // Zone에서 캐치되지 않은 에러 처리
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
```

### 수동으로 에러 기록

```dart
try {
  // 위험한 작업
} catch (e, stack) {
  FirebaseCrashlytics.instance.recordError(e, stack);
}
```

## AsyncNotifierProvider 에러 처리

### UI에서 에러 표시

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dataProvider);

    return dataAsync.when(
      data: (data) => Text(data.name),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorView(error: err),
    );
  }
}
```

### Controller에서 에러 처리

```dart
class DataNotifier extends AsyncNotifier<Data> {
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    // AsyncValue.guard는 자동으로 에러를 캐치
    state = await AsyncValue.guard(() => fetchData());
  }
}
```

## 네트워크 에러 처리

### Repository 계층에서

```dart
class GitHubRepository {
  Future<GithubRepoModel> getRepo({required String owner, required String repo}) async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load repository: ${response.statusCode}');
    }

    return GithubRepoModel.fromJson(jsonDecode(response.body));
  }
}
```

### 재시도 로직 (선택)

```dart
Future<T> retryOperation<T>(Future<T> Function() operation, {int maxRetries = 3}) async {
  int attempts = 0;

  while (attempts < maxRetries) {
    try {
      return await operation();
    } catch (e) {
      attempts++;
      if (attempts >= maxRetries) rethrow;
      await Future.delayed(Duration(seconds: attempts));
    }
  }

  throw Exception('Max retries exceeded');
}
```

## 린트 설정

`analysis_options.yaml`에서 에러 관련 설정:

```yaml
analyzer:
  errors:
    todo: warning # TODO 주석을 경고로 표시
```
