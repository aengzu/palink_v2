import 'package:palink_v2/data/models/user/user_collection_request.dart';
import 'package:palink_v2/data/models/user/user_collection_response.dart';

import '../model/user/user.dart';

abstract class UserRepository {
  int? getUserId();

  Future<User?> getUser(int userId);

  Future<UserCollectionResponse> createUserCollection(
      int userId, UserCollectionRequest userCollectionRequest);
}
