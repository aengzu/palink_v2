import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palink_v2/constants/app_colors.dart';
import 'package:sizing/sizing.dart';

import '../../../constants/app_fonts.dart';

class TipButton extends StatelessWidget {
  final String tipContent;
  final bool isExpanded;
  final bool isLoading;
  final VoidCallback onToggle;

  TipButton({
    required this.tipContent,
    required this.isExpanded,
    required this.isLoading,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isExpanded ? _buildExpandedTip() : _buildFloatingButton(),
      ],
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: onToggle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: const Text("TIP", style: TextStyle(color: Colors.white, fontSize: 20)),
      backgroundColor: AppColors.deepBlue,
    );
  }

  Widget _buildExpandedTip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: onToggle,
          child: const Icon(Icons.close, color: Colors.white),
          backgroundColor: AppColors.deepBlue,
        ),
        SizedBox(height: 0.01.sh),
        Container(
          width: 0.85.sw,
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.017.sh),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            children: [
              Text('이렇게 말할 수 있어요 😊', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 0.007.sh),
              if (isLoading)
                const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                )
              else
                Text(
                  tipContent,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
