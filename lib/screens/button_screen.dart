import 'package:flutter/material.dart';

/// 다양한 버튼 컴포넌트를 표시하는 화면
class ButtonScreen extends StatelessWidget {
  /// ButtonScreen 생성자
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('버튼'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildButtonSection(
                  context,
                  '기본 버튼',
                  [
                    _buildButtonRow(
                      context,
                      [
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Filled'),
                        ),
                        FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Filled Icon'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {},
                          child: const Text('Filled Tonal'),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Filled Tonal Icon'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildButtonRow(
                      context,
                      [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Outlined'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Outlined Icon'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildButtonRow(
                      context,
                      [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Text'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Text Icon'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildButtonSection(
                  context,
                  '상태별 버튼',
                  [
                    _buildButtonRow(
                      context,
                      [
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Enabled'),
                        ),
                        const FilledButton(
                          onPressed: null,
                          child: Text('Disabled'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildButtonSection(
                  context,
                  '크기별 버튼',
                  [
                    _buildButtonRow(
                      context,
                      [
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('Large'),
                        ),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Medium'),
                        ),
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: const Text('Small'),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// 버튼 섹션을 구성하는 위젯
  /// 
  /// [title] - 섹션 제목
  /// [buttons] - 버튼 위젯 목록
  Widget _buildButtonSection(BuildContext context, String title, List<Widget> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...buttons,
      ],
    );
  }

  /// 버튼 행을 구성하는 위젯
  /// 
  /// [buttons] - 가로로 나열할 버튼 위젯 목록
  Widget _buildButtonRow(BuildContext context, List<Widget> buttons) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: buttons,
    );
  }
} 