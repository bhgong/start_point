import 'package:shared_preferences/shared_preferences.dart';

// 이 클래스는 간단하게 데이터 저장 및 불러오기를 할 수 있는 기능만 한다.
class AppDarkModeRepository {
  static const String _darkMode = "darkMode";

  final SharedPreferences _preferences;

  AppDarkModeRepository(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  bool isDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
