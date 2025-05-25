import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/utils/lifecycle_watcher.dart';
import 'screens/design_system_screen.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'screens/lock_screen.dart';
import 'providers/lock_screen_provider.dart';

/// 앱 시작점
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: LifecycleWatcher(child: MyApp())));
}

/// 앱의 루트 위젯
class MyApp extends ConsumerWidget {
  /// MyApp 생성자
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final showLockScreen = ref.watch(lockScreenProvider);

    return MaterialApp(
      title: '디자인 시스템',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const DesignSystemScreen(),
      builder: (context, child) {
        if (showLockScreen) {
          return const LockScreen();
        }
        return child!;
      },
    );
  }
}
