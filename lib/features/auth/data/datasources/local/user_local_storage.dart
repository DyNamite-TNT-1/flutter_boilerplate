import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class UserLocalStorage {
  UserModel? getUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearCache();
}

class UserLocalStorageImpl implements UserLocalStorage {
  final SharedPreferences _sharedPref;

  static final String _kUser = "_kUser";

  UserLocalStorageImpl({required SharedPreferences sharedPreferences})
    : _sharedPref = sharedPreferences;

  @override
  UserModel? getUser() {
    final jsonString = _sharedPref.getString(_kUser);
    if (jsonString != null) {
      return UserModel.fromRawJson(jsonString);
    } else {
      return null;
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return _sharedPref.setString(_kUser, user.toRawJson());
  }

  @override
  Future<void> clearCache() async {
    await _sharedPref.remove(_kUser);
  }
}
