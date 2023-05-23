import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onEdit;
  final bool status;
  final Function(bool) onActivate;
  CategoryCard(
      {required this.name,
      required this.description,
      required this.onEdit,
      required this.onActivate,
      this.status = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: name,
                  content: description,
                  oneAction: true,
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: Offset(-0.2, 0)),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Switch(
                    value: status,
                    onChanged: (active) {
                      onActivate(active);
                    }),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: onEdit,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
