import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/models/character.dart';
import 'package:sizing/sizing.dart';

import '../../constants/app_fonts.dart';
import '../../controller/character_loading_controller.dart';

class CharacterLoadingView extends StatelessWidget {
  final Character character;

  CharacterLoadingView({Key? key})
      : character = Get.arguments as Character,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // CharacterLoadingController를 초기화합니다.
    Get.put(CharacterLoadingController(character));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.2.sh),
          _buildProfileImage(),
          Center(
            child: Text(
              character.name,
              style: textTheme().titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
            child: _buildStyledDescription(character.description),
          ),
          CircularProgressIndicator(color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: EdgeInsets.all(10),
      width: 150,
      height: 150,
      child: Image.asset(character.image),
    );
  }

  Widget _buildStyledDescription(String description) {
    // Split description by new lines
    List<String> lines = description.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            lines[0],
            style: textTheme().titleSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8.0), // 타이틀과 나머지 텍스트 간 간격
        RichText(
          text: TextSpan(
            style: textTheme().bodyMedium?.copyWith(height: 1.5), // 줄 간격 추가
            children: [
              // 나머지 줄은 체크 아이콘과 함께 표시
              for (var line in lines.skip(1))
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.only(right: 4.0, bottom: 2.0),
                        child: Icon(Icons.check_circle, color: Colors.blue, size: 16),
                      ),
                    ),
                    TextSpan(text: line + '\n'),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
