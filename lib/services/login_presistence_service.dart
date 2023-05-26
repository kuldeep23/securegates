import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLoginPresistenceService {
  Future<void> setLoginStatus(bool value);
  Future<bool> getLoginStatus();
}

final loginPresistenceServiceProvider =
    Provider<LoginPresistenceService>((ref) {
  return LoginPresistenceService();
});

class LoginPresistenceService implements BaseLoginPresistenceService {
  static const PREF_KEY = "loginStatusOnDisk";

  @override
  Future<bool> getLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }

  @override
  Future<void> setLoginStatus(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }
}
