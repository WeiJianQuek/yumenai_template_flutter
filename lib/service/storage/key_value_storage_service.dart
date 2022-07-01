import 'package:shared_preferences/shared_preferences.dart';

const _accessTokenKey = 'access_token';
const _notificationTokenKey = 'notification_token';

class KeyValueStorageService {
  static Future<KeyValueStorageService> setup() async {
    return KeyValueStorageService._(
      await SharedPreferences.getInstance(),
    );
  }

  final SharedPreferences _sharedPreferences;

  const KeyValueStorageService._(this._sharedPreferences);

  String get accessToken {
    return _sharedPreferences.getString(_accessTokenKey) ?? '';
  }

  String get notificationToken {
    return _sharedPreferences.getString(_notificationTokenKey) ?? '';
  }

  Future<bool> setAccessToken(final String? value) {
    return _sharedPreferences.setString(_accessTokenKey, value ?? '');
  }

  Future<bool> setNotificationToken(final String? value) {
    return _sharedPreferences.setString(_notificationTokenKey, value ?? '');
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
