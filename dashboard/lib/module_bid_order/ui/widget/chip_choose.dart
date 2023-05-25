import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class ChipChoose extends StatelessWidget {
  final String title;
  final num cost;
  final bool selected;
  final VoidCallback onTap;

  ChipChoose(
      {required this.title,
      required this.selected,
      required this.onTap,
      required this.cost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 3.0,
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                  width: 1, color: Theme.of(context).secondaryHeaderColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                cost.toString() + ' ' + S.of(context).sar,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
