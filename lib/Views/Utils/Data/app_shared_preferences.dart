import 'package:shared_preferences/shared_preferences.dart';

import 'app_strings.dart';

class SharedPrefs {
  /// reference of Shared Preferences
  static SharedPreferences? _preferences;

  /// Initialization of Shared Preferences
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Set & Get init page methods
  static Future setInitPage({required String? initPage}) async =>
      await _preferences?.setString(AppStrings.initPage, initPage ?? '');
  static String? getInitPage() => _preferences!.getString(AppStrings.initPage);

  /// Set & Get power methods
  static Future<bool> setPower({required bool power}) async =>
      await _preferences!.setBool(AppStrings.power, power);
  static bool? getPower() => _preferences!.getBool(AppStrings.power);

  /// Set & Get theme methods
  static Future<bool> setTheme({required bool theme}) async =>
      await _preferences!.setBool(AppStrings.theme, theme);
  static bool? getTheme() => _preferences!.getBool(AppStrings.theme);

  /// Set & Get color methods
  static Future setColor({required int? color}) async =>
      await _preferences!.setInt(AppStrings.color, color!);
  static int? getColor() => _preferences!.getInt(AppStrings.color);

  /// Set & Get default color index
  static Future setDefaultColorIndex({required int? defaultColorIndex}) async =>
      await _preferences!
          .setInt(AppStrings.defaultColorIndex, defaultColorIndex!);
  static int? getDefaultColorIndex() =>
      _preferences!.getInt(AppStrings.defaultColorIndex);

  /// Set & Get favorite color index
  static Future setFavoriteColorIndex(
          {required int? favoriteColorIndex}) async =>
      await _preferences!
          .setInt(AppStrings.favoriteColorIndex, favoriteColorIndex!);
  static int? getFavoriteColorIndex() =>
      _preferences!.getInt(AppStrings.favoriteColorIndex);

  /// Set & Get operation button state
  static Future setOpacity({required int? opacity}) async =>
      await _preferences?.setInt(AppStrings.opacity, opacity!);
  static int? getOpacity() => _preferences!.getInt(AppStrings.opacity);

  static Future clearSharedPreferences() async => _preferences!.clear();
}
