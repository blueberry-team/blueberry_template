import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

/// 색상 시스템을 보여주는 화면
class ColorScreen extends StatelessWidget {
  /// ColorScreen 생성자
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('색상 시스템', style: AppTypography.titleLarge),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildColorSection(context, 'Primary Colors', [
                  _buildColorItem(context, 'Primary', colorScheme.primary),
                  _buildColorItem(
                    context,
                    'Primary Container',
                    colorScheme.primaryContainer,
                  ),
                  _buildColorItem(context, 'On Primary', colorScheme.onPrimary),
                  _buildColorItem(
                    context,
                    'On Primary Container',
                    colorScheme.onPrimaryContainer,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildColorSection(context, 'Secondary Colors', [
                  _buildColorItem(context, 'Secondary', colorScheme.secondary),
                  _buildColorItem(
                    context,
                    'Secondary Container',
                    colorScheme.secondaryContainer,
                  ),
                  _buildColorItem(
                    context,
                    'On Secondary',
                    colorScheme.onSecondary,
                  ),
                  _buildColorItem(
                    context,
                    'On Secondary Container',
                    colorScheme.onSecondaryContainer,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildColorSection(context, 'Surface Colors', [
                  _buildColorItem(context, 'Surface', colorScheme.surface),
                  _buildColorItem(
                    context,
                    'Surface Container',
                    colorScheme.surfaceContainerHighest,
                  ),
                  _buildColorItem(context, 'On Surface', colorScheme.onSurface),
                  _buildColorItem(
                    context,
                    'On Surface Variant',
                    colorScheme.onSurfaceVariant,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildColorSection(context, 'Background Colors', [
                  _buildColorItem(context, 'Background', colorScheme.surface),
                  _buildColorItem(
                    context,
                    'On Background',
                    colorScheme.onSurface,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildColorSection(context, 'Error Colors', [
                  _buildColorItem(context, 'Error', colorScheme.error),
                  _buildColorItem(
                    context,
                    'Error Container',
                    colorScheme.errorContainer,
                  ),
                  _buildColorItem(context, 'On Error', colorScheme.onError),
                  _buildColorItem(
                    context,
                    'On Error Container',
                    colorScheme.onErrorContainer,
                  ),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// 색상 섹션을 구성하는 위젯
  Widget _buildColorSection(
    BuildContext context,
    String title,
    List<Widget> colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleLarge),
        const SizedBox(height: 16),
        ...colors,
      ],
    );
  }

  /// 색상 아이템을 구성하는 위젯
  Widget _buildColorItem(BuildContext context, String name, Color color) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outline),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.bodyLarge),
                Text(name, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
