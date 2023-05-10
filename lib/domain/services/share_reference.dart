import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class ShareReferenceService {
  String get darkModeName => "DARK_MODE";
  String get languageName => "LANGUAGE";

  static void saveDarkMode(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(ShareReferenceService().darkModeName, isDark);
  }

  static void saveLanguageMode(Locale lo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(ShareReferenceService().languageName, lo.toString());
  }

  static Future<bool?> getDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(ShareReferenceService().darkModeName);
  }

  static Future<String?> getLanguageMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(ShareReferenceService().languageName);
  }
}
