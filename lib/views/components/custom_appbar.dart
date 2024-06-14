import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CustomAppBar extends StatelessWidget {
  final title;
  final bottomline;
  const CustomAppBar({super.key, required this.title, required this.bottomline});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [

        IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bell)),
      ],
      bottom: bottomline,
    );
  }
}
