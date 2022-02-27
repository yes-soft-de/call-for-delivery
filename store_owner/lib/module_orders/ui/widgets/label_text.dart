import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;

  LabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8).copyWith(top: 0,bottom: 0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
