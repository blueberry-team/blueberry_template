import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:template/features/todo/models/todo.dart';

/// 할일 리스트 상태 관리
final todoControllerProvider = NotifierProvider<TodoController, List<Todo>>(
  TodoController.new,
);

/// 할일 리스트 컨트롤러
class TodoController extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [
      const Todo('디자인 시스템 구축', isDone: true),
      const Todo('할일 앱 만들기'),
      const Todo('배포 준비하기'),
    ];
  }

  /// 할일 추가
  void addTodo(String title) {
    final newTodos = List<Todo>.from(state);
    newTodos.add(Todo(title));
    state = newTodos;
  }

  /// 할일 완료 토글
  void toggleTodo(int index) {
    final updated = List<Todo>.from(state);
    updated[index] = updated[index].toggle();
    state = updated;
  }
}
