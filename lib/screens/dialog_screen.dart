import 'package:flutter/material.dart';
import '../design/dialogs/basic_dialog.dart';
import '../design/dialogs/icon_dialog.dart';
import '../design/dialogs/alert_dialog.dart';
import '../design/dialogs/single_choice_dialog.dart';
import '../design/dialogs/multi_choice_dialog.dart';
import '../design/dialogs/dialog_section.dart';
import '../design/dialogs/dialog_button.dart';

/// 다양한 다이얼로그 컴포넌트를 표시하는 화면
class DialogScreen extends StatelessWidget {
  /// DialogScreen 생성자
  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('다이얼로그'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DialogSection(
                  title: '기본 다이얼로그',
                  buttons: [
                    DialogButton(
                      title: '기본 다이얼로그',
                      onPressed: () => _showBasicDialog(context),
                    ),
                    DialogButton(
                      title: '아이콘이 있는 다이얼로그',
                      onPressed: () => _showIconDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DialogSection(
                  title: '알림 다이얼로그',
                  buttons: [
                    DialogButton(
                      title: '성공 다이얼로그',
                      onPressed: () => _showSuccessDialog(context),
                    ),
                    DialogButton(
                      title: '경고 다이얼로그',
                      onPressed: () => _showWarningDialog(context),
                    ),
                    DialogButton(
                      title: '에러 다이얼로그',
                      onPressed: () => _showErrorDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DialogSection(
                  title: '선택 다이얼로그',
                  buttons: [
                    DialogButton(
                      title: '단일 선택 다이얼로그',
                      onPressed: () => _showSingleChoiceDialog(context),
                    ),
                    DialogButton(
                      title: '다중 선택 다이얼로그',
                      onPressed: () => _showMultiChoiceDialog(context),
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

  /// 기본 다이얼로그를 표시합니다.
  Future<void> _showBasicDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const BasicDialog(
        title: '기본 다이얼로그',
        content: '이것은 기본적인 다이얼로그입니다.',
      ),
    );
  }

  /// 아이콘이 있는 다이얼로그를 표시합니다.
  Future<void> _showIconDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const IconDialog(
        title: '아이콘 다이얼로그',
        content: '아이콘이 포함된 다이얼로그입니다.',
        icon: Icons.info_outline,
      ),
    );
  }

  /// 성공 알림 다이얼로그를 표시합니다.
  Future<void> _showSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        title: '성공',
        content: '작업이 성공적으로 완료되었습니다.',
        icon: Icons.check_circle_outline,
      ),
    );
  }

  /// 경고 알림 다이얼로그를 표시합니다.
  Future<void> _showWarningDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => IconDialog(
        title: '경고',
        content: '이 작업을 수행하시겠습니까?',
        icon: Icons.warning_amber_outlined,
        iconColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  /// 오류 알림 다이얼로그를 표시합니다.
  Future<void> _showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: '오류',
        content: '작업 중 오류가 발생했습니다.',
        icon: Icons.error_outline,
        iconColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  /// 단일 선택 다이얼로그를 표시합니다.
  Future<void> _showSingleChoiceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SingleChoiceDialog(
        title: '단일 선택',
        options: const ['옵션 1', '옵션 2', '옵션 3'],
        onConfirm: (value) {
          debugPrint('선택된 값: $value');
        },
      ),
    );
  }

  /// 다중 선택 다이얼로그를 표시합니다.
  Future<void> _showMultiChoiceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => MultiChoiceDialog(
        title: '다중 선택',
        options: const ['옵션 1', '옵션 2', '옵션 3'],
        onConfirm: (values) {
          debugPrint('선택된 값들: $values');
        },
      ),
    );
  }
} 