/// GitHub 레포지토리 정보 모델
class GithubRepoModel {
  /// 기본 생성자
  const GithubRepoModel({
    required this.name,
    required this.fullName,
    required this.stargazersCount,
    this.description,
    required this.htmlUrl,
  });

  /// JSON에서 RepositoryModel 생성
  factory GithubRepoModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoModel(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      stargazersCount: json['stargazers_count'] as int,
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
    );
  }

  /// 레포지토리 이름
  final String name;

  /// 전체 이름 (owner/repo)
  final String fullName;

  /// 별(star) 개수
  final int stargazersCount;

  /// 레포지토리 설명
  final String? description;

  /// HTML URL
  final String htmlUrl;

  /// RepositoryModel을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'full_name': fullName,
      'stargazers_count': stargazersCount,
      'description': description,
      'html_url': htmlUrl,
    };
  }
}
