import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_fonts.dart';
import '../../common/appbar_perferred_size.dart';

class MyfeedbacksView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('PALINK', style: textTheme().titleLarge),
        centerTitle: false,
        bottom: appBarBottomLine(),
      ),
      body: Text('피드백들'),
    );
  }
}
