import 'package:flutter/material.dart';

class CustomNavTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  const CustomNavTile(
      {Key? key, required this.icon, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SizedBox(
        height: 60,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
            highlightColor: Theme.of(context).backgroundColor,
            splashFactory: InkRipple.splashFactory,
            onTap: onTap,
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Theme.of(context).colorScheme.primaryContainer,
                  //       spreadRadius: 1.5,
                  //       blurRadius: 6,
                  //       offset: Offset(-0.2, 0)),
                  // ],
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Icon(icon, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              title: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
