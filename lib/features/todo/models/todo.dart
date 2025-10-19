/// 간단한 할일 항목 모델
class Todo {
  /// 할일 생성자
  const Todo(this.title, {this.isDone = false});

  /// 할일 제목
  final String title;

  /// 완료 여부
  final bool isDone;

  /// 완료 상태를 토글한 새로운 할일 반환
  Todo toggle() => Todo(title, isDone: !isDone);
}
