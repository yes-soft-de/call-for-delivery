import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class  CategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onEdit;
  CategoryCard(
      {required this.name,
        required this.description,
        required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          showDialog(
              context:  context,
              builder: (context) {
                return CustomAlertDialog(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: name,
                    content:description,oneAction: true,);
              });

        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
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
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: onEdit,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.background.withOpacity(0.2),
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
//                InkWell(
//                  customBorder: CircleBorder(),
//                  onTap: onTap,
//                  child: Container(
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Theme.of(context).backgroundColor.withOpacity(0.2),
//                    ),
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.delete,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  width: 8,
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}