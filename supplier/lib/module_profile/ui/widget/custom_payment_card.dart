import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';

class CustomListTileCaptainsPayment extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;

  CustomListTileCaptainsPayment(
      {required this.title, required this.subTitle, required this.iconData});

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData, color: Theme.of(context).disabledColor),
          )),
      title: Text(
        title,
        style: TextStyle(),
      ),
      trailing: icon,
      subtitle: Text(
        subTitle,
        style: TextStyle(),
        textDirection: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.ltr
            : null,
        textAlign: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextAlign.right
            : null,
      ),
    );
  }
}
