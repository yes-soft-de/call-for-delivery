import 'package:flutter/material.dart';

class RecycleOrderButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final IconData icon;
  final String title;

  final bool short;
  const RecycleOrderButton(
      {Key? key,
      this.onTap,
      required this.backgroundColor,
      required this.icon,
      required this.title,
      this.short = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: backgroundColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(-0.2, 0)),
          ],
          gradient: LinearGradient(
            colors: [
              backgroundColor.withOpacity(0.85),
              backgroundColor.withOpacity(0.85),
              backgroundColor.withOpacity(0.9),
              backgroundColor.withOpacity(0.93),
              backgroundColor.withOpacity(0.95),
              backgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            minLeadingWidth: short ? 8 : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: onTap,
            leading: Icon(
              icon,
              color: Theme.of(context).textTheme.button?.color,
            ),
            title: Text(title),
            textColor: Theme.of(context).textTheme.button?.color,
            trailing: onTap != null && !short
                ? Icon(Icons.arrow_forward_rounded,
                    color: Theme.of(context).textTheme.button?.color)
                : null,
          ),
        ),
      ),
    );
  }
}
