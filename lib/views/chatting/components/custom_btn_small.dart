import 'package:flutter/material.dart';

class CustomButtonSM extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonSM({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.lightBlue[50],
        // Button text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w100,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
