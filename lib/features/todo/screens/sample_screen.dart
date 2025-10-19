import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/core/controllers/theme_controller.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/core/themes/app_typography.dart';
import 'package:template/features/github/controllers/github_controller.dart';
import 'package:template/features/todo/controllers/todo_controller.dart';

/// 블루베리 템플릿 샘플 스크린
class SampleScreen extends ConsumerWidget {
  /// 생성자
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeControllerProvider) == ThemeMode.dark;
    final todos = ref.watch(todoControllerProvider);
    final githubRepositoryAsync = ref.watch(githubProvider);
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: githubRepositoryAsync.hasValue
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(githubRepositoryAsync.value!.name),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${githubRepositoryAsync.value!.stargazersCount}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              )
            : Text('app_title'.tr()),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () =>
                ref.read(themeControllerProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) {
                  ref.read(todoControllerProvider.notifier).toggleTodo(index);
                },
              ),
              title: Text(
                todo.title,
                style: AppTypography.body.copyWith(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  color: todo.isDone
                      ? colors.textSecondary
                      : colors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('new_todo'.tr()),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'hint_enter_todo'.tr()),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(todoControllerProvider.notifier)
                    .addTodo(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: Text('add'.tr()),
          ),
        ],
      ),
    );
  }
}
