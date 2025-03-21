import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

/// 앱에서 사용하는 타이포그래피를 표시하는 화면
class TypographyScreen extends StatelessWidget {
  /// TypographyScreen 생성자
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('타이포그래피', style: AppTypography.titleLarge),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTypographySection(
                  'Display',
                  [
                    _buildTypographyItem('Display Large', AppTypography.displayLarge),
                    _buildTypographyItem('Display Medium', AppTypography.displayMedium),
                    _buildTypographyItem('Display Small', AppTypography.displaySmall),
                  ],
                ),
                const SizedBox(height: 24),
                _buildTypographySection(
                  'Headline',
                  [
                    _buildTypographyItem('Headline Large', AppTypography.headlineLarge),
                    _buildTypographyItem('Headline Medium', AppTypography.headlineMedium),
                    _buildTypographyItem('Headline Small', AppTypography.headlineSmall),
                  ],
                ),
                const SizedBox(height: 24),
                _buildTypographySection(
                  'Body',
                  [
                    _buildTypographyItem('Body Large', AppTypography.bodyLarge),
                    _buildTypographyItem('Body Medium', AppTypography.bodyMedium),
                    _buildTypographyItem('Body Small', AppTypography.bodySmall),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// 타이포그래피 섹션을 구성하는 위젯
  Widget _buildTypographySection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.titleLarge,
        ),
        const SizedBox(height: 16),
        ...items,
      ],
    );
  }

  /// 타이포그래피 아이템을 구성하는 위젯
  Widget _buildTypographyItem(String name, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: style,
          ),
          const SizedBox(height: 4),
          Text(
            '${style.fontSize}px / ${style.fontWeight}',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
} 