import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/controllers/character_controller.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:sizing/sizing.dart';
import 'components/character_list.dart';

class CharacterSelectView extends StatelessWidget {
  CharacterController characterController = CharacterController();

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
            Text('아래의 친구들 중에서 선택해주세요.', style: textTheme().titleMedium),
            SizedBox(height: 0.05.sh),
            Expanded(
              child: CharacterList(characters: characterController.characters),
            ),
          ],
        ),
      ),
    );
  }
}
