import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:palink_v2/core/theme/app_colors.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/presentation/screens/chatting/controller/chat_loading_viewmodel.dart';
import 'package:sizing/sizing.dart';


class ChatLoadingScreen extends StatelessWidget {
  final ChatLoadingViewModel viewModel;

  // 생성자에서 Character 인자를 받도록 수정
  const ChatLoadingScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.2.sh),
            _buildProfileImage(),
            Center(
              child: Text(
                viewModel.character.name,
                style: textTheme().titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
              child: _buildStyledDescription(viewModel.character.description!),
            ),
            const SpinKitThreeBounce(color: AppColors.deepBlue, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
      height: 150,
      child: Image.asset(viewModel.character.image),
    );
  }

  Widget _buildStyledDescription(String description) {
    List<String> lines = description.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            lines[0],
            style:
            textTheme().titleSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0), // 타이틀과 나머지 텍스트 간 간격
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
                        child: Icon(Icons.check_circle,
                            color: Colors.blue, size: 16),
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