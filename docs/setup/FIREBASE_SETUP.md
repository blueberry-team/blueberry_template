# Firebase 설정 가이드

이 프로젝트는 Firebase Crashlytics를 사용하여 앱 크래시를 모니터링합니다.

## 🚀 빠른 시작 (권장)

Firebase를 사용하지 않아도 앱은 정상 동작합니다. 필요할 때 아래 단계를 따라 설정하세요.

### 1단계: FlutterFire CLI 설치

```bash
dart pub global activate flutterfire_cli
```

### 2단계: Firebase 프로젝트 설정

```bash
flutterfire configure
```

이 명령어를 실행하면:

1. Firebase 콘솔에 로그인
2. 프로젝트 선택 (또는 새로 생성)
3. 플랫폼 선택 (Android, iOS 등)
4. **자동으로 설정 파일 생성:**
   - `lib/firebase_options.dart` (기존 샘플 파일 덮어씀)
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

### 3단계: Crashlytics 활성화

1. [Firebase Console](https://console.firebase.google.com/) 접속
2. 프로젝트 선택 > 좌측 메뉴 > **Crashlytics**
3. "시작하기" 클릭
4. 앱을 한 번 실행하여 활성화 확인

### 4단계: 동작 확인

앱을 실행하여 Firebase 초기화가 정상적으로 되는지 확인합니다.

```bash
flutter run
```

---

## 🔧 디버깅: 설정 파일 수동으로 다운로드

`flutterfire configure`가 제대로 동작하지 않거나 설정 파일이 누락되었을 때 사용하세요.

### Android 설정 파일 다운로드

1. [Firebase Console](https://console.firebase.google.com/) 접속
2. 프로젝트 선택 > 프로젝트 설정(⚙️)
3. 내 앱 > Android 앱 선택
4. 패키지 이름 확인: `com.example.template` (또는 실제 패키지명)
5. **`google-services.json` 다운로드**
6. 파일을 `android/app/` 디렉토리에 복사

### iOS 설정 파일 다운로드

1. [Firebase Console](https://console.firebase.google.com/) 접속
2. 프로젝트 선택 > 프로젝트 설정(⚙️)
3. 내 앱 > iOS 앱 선택
4. Bundle ID 확인
5. **`GoogleService-Info.plist` 다운로드**
6. Xcode에서 `ios/Runner/` 디렉토리에 추가
   - Runner 프로젝트에서 우클릭 > Add Files to "Runner"
   - `GoogleService-Info.plist` 선택
   - "Copy items if needed" 체크

---

## 🧪 테스트

Crashlytics가 제대로 동작하는지 테스트:

```dart
// 테스트용 크래시 발생
ElevatedButton(
  onPressed: () => throw Exception('Test Crashlytics'),
  child: Text('Test Crash'),
)
```

또는:

```dart
FirebaseCrashlytics.instance.crash();
```

Firebase Console > Crashlytics에서 1-2분 후 크래시 로그를 확인할 수 있습니다.

---

## ⚠️ 주의사항

- `google-services.json` (Android)는 **gitignore에 추가됨** - 팀원과 별도 공유 필요
- `GoogleService-Info.plist` (iOS)는 **gitignore에 추가됨** - 팀원과 별도 공유 필요
- `lib/firebase_options.dart`는 Git에 포함되지만 샘플 파일이므로 `flutterfire configure` 실행 필요

---

## 🆘 트러블슈팅

### Firebase 관련 Warning/Error 로그가 계속 나옴

```
W/FirebaseSessions: Please set your Application ID
E/FirebaseCrashlytics: Settings request failed
```

→ `lib/firebase_options.dart`가 샘플 파일이거나 `YOUR_ANDROID_APP_ID` 같은 플레이스홀더가 남아있음
→ `flutterfire configure`를 실행하여 실제 Firebase 프로젝트 정보로 교체 필요
→ 앱은 정상 동작하지만 Crashlytics는 작동하지 않음

### "google-services.json not found" (Android)

→ 위의 "디버깅: 설정 파일 수동으로 다운로드" 섹션 참고

### "GoogleService-Info.plist not found" (iOS)

→ 위의 "디버깅: 설정 파일 수동으로 다운로드" 섹션 참고

### Crashlytics에 로그가 안 보임

→ 첫 실행 후 1-2분 대기 필요, 앱을 완전히 종료 후 재실행

---

## 📚 참고 문서

- [FlutterFire 공식 문서](https://firebase.flutter.dev/)
- [Firebase Crashlytics 문서](https://firebase.google.com/docs/crashlytics)
- [FlutterFire CLI 가이드](https://firebase.flutter.dev/docs/cli/)
