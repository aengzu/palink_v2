import 'package:flutter/material.dart';
import 'package:palink_v2/domain/controllers/character_controller.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/utils/constants/app_fonts.dart';
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
            icon: Icon(Icons.settings),
            onPressed: () {},
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
