import '../models/user_model.dart';

abstract class UserLocalDataSource {
  /// Saves user data to local storage.
  Future<void> saveCreateUser(UserModel user);

  /// Loads the cached user without throwing.
  /// Returns null if no user is cached.
  Future<UserModel?> loadUser();
}
