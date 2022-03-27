import 'package:flutter/material.dart';

class AlertContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? background;
  const AlertContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color:background ?? Colors.amber),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title,
              style:  TextStyle(
                  color: Colors.white, fontWeight: subtitle != null ? FontWeight.bold : null)),
          subtitle: Visibility(
            visible: subtitle != null,
            child: Text(
              subtitle ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
