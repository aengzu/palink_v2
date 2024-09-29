import 'package:flutter/material.dart';
import 'package:palink_v2/core/theme/app_colors.dart';


class LikingBar extends StatelessWidget {
  final int affinityScore;

  LikingBar(this.affinityScore);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 68,
        height: 8,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pink, width: 1),
          borderRadius: BorderRadius.circular(7),
        ),
        margin: const EdgeInsets.only(bottom: 2, top: 10, left: 5),
        child: LinearProgressIndicator(
          value: affinityScore / 100,
          backgroundColor: Colors.grey[200],
          color: AppColors.pink,
          borderRadius: BorderRadius.circular(7),
          minHeight: 10,
        ));
  }
}
