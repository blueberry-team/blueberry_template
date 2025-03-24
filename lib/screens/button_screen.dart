import 'package:flutter/material.dart';
import '../design/buttons/button_section.dart';
import '../design/buttons/button_row.dart';
import '../design/buttons/filled_btn.dart';
import '../design/buttons/filled_icon_btn.dart';
import '../design/buttons/filled_tonal_btn.dart';
import '../design/buttons/filled_tonal_icon_btn.dart';
import '../design/buttons/outlined_btn.dart';
import '../design/buttons/outlined_icon_btn.dart';
import '../design/buttons/text_btn.dart';
import '../design/buttons/text_icon_btn.dart';
import '../design/buttons/sized_btn.dart';

/// 다양한 버튼 컴포넌트를 표시하는 화면
class ButtonScreen extends StatelessWidget {
  /// ButtonScreen 생성자
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('버튼')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ButtonSection(
                  title: '기본 버튼',
                  buttons: [
                    ButtonRow(
                      buttons: [
                        FilledBtn(
                          text: 'Filled',
                          onPressed: () {},
                        ),
                        FilledIconBtn(
                          text: 'Filled Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                        FilledTonalBtn(
                          text: 'Filled Tonal',
                          onPressed: () {},
                        ),
                        FilledTonalIconBtn(
                          text: 'Filled Tonal Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ButtonRow(
                      buttons: [
                        OutlinedBtn(
                          text: 'Outlined',
                          onPressed: () {},
                        ),
                        OutlinedIconBtn(
                          text: 'Outlined Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ButtonRow(
                      buttons: [
                        TextBtn(
                          text: 'Text',
                          onPressed: () {},
                        ),
                        TextIconBtn(
                          text: 'Text Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ButtonSection(
                  title: '상태별 버튼',
                  buttons: [
                    ButtonRow(
                      buttons: [
                        FilledBtn(
                          text: 'Enabled',
                          onPressed: () {},
                        ),
                        const FilledBtn(
                          text: 'Disabled',
                          onPressed: null,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ButtonSection(
                  title: '크기별 버튼',
                  buttons: [
                    ButtonRow(
                      buttons: [
                        SizedBtn(
                          text: 'Large',
                          size: 'large',
                          onPressed: () {},
                        ),
                        SizedBtn(
                          text: 'Medium',
                          size: 'medium',
                          onPressed: () {},
                        ),
                        SizedBtn(
                          text: 'Small',
                          size: 'small',
                          onPressed: () {},
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
}
