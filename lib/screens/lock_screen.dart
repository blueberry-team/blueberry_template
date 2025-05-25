import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '잠금 해제 PIN을 입력하세요',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Pinput(
                length: 4,
                obscureText: true,
                onCompleted: (value) {
                  // 입력값이 무엇이든 잠금 해제
                  ref.read(lockScreenProvider.notifier).state = false;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
