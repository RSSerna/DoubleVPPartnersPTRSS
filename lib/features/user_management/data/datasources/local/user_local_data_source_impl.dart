import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/user_model.dart';
import '../user_local_data_source.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _userKey = 'user_key';
  final SharedPreferences _preferences;

  UserLocalDataSourceImpl(this._preferences);

  @override
  Future<UserModel> loadUser() async {
    try {
      final String? jsonString = _preferences.getString(_userKey);
      if (jsonString == null) {
        throw StorageException(
          message: AppStrings.userNotCreatedError,
          data: {'key': _userKey},
        );
      }

      return UserModel.fromJson(json.decode(jsonString));
    } catch (e, stackTrace) {
      if (e is StorageException) rethrow;
      throw StorageException(
        message: AppStrings.loadError,
        data: {'error': e.toString(), 'stackTrace': stackTrace.toString()},
      );
    }
  }

  @override
  Future<void> saveCreateUser(UserModel user) async {
    try {
      final success = await _preferences.setString(
        _userKey,
        json.encode(user.toJson()),
      );

      if (!success) {
        throw StorageException(
          message: AppStrings.saveError,
          data: {'userId': user.id, 'key': _userKey},
        );
      }
    } catch (e, stackTrace) {
      if (e is StorageException) rethrow;
      throw StorageException(
        message: AppStrings.storageError,
        data: {
          'error': e.toString(),
          'userId': user.id,
          'stackTrace': stackTrace.toString(),
        },
      );
    }
  }
}
