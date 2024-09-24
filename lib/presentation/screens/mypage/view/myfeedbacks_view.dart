import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/domain/model/character/character.dart';
import 'package:palink_v2/presentation/screens/common/appbar_perferred_size.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/myfeedbacks_viewmodel.dart';

class MyfeedbacksView extends StatelessWidget {
  final MyfeedbacksViewmodel viewModel = Get.put(MyfeedbacksViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('내 피드백 기록', style: textTheme().titleMedium),
        centerTitle: false,
        bottom: appBarBottomLine(),
      ),
      body: GetBuilder<MyfeedbacksViewmodel>(
        builder: (viewModel) {
          if (viewModel.chatrooms.isEmpty) {
            return const Center(child: Text('피드백이 없습니다.'));
          }

          return ListView.builder(
            itemCount: viewModel.chatrooms.length,
            reverse: true,
            itemBuilder: (context, index) {
              var chatroom = viewModel.chatrooms[index];
              var character = viewModel.characters[chatroom.characterId];
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    tileColor: Colors.white, // 배경을 하얀색으로 설정
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(character!.image)
                    ),
                    title: Text(character != null ? character.name : '익명', style: textTheme().titleMedium),
                    subtitle: Text(_formatDate(chatroom.day)),
                    horizontalTitleGap: 30.0,
                  ),
                  const Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }


  // 날짜 포맷팅 함수
  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일 ${date.hour}시 ${date.minute}분';
  }
}
