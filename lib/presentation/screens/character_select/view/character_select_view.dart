import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/character_select/controller/character_select_viewmodel.dart';
import 'package:palink_v2/presentation/screens/character_select/view/components/character_list.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:sizing/sizing.dart';

class CharacterSelectView extends StatelessWidget {
  final CharacterSelectViewModel viewModel = Get.put(getIt<CharacterSelectViewModel>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('PALINK', style: textTheme().titleLarge),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('준비중입니다. \n다음 업데이트를 기대해주세요 ☺️'),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('닫기', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        bottom: appBarBottomLine(),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.1.sh),
            const Text('아래의 친구들 중에서 선택해주세요.', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 0.05.sh),
            Expanded(
              child: Obx(() {
                // characters가 RxList로 선언되어 있으므로 .value 접근 없이 직접 사용
                if (viewModel.characters.isEmpty) {
                  return const Center(child: Text('No characters available.'));
                }
                return CharacterList(characters: viewModel.characters);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
