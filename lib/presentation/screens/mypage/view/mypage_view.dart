import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import 'package:palink_v2/di/locator.dart';
import 'package:palink_v2/presentation/screens/chatting/view/components/custom_btn_small.dart';
import 'package:palink_v2/presentation/screens/mypage/controller/mypage_viewmodel.dart';
import 'package:palink_v2/presentation/screens/mypage/view/component/profile_section.dart';
import 'package:palink_v2/presentation/screens/mypage/view/component/user_info_section.dart';
import 'package:palink_v2/presentation/screens/mypage/view/myfeedbacks_view.dart';
import '../../common/appbar_perferred_size.dart';
import 'myconversations_view.dart';

class MypageView extends StatelessWidget {
  final MypageViewModel mypageViewmodel = Get.put(getIt<MypageViewModel>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                          child: const Text('닫기',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              }),
        ],
        bottom: appBarBottomLine(),
      ),
      body: SingleChildScrollView( // 추가: 스크롤 가능하게 만듭니다.
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSection(mypageViewmodel: mypageViewmodel),
              const SizedBox(height: 20),
              UserInfoCard(mypageViewmodel: mypageViewmodel),
              const SizedBox(height: 10),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: const Text('대화 기록 보러가기'),
                      onTap: () => Get.to(() => MyconversationsView()),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: const Text('지난 피드백 보러가기'),
                      onTap: () => Get.to(() => MyfeedbacksView()),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: const Text('내 테스트 결과 보기'),
                      onTap: () => _showComingSoonDialog(context),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: const Text('내 감정 목록 보기'),
                      onTap: () => _showComingSoonDialog(context),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: const Text('로그아웃'),
                      onTap: () => mypageViewmodel.logout(),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
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
  }
}
