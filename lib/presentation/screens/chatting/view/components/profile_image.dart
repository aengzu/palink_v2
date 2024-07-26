import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  // 프로필 이미지 위젯
  const ProfileImage({
    Key? key,
    required this.path,
    required this.imageSize,
  }) : super(key: key);

  final String? path;
  final double imageSize;

  @override
  State<ProfileImage> createState() => ProfileImageState();
}

class ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      width: widget.imageSize,
      height: widget.imageSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
            image: widget.path != null
                ? AssetImage(widget.path!)
                : const AssetImage('assets/images/default_user_profile.png')
                    as ImageProvider,
            fit: BoxFit.cover),
      ),
    ));
  }
}
