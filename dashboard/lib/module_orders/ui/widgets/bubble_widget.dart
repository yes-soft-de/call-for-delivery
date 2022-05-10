import 'package:flutter/material.dart';

class VerticalBubble extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? background;
  final bool subtitleText;
  final BorderRadius? radius;
  const VerticalBubble(
      {required this.title,
      required this.subtitle,
      this.background,
      this.radius,
      this.subtitleText = false});

  @override
  Widget build(BuildContext context) {
    if (subtitleText) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: background ?? Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: background != null ? Colors.white : null)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 14,
                        color: background != null ? Colors.white : null))
              ],
            ),
          ));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).backgroundColor,
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
