import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String? title;
  final String? msg;
  final Function() edit;

  NoteCard({required this.title, required this.msg, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: new BoxDecoration(
            border: BorderDirectional(
              start:
                  BorderSide(width: 8, color: Theme.of(context).primaryColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(title ?? S.of(context).unknown),
              subtitle: Text(msg ?? S.of(context).unknown),
              trailing: InkWell(
                customBorder: CircleBorder(),
                onTap: edit,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
