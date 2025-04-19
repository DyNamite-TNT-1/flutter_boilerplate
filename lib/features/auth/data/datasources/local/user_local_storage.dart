import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class UserLocalStorage {
  Future<String?> getToken();
  UserModel? getUser();
  Future<void> saveToken(String token);
  Future<void> saveUser(UserModel user);
  Future<void> clearCache();
}

class UserLocalStorageImpl implements UserLocalStorage {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPref;

  static final String _kUser = "_kUser";
  static final String _kToken = "_kToken";

  UserLocalStorageImpl({
    required SharedPreferences sharedPreferences,
    required FlutterSecureStorage secureStorage,
  }) : _sharedPref = sharedPreferences,
       _secureStorage = secureStorage;

  @override
  Future<String?> getToken() async {
    String? token = await _secureStorage.read(key: _kToken);
    return token;
  }

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _kToken, value: token);
  }

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
    await _secureStorage.deleteAll();
    await _sharedPref.remove(_kUser);
  }
}
