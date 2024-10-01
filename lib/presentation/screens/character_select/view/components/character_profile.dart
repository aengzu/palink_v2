import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:sizing/sizing.dart';

import '../../controller/character_select_viewmodel.dart';

class CharacterProfile extends StatelessWidget {
  final Character character;
  final CharacterSelectViewModel viewModel = Get.find();

  CharacterProfile({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.selectCharacter(character);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 6),
            _buildProfileName(),
            _buildProfileDescription(),
            _buildAskLevel(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(character.image),
    );
  }

  Widget _buildProfileName() {
    return Text(character.name, style: textTheme().titleSmall);
  }

  Widget _buildProfileDescription() {
    return Text(character.type, style: const TextStyle(fontSize: 17.0));
  }

  Widget _buildAskLevel() {
    return Text('레벨: ${character.requestStrength}',
        style:  const TextStyle(fontSize: 17.0));
  }
}
