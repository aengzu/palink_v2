import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/models/character.dart';
import 'package:palink_v2/presentation/screens/chatting/view/chat_loading_screen.dart';
import 'package:sizing/sizing.dart';

class CharacterProfile extends StatelessWidget {
  final Character character;

  const CharacterProfile({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatLoadingScreen(character: character));
      },
      child: Column(
        children: [
          _buildProfileImage(),
          SizedBox(height: 0.01.sh),
          _buildProfileName(),
          _buildProfileDescription(),
          _buildAskLevel(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 100,
      height: 100,
      child: Image.asset(character.image),
    );
  }

  Widget _buildProfileName() {
    return Text(character.name, style: textTheme().titleSmall);
  }

  Widget _buildProfileDescription() {
    return Text(character.type, style: textTheme().bodyMedium);
  }

  Widget _buildAskLevel() {
    return Text('레벨: ${character.requestStrength}',
        style: textTheme().bodyMedium);
  }
}
