# 다국어화 (easy_localization)

## 번역 파일

### 파일 위치

- `assets/translations/ko.json` (한국어, 기본)
- `assets/translations/en.json` (영어)

### 번역 파일 예제

`assets/translations/ko.json`:

```json
{
  "app_title": "블루베리 TODO",
  "welcome": "환영합니다, {}님!",
  "items_count": "{} 개"
}
```

`assets/translations/en.json`:

```json
{
  "app_title": "Blueberry TODO",
  "welcome": "Welcome, {}!",
  "items_count": "{} items"
}
```

## 사용법

### 기본 사용

```dart
Text('app_title'.tr());
```

### 변수 포함

```dart
Text('welcome'.tr(args: ['홍길동']));
Text('items_count'.tr(args: ['5']));
```

### 복수형 (Plural)

```json
{
  "notifications": {
    "zero": "알림 없음",
    "one": "알림 1개",
    "other": "알림 {}개"
  }
}
```

```dart
Text('notifications'.plural(0));  // "알림 없음"
Text('notifications'.plural(1));  // "알림 1개"
Text('notifications'.plural(5));  // "알림 5개"
```

## 언어 변경

```dart
// 한국어로 변경
context.setLocale(Locale('ko'));

// 영어로 변경
context.setLocale(Locale('en'));

// 현재 언어 확인
final currentLocale = context.locale;
```

## 새 언어 추가

### 1. 번역 파일 생성

`assets/translations/ja.json` 파일 생성

```json
{
  "app_title": "ブルーベリー TODO",
  "welcome": "ようこそ、{}さん!"
}
```

### 2. main.dart 수정

```dart
EasyLocalization(
  supportedLocales: const [
    Locale('ko'),
    Locale('en'),
    Locale('ja'),  // 추가
  ],
  path: 'assets/translations',
  fallbackLocale: const Locale('ko'),
  child: const ProviderScope(child: MyApp()),
)
```

### 3. pubspec.yaml 확인

```yaml
flutter:
  assets:
    - assets/translations/
```

## 번역 키 네이밍 규칙

**권장 구조**: `feature.component.text`

```json
{
  "common": {
    "cancel": "취소",
    "confirm": "확인",
    "delete": "삭제"
  },
  "todo": {
    "add_button": "할 일 추가",
    "empty_message": "할 일이 없습니다"
  },
  "profile": {
    "edit_button": "프로필 수정",
    "save_button": "저장"
  }
}
```

사용:

```dart
Text('common.cancel'.tr());
Text('todo.add_button'.tr());
Text('profile.edit_button'.tr());
```

## 주의사항

❌ **하지 말 것:**

```dart
Text('추가하기');  // 하드코딩된 문자열
```

✅ **이렇게 하세요:**

```dart
Text('todo.add_button'.tr());
```
