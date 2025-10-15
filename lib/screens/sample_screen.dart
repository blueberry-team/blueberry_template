import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:template/controllers/theme_provider.dart';
import 'package:template/themes/app_typography.dart';
import 'package:template/themes/app_colors.dart';

/// 블루베리 템플릿 샘플 홈 스크린
class SampleScreen extends ConsumerWidget {
  /// SampleScreen 생성자
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueberry Template'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeModeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 타이포그래피 섹션
            const Text('Typography', style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            const Text('Display Large', style: AppTypography.displayLarge),
            const Text('Display Medium', style: AppTypography.displayMedium),
            const Text('Display Small', style: AppTypography.displaySmall),
            const SizedBox(height: 8),
            const Text('Headline Large', style: AppTypography.headlineLarge),
            const Text('Headline Medium', style: AppTypography.headlineMedium),
            const Text('Headline Small', style: AppTypography.headlineSmall),
            const SizedBox(height: 8),
            const Text('Title Large', style: AppTypography.titleLarge),
            const Text('Title Medium', style: AppTypography.titleMedium),
            const Text('Title Small', style: AppTypography.titleSmall),
            const SizedBox(height: 8),
            const Text('Body Large', style: AppTypography.bodyLarge),
            const Text('Body Medium', style: AppTypography.bodyMedium),
            const Text('Body Small', style: AppTypography.bodySmall),
            const SizedBox(height: 8),
            const Text('Label Large', style: AppTypography.labelLarge),
            const Text('Label Medium', style: AppTypography.labelMedium),
            const Text('Label Small', style: AppTypography.labelSmall),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // 색상 팔레트 섹션
            const Text('Color Palette', style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final colors = context.colors;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildColorChip('Surface', colors.surface),
                    _buildColorChip('Primary', colors.primary),
                    _buildColorChip('Secondary', colors.secondary),
                    _buildColorChip('Error', colors.error),
                    _buildColorChip('Success', colors.success),
                    _buildColorChip('Warning', colors.warning),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // AppColors 사용 예시
            const Text('AppColors 사용법',
                style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final colors = context.colors;
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.textSecondary),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'context.colors로 접근 가능',
                        style: AppTypography.titleMedium.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCustomColorRow('surface', colors.surface),
                      _buildCustomColorRow('textPrimary', colors.textPrimary),
                      _buildCustomColorRow(
                          'textSecondary', colors.textSecondary),
                      _buildCustomColorRow('primary', colors.primary),
                      _buildCustomColorRow('secondary', colors.secondary),
                      _buildCustomColorRow('error', colors.error),
                      _buildCustomColorRow('success', colors.success),
                      _buildCustomColorRow('warning', colors.warning),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // 버튼 예시
            const Text('Buttons', style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomColorRow(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: AppTypography.bodySmall.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: AppTypography.labelSmall.copyWith(
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
