import 'package:flutter/material.dart';
import '../design/buttons/button_section.dart';
import '../design/buttons/button_row.dart';
import '../design/buttons/filled_btn.dart';
import '../design/buttons/filled_icon_btn.dart';
import '../design/buttons/outlined_btn.dart';
import '../design/buttons/outlined_icon_btn.dart';
import '../design/buttons/text_btn.dart';
import '../design/buttons/text_icon_btn.dart';
import '../design/buttons/like_btn.dart';
import '../design/buttons/comment_btn.dart';

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
                        TextBtn(text: 'Text', onPressed: () {}),
                        TextIconBtn(
                          text: 'Text Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ButtonRow(
                      buttons: [
                        FilledBtn(text: 'Filled', onPressed: () {}),
                        FilledIconBtn(
                          text: 'Filled Icon',
                          icon: Icons.add,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ButtonRow(
                      buttons: [
                        OutlinedBtn(text: 'Outlined', onPressed: () {}),
                        OutlinedIconBtn(
                          text: 'Outlined Icon',
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
                        FilledBtn(text: 'Enabled', onPressed: () {}),
                        const FilledBtn(text: 'Disabled', onPressed: null),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ButtonSection(
                  title: '소셜 버튼',
                  buttons: [
                    ButtonRow(
                      buttons: [
                        LikeBtn(
                          likeCount: 42,
                          isLiked: false,
                          onPressed: () {},
                        ),
                        LikeBtn(
                          likeCount: 128,
                          isLiked: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ButtonRow(
                      buttons: [
                        CommentBtn(commentCount: 12, onPressed: () {}),
                        CommentBtn(commentCount: 32, onPressed: () {}),
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
