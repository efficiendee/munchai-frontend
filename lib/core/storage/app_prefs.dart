import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const _kLoggedIn = 'logged_in';
  static const _kOnboardingDone = 'onboarding_done';
  static const _kTasteProfile = 'taste_profile';

  static Future<bool> isLoggedIn() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kLoggedIn) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kLoggedIn, value);
  }

  static Future<bool> isOnboardingDone() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kOnboardingDone) ?? false;
  }

  static Future<void> setOnboardingDone(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kOnboardingDone, value);
  }

  static Future<void> setTasteProfile(String value) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kTasteProfile, value);
  }

  static Future<String> getTasteProfile() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_kTasteProfile) ?? '';
  }
}
