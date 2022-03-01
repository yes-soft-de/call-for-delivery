import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;
  final double? radius;

  const CustomIconButton(
      {Key? key,
      required this.backgroundColor,
      required this.icon,
      required this.iconColor,
      this.radius,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 12),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).backgroundColor,
                    blurRadius: 12,
                    spreadRadius: 2.5,
                    offset: Offset(-0.5, 0))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          )),
    );
  }
}
