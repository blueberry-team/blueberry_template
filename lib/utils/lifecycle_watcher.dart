import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lock_screen_provider.dart';

/// 앱 라이프사이클 관찰자
class LifecycleWatcher extends ConsumerStatefulWidget {
  /// 자식 위젯
  final Widget child;

  /// 앱 라이프사이클 관찰자 생성자
  const LifecycleWatcher({super.key, required this.child});

  @override
  ConsumerState<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends ConsumerState<LifecycleWatcher>
    with WidgetsBindingObserver {
  AppLifecycleState? _previousState;
  AppLifecycleState? _currentState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _previousState = _currentState;
    _currentState = state;

    debugPrint('이전 상태: $_previousState, 현재 상태: $_currentState');

    // paused -> resumed 전환 시 잠금화면 표시
    if (_previousState == AppLifecycleState.hidden &&
        _currentState == AppLifecycleState.inactive) {
      ref.read(lockScreenProvider.notifier).state = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
