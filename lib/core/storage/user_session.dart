import 'package:shared_preferences/shared_preferences.dart';

/// 📱 کلاس مدیریت اطلاعات کاربر (وابسته به SharedPreferences از locator)
class UserSession {
  final SharedPreferences _prefs;

  UserSession(this._prefs);

  static const String _kFullName = 'full_name';
  static const String _kMobile = 'mobile';
  static const String _kToken = 'token';
  static const String _kIsProfile = 'is_profile';


  /// 🔹 ذخیره نام کاربر
  Future<void> setFullName(String fullName) async {
    await _prefs.setString(_kFullName, fullName);
  }

  /// 🔹 دریافت نام کاربر
  String? getFullName() => _prefs.getString(_kFullName);

  /// 🔹 ذخیره شماره موبایل
  Future<void> setMobile(String mobile) async {
    await _prefs.setString(_kMobile, mobile);
  }

  /// 🔹 دریافت شماره موبایل
  String? getMobile() => _prefs.getString(_kMobile);

  /// 🔹 ذخیره توکن
  Future<void> setToken(String token) async {
    await _prefs.setString(_kToken, token);
  }

  /// 🔹 ذخیره وضعیت تکمیل بودن پروفایل
  Future<void> setIsProfile(bool isProfile) async {
    await _prefs.setBool(_kIsProfile, isProfile);
  }

  /// 🔹 دریافت وضعیت پروفایل

  bool isProfileCompleted() {
    return _prefs.getBool(_kIsProfile) ?? false;
  }


  /// 🔹 دریافت توکن
  String? getToken() => _prefs.getString(_kToken);


  /// 🧹 حذف همه اطلاعات
  Future<void> clearAll() async {
    await _prefs.remove(_kFullName);
    await _prefs.remove(_kMobile);
    await _prefs.remove(_kToken);
    await _prefs.remove(_kIsProfile);
  }

  /// 🔐 بررسی وضعیت ورود
  bool isLoggedIn() {
    final token = _prefs.getString(_kToken);
    return token != null && token.isNotEmpty;
  }
}
