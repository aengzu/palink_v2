import 'package:palink_v2/data/api/user/user_api.dart';
import 'package:palink_v2/data/models/user/user_collection_request.dart';
import 'package:palink_v2/data/models/user/user_collection_response.dart';
import 'package:palink_v2/data/models/user/user_response.dart';
import 'package:palink_v2/domain/model/user/user.dart';
import 'package:palink_v2/domain/repository/user_repository.dart';
import 'package:palink_v2/data/mapper/user_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final SharedPreferences prefs;
  final UserApi _userApi;

  UserRepositoryImpl(this.prefs, this._userApi);

  @override
  int? getUserId() {
    return prefs.getInt('userId');
  }

  @override
  Future<User?> getUser(int userId) async {
    try {
      UserResponse? response = await _userApi.getUserById(userId);
      return response?.toDomain();
    } catch (e) {
      print('Error in getUser: $e');
      return null;
    }
  }

  @override
  Future<UserCollectionResponse> createUserCollection(
      int userId, UserCollectionRequest userCollectionRequest) {
    return _userApi.addUserCollection(userId, userCollectionRequest);
  }
}
