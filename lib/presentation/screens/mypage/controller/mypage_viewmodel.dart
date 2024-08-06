
import 'package:get/get.dart';
import 'package:palink_v2/domain/usecase/get_user_usecase.dart';

class MypageViewModel extends GetxController {
  final GetUserUseCase getUserUseCase;

  var userId = ''.obs;
  var name = ''.obs;
  var age = 0.obs;
  var personalityType = ''.obs;

  MypageViewModel({required this.getUserUseCase});

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    print('MypageViewmodel onInit');
  }

  void loadUserData() async {
    userId.value = await getUserUseCase.getUserId();
    name.value = await getUserUseCase.getName();
    age.value = await getUserUseCase.getAge();
    personalityType.value = await getUserUseCase.getPersonalityType();
  }

}