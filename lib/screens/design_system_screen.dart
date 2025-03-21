import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'color_screen.dart';
import 'typography_screen.dart';
import 'card_screen.dart';
import 'button_screen.dart';
import 'dialog_screen.dart';
import 'calendar_screen.dart';
import 'graph_screen.dart';
import '../providers/theme_provider.dart';

/// 디자인 시스템의 모든 컴포넌트를 표시하는 메인 화면
class DesignSystemScreen extends ConsumerWidget {
  /// DesignSystemScreen 생성자
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('디자인 시스템'),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeModeNotifierProvider) == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              ref.read(themeModeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavigationCard(
            context,
            '색상 시스템',
            '앱에서 사용하는 모든 색상을 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ColorScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '타이포그래피',
            '앱에서 사용하는 모든 텍스트 스타일을 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TypographyScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '카드',
            '앱에서 사용하는 모든 카드 컴포넌트를 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CardScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '버튼',
            '앱에서 사용하는 모든 버튼 컴포넌트를 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ButtonScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '다이얼로그',
            '앱에서 사용하는 모든 다이얼로그 컴포넌트를 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DialogScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '캘린더',
            '앱에서 사용하는 모든 캘린더 컴포넌트를 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildNavigationCard(
            context,
            '그래프',
            '앱에서 사용하는 모든 그래프 컴포넌트를 확인합니다.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GraphScreen()),
            ),
          ),
        ],
      ),
    );
  }

  /// 네비게이션 카드 위젯을 생성합니다.
  ///
  /// [title] - 카드 제목
  /// [description] - 카드 설명
  /// [onTap] - 탭 이벤트 처리 콜백
  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
