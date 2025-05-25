import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lock_screen_provider.dart';

/// 잠금 화면
class LockScreen extends ConsumerWidget {
  /// 잠금 화면 생성자
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(lockScreenProvider.notifier).state = false;
          },
          child: const Text('잠금 해제'),
        ),
      ),
    );
  }
}
