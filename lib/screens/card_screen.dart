import 'package:flutter/material.dart';
import '../design/cards/basic_card.dart';
import '../design/cards/basic_card_with_image.dart';
import '../design/cards/action_card.dart';
import '../design/cards/action_card_with_image.dart';
import '../design/cards/outlined_card.dart';
import '../design/cards/outlined_card_with_image.dart';
import '../design/cards/card_section.dart';

/// 다양한 카드 컴포넌트를 표시하는 화면
class CardScreen extends StatelessWidget {
  /// CardScreen 생성자
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카드')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const CardSection(
                  title: '기본 카드',
                  cards: [
                    BasicCard(
                      title: '기본 카드',
                      description: '이것은 기본적인 카드 컴포넌트입니다. 내용을 자유롭게 구성할 수 있습니다.',
                    ),
                    SizedBox(height: 16),
                    BasicCardWithImage(
                      title: '이미지가 있는 카드',
                      description: '이미지와 함께 내용을 표시할 수 있는 카드입니다.',
                      imageUrl: 'https://picsum.photos/400/200',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const CardSection(
                  title: '액션 카드',
                  cards: [
                    ActionCard(
                      title: '액션 카드',
                      description: '버튼이 포함된 카드입니다.',
                      onCancel: null,
                      onConfirm: null,
                    ),
                    SizedBox(height: 16),
                    ActionCardWithImage(
                      title: '이미지와 액션이 있는 카드',
                      description: '이미지와 버튼이 함께 있는 카드입니다.',
                      imageUrl: 'https://picsum.photos/400/200',
                      onCancel: null,
                      onConfirm: null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const CardSection(
                  title: '아웃라인 카드',
                  cards: [
                    OutlinedCard(
                      title: '아웃라인 카드',
                      description: '테두리가 있는 카드입니다.',
                    ),
                    SizedBox(height: 16),
                    OutlinedCardWithImage(
                      title: '이미지가 있는 아웃라인 카드',
                      description: '이미지와 테두리가 있는 카드입니다.',
                      imageUrl: 'https://picsum.photos/400/200',
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
