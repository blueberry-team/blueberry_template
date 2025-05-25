import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 잠금 화면 프로바이더
final lockScreenProvider = StateProvider<bool>((ref) => false);
