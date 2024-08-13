// data/mappers/user_mapper.dart
import 'package:palink_v2/domain/entities/user/user.dart';

import '../models/user/user_response.dart';

extension UserMapper on UserResponse {
  User toDomain() {
    return User(
      accountId: accountId,
      name: name,
      age: age,
      personalityType: personalityType,
      userId: userId,
    );
  }
}

