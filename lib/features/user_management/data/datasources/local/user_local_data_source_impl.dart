import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/user_model.dart';
import '../user_local_data_source.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _userKey = 'user_key';
  final SharedPreferences _preferences;

  UserLocalDataSourceImpl(this._preferences);

  @override
  Future<UserModel> loadUser() async {
    final String? jsonString = _preferences.getString(_userKey);
    if (jsonString == null) {
      throw StorageException(message: 'No user found');
    }

    return UserModel.fromJson(json.decode(jsonString));
  }

  @override
  Future<void> saveCreateUser(UserModel user) async {
    final success = await _preferences.setString(
      _userKey,
      json.encode(user.toJson()),
    );

    if (!success) {
      throw StorageException(message: 'Failed to save user');
    }
  }
}
