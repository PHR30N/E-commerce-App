
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();
  static final LocalStorageService instance = LocalStorageService._();

  static const _kFirstLaunch = 'is_first_launch';
  static const _kUserName = 'user_name';
  static const _kDeliveryAddress = 'delivery_address';
  static const _kNotificationsEnabled = 'notifications_enabled';
  static const _kDarkModeEnabled = 'dark_mode_enabled';
  static const _kLanguage = 'language';
  static const _kCachedCategories = 'cached_categories';

  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  // ---- First launch / onboarding flag ----
  Future<bool> isFirstLaunch() async {
    final prefs = await _prefs;
    return prefs.getBool(_kFirstLaunch) ?? true;
  }

  Future<void> setFirstLaunchComplete() async {
    final prefs = await _prefs;
    await prefs.setBool(_kFirstLaunch, false);
  }

  // ---- Profile / address ----
  Future<String?> getUserName() async => (await _prefs).getString(_kUserName);

  Future<void> setUserName(String name) async {
    await (await _prefs).setString(_kUserName, name);
  }

  Future<String?> getDeliveryAddress() async =>
      (await _prefs).getString(_kDeliveryAddress);

  Future<void> setDeliveryAddress(String address) async {
    await (await _prefs).setString(_kDeliveryAddress, address);
  }

  // ---- Settings screen preferences ----
  Future<bool> getNotificationsEnabled() async =>
      (await _prefs).getBool(_kNotificationsEnabled) ?? true;

  Future<void> setNotificationsEnabled(bool value) async {
    await (await _prefs).setBool(_kNotificationsEnabled, value);
  }

  Future<bool> getDarkModeEnabled() async =>
      (await _prefs).getBool(_kDarkModeEnabled) ?? false;

  Future<void> setDarkModeEnabled(bool value) async {
    await (await _prefs).setBool(_kDarkModeEnabled, value);
  }

  Future<String> getLanguage() async =>
      (await _prefs).getString(_kLanguage) ?? 'English';

  Future<void> setLanguage(String value) async {
    await (await _prefs).setString(_kLanguage, value);
  }

  // ---- Simple cache for the categories API response ----
  Future<void> cacheCategories(List<String> rawCategories) async {
    await (await _prefs).setStringList(_kCachedCategories, rawCategories);
  }

  Future<List<String>?> getCachedCategories() async =>
      (await _prefs).getStringList(_kCachedCategories);

  // ---- Utility ----
  Future<void> clearAll() async {
    await (await _prefs).clear();
  }
}
