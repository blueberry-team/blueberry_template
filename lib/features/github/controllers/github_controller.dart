import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/features/github/models/github_repo_model.dart';
import 'package:template/features/github/repositories/github_repository.dart';

/// GitHub 레포지토리 정보를 관리하는 Provider
final githubProvider = AsyncNotifierProvider<GitHubNotifier, GithubRepoModel>(
  GitHubNotifier.new,
);

/// GitHub 레포지토리 상태 관리
class GitHubNotifier extends AsyncNotifier<GithubRepoModel> {
  final _repository = GitHubRepository();

  @override
  Future<GithubRepoModel> build() {
    return _repository.getRepo(
      owner: 'blueberry-team',
      repo: 'blueberry_template',
    );
  }

  /// 레포지토리 정보 새로고침
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
