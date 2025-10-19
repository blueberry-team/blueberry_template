import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/widgets.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // 한국어 번역 로드
  final content = await File('assets/translations/ko.json').readAsString();
  final data = jsonDecode(content) as Map<String, dynamic>;

  Localization.load(
    const Locale('ko'),
    translations: Translations(data),
  );

  await testMain();
}
