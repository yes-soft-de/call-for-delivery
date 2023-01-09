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
          height: 30,
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //       color: backgroundColor.withOpacity(0.5),
            //       spreadRadius: 1,
            //       blurRadius: 10,
            //       offset: const Offset(-0.2, 0)),
            // ],
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
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button?.color),
                  ),
                ],
              ))),
    );
  }
}
