import 'package:flutter/material.dart';

class VerticalBubble extends StatelessWidget {
  final String title;
  final Color? background;
  final String subtitle;
  final bool subtitleText;
  const VerticalBubble({
    Key? key,
    this.background,
    required this.subtitle,
    this.subtitleText = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).colorScheme.background,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
          subtitle: Text(subtitle,
              style: TextStyle(
                  color: background != null ? Colors.white : null,
                  fontSize: subtitleText ? 14 : null)),
        ),
      ),
    );
  }
}
