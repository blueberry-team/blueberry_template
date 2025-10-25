# Repository 레이어 가이드

**Repository 레이어는 데이터 소스를 추상화하고 재사용성을 높이기 위해 사용합니다.**

## ✅ Repository가 필요한 경우

### 1. REST API 호출

```dart
// features/github/repositories/github_repository.dart (실제 프로젝트 예제)
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
```

**OpenAPI Generator 사용 (권장)**

OpenAPI 스펙이 있다면 `openapi-generator-cli`를 사용하여 Repository 코드를 자동 생성할 수 있습니다.

### 2. 복잡한 데이터 처리 로직

여러 Controller에서 공통으로 사용하는 비즈니스 로직이 있는 경우에만 Repository로 분리합니다.

### 3. 로컬 데이터베이스 (SQLite, Hive 등)

로컬 DB 작업을 추상화하여 데이터 저장 방식을 Controller로부터 분리합니다.

### 4. Firebase/Supabase SDK (코드 정리 목적)

외부 SDK를 사용하더라도 코드 정리와 일관성을 위해 Repository 레이어를 추가할 수 있습니다.

```dart
// ✅ Repository로 Firebase 로직 분리 (선택적)
class TodoRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Todo>> getTodos() async {
    final snapshot = await _firestore.collection('todos').get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
  }

  Future<void> addTodo(Todo todo) async {
    await _firestore.collection('todos').add(todo.toJson());
  }
}

// Controller에서 사용
class TodoController extends AsyncNotifier<List<Todo>> {
  final _repository = TodoRepository();

  @override
  Future<List<Todo>> build() => _repository.getTodos();

  Future<void> addTodo(Todo todo) async {
    await _repository.addTodo(todo);
    ref.invalidateSelf(); // 상태 갱신
  }
}
```

**또는 Controller에서 직접 사용 (간단한 경우)**

```dart
// ✅ Controller에서 직접 사용 (간단한 경우)
class TodoController extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final snapshot = await FirebaseFirestore.instance.collection('todos').get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
  }
}
```

## ❌ Repository가 불필요한 경우

### 1. 간단한 UI 상태 관리

UI 상태만 관리한다면 Controller만으로 충분합니다.

### 2. 추상화가 가치를 더하지 않는 경우

Repository를 만들어도 단순히 SDK 메서드를 래핑만 하고 추가 로직이 없다면 불필요한 추상화일 수 있습니다 (YAGNI 원칙).

## 📋 정리

| 상황                   | Repository 필요 여부 | 이유                          |
| ---------------------- | -------------------- | ----------------------------- |
| REST API 호출          | ✅ 필요              | API 로직 분리 및 재사용       |
| GraphQL API            | ✅ 필요              | 쿼리/뮤테이션 관리            |
| 로컬 DB (SQLite, Hive) | ✅ 필요              | 저장 로직 추상화              |
| Firebase SDK           | ⚠️ 선택적            | 코드 정리 목적으로 생성 가능  |
| Supabase SDK           | ⚠️ 선택적            | 코드 정리 목적으로 생성 가능  |
| 간단한 UI 상태         | ❌ 불필요            | Controller만으로 충분         |

**핵심 원칙**: Repository 레이어는 **실제로 필요할 때만** 추가하세요. 과도한 추상화는 오히려 코드를 복잡하게 만듭니다.

## Controller에서 Repository 사용하기

```dart
// Repository 정의
class GitHubRepository {
  Future<GithubRepoModel> getRepo({required String owner, required String repo}) async {
    // API 호출 로직
  }
}

// Controller에서 사용
class GitHubNotifier extends AsyncNotifier<GithubRepoModel> {
  final _repository = GitHubRepository();

  @override
  Future<GithubRepoModel> build() => _repository.getRepo(owner: 'foo', repo: 'bar');
}
```
