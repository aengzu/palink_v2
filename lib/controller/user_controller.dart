import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserController extends GetxController {
  var userId = ''.obs;
  var name = ''.obs;
  var age = 0.obs;
  var personalityType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString("user_id") ?? "";
    name.value = prefs.getString("name") ?? "";
    age.value = prefs.getInt("age") ?? 0;
    personalityType.value = prefs.getString("personality_type") ?? "";
  }

  void setUser(User user) {
    userId.value = user.userId;
    name.value = user.name;
    age.value = user.age;
    personalityType.value = user.personalityType;
  }
}
