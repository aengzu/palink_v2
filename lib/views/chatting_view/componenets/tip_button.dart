// TipButton 수정

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/constants/app_colors.dart';
import '../../../controller/tip_viewmodel.dart';

class TipButton extends StatelessWidget {
  final TipButtonViewModel viewModel = Get.put(TipButtonViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          viewModel.isExpanded.value ? _buildExpandedTip(viewModel.tipContent.value) : _buildFloatingButton(),
        ],
      );
    });
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        viewModel.toggle();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: const Text("TIP", style: TextStyle(color: Colors.white, fontSize: 20)),
      backgroundColor: AppColors.deepBlue,
    );
  }

  Widget _buildExpandedTip(String tipContent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            viewModel.toggle();
          },
          child: const Icon(Icons.close, color: Colors.white),
          backgroundColor: AppColors.deepBlue,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TIP",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                tipContent, // ViewModel에서 전달된 팁 내용 표시
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}