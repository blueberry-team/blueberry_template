# Service 레이어 가이드

**Service 레이어는 데이터 소스를 추상화하고 재사용성을 높이기 위해 사용합니다.**

## ✅ Service가 필요한 경우

### 1. REST API 호출

```dart
// features/github/services/github_service.dart (실제 프로젝트 예제)
class GitHubService {
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

OpenAPI 스펙이 있다면 `openapi-generator-cli`를 사용하여 Service 코드를 자동 생성할 수 있습니다.

### 2. 복잡한 데이터 처리 로직

여러 Controller에서 공통으로 사용하는 비즈니스 로직이 있는 경우에만 Service로 분리합니다.

### 3. 로컬 데이터베이스 (SQLite, Hive 등)

로컬 DB 작업을 추상화하여 데이터 저장 방식을 Controller로부터 분리합니다.

## ❌ Service가 불필요한 경우

### 1. Firebase/Supabase 같은 SDK

이미 완성도 높은 API를 제공하므로 Controller에서 직접 사용하는 것이 더 간단합니다.

```dart
// ✅ Controller에서 직접 사용 (권장)
class TodoController extends Notifier<List<Todo>> {
  Future<void> loadTodos() async {
    final snapshot = await FirebaseFirestore.instance.collection('todos').get();
    state = snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
  }
}
```

### 2. 간단한 UI 상태 관리

UI 상태만 관리한다면 Controller만으로 충분합니다.

## 📋 정리

| 상황 | Service 필요 여부 | 이유 |
|------|------------------|------|
| REST API 호출 | ✅ 필요 | API 로직 분리 및 재사용 |
| GraphQL API | ✅ 필요 | 쿼리/뮤테이션 관리 |
| 로컬 DB (SQLite, Hive) | ✅ 필요 | 저장 로직 추상화 |
| Firebase SDK | ❌ 불필요 | SDK 자체가 완성도 높음 |
| Supabase SDK | ❌ 불필요 | SDK 자체가 완성도 높음 |
| 간단한 UI 상태 | ❌ 불필요 | Controller만으로 충분 |

**핵심 원칙**: Service 레이어는 **실제로 필요할 때만** 추가하세요. 과도한 추상화는 오히려 코드를 복잡하게 만듭니다.

## Controller에서 Service 사용하기

```dart
// Service 정의
class GitHubService {
  Future<GithubRepoModel> getRepo({required String owner, required String repo}) async {
    // API 호출 로직
  }
}

// Controller에서 사용
class GitHubNotifier extends AsyncNotifier<GithubRepoModel> {
  final _service = GitHubService();

  @override
  Future<GithubRepoModel> build() => _service.getRepo(owner: 'foo', repo: 'bar');
}
```
