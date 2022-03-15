import 'package:flutter/material.dart';

class CompanyListTile extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final bool number;
  const CompanyListTile(
      {Key? key,
      required this.icon,
      this.onTap,
      required this.subtitle,
      required this.title,
      this.number = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(-0.2, 0)),
            ],
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.primary.withOpacity(0.9),
                Theme.of(context).colorScheme.primary,
              ],
            )),
        child: Material(
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: onTap,
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.grey[100]),
              textDirection:
                  number && Localizations.localeOf(context).languageCode == 'ar'
                      ? TextDirection.ltr
                      : null,
              textAlign:
                  number && Localizations.localeOf(context).languageCode == 'ar'
                      ? TextAlign.right
                      : null,
            ),
            trailing: onTap != null
                ? Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).textTheme.button?.color,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
