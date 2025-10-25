import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:template/features/github/models/github_repo_model.dart';

/// GitHub API 레포지토리
class GitHubRepository {
  static const _baseUrl = 'https://api.github.com';

  /// 특정 레포지토리 정보 조회
  ///
  /// [owner]: 레포지토리 소유자
  /// [repo]: 레포지토리 이름
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
