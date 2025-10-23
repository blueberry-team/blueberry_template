import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:template/firebase_options.dart';

/// 앱 초기화 및 외부 서비스 설정
///
/// Firebase, Analytics 등 앱에서 사용하는 외부 서비스를 초기화합니다.
///
/// ## Firebase 설정
/// 템플릿 모드에서는 Firebase를 초기화하지 않습니다.
/// 실제 프로젝트에서 사용하려면:
/// 1. `flutterfire configure` 명령어 실행
/// 2. [enableFirebase] 상수를 true로 변경
class AppSetup {
  /// Firebase 활성화 여부
  static const enableFirebase = false;

  /// 앱 초기화
  static Future<void> initialize() async {
    await _initializeFirebase();
  }

  /// Firebase 초기화
  static Future<void> _initializeFirebase() async {
    if (!enableFirebase) {
      if (kDebugMode) {
        print('Firebase가 비활성화되어 있습니다 (템플릿 모드)');
      }
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Crashlytics 설정
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      // 비동기 에러 처리
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      if (kDebugMode) {
        print('Firebase 초기화 완료');
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('Firebase 초기화 실패: $e');
        print('Stack trace: $stack');
      }
      rethrow;
    }
  }

  /// Zone 에러 핸들러
  ///
  /// runZonedGuarded의 onError 콜백으로 사용
  static void handleZoneError(Object error, StackTrace stack) {
    if (enableFirebase) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else if (kDebugMode) {
      print('Uncaught error: $error');
      print('Stack trace: $stack');
    }
  }
}
