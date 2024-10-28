import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_preferences.g.dart';

//It would be signle instance so we need to use @Riverpod(true)
@Riverpod(keepAlive: true)
UserPreferences userPreferences(UserPreferencesRef ref) {
  return UserPreferences();
}

class UserPreferences {
  late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) {
    if (token != null) {
      _preferences.setString('x-auth-token', token);
    }
  }

  String? getToken() {
    return _preferences.getString('x-auth-token');
  }
}
