import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const token = 'token';
}

class StorageDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getToken() => _secureStorage.read(key: _Keys.token);

  Future<void> setToken(String? token) {
    if (token != null) {
      return _secureStorage.write(key: _Keys.token, value: token);
    }
    return _secureStorage.delete(key: _Keys.token);
  }

  // Future<User?> getUser() async {
  //   String? json = await _secureStorage.read(key: _Keys.user);
  //   if (json == null) return null;
  //   return User.fromJson(jsonDecode(json));
  // }

  // Future<void> setUser(User? user) {
  //   if (user != null) {
  //     return _secureStorage.write(key: _Keys.user, value: jsonEncode(user));
  //   }
  //   return _secureStorage.delete(key: _Keys.user);
  // }
}
