import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class SupplierCategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final bool status;
  final VoidCallback onEdit;
  final Function enablePackage;
  SupplierCategoryCard(
      {required this.name,
      required this.description,
      required this.onEdit,
      required this.image,
      required this.status,
      required this.enablePackage});

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
                  child: CustomNetworkImage(
                      height: 60, width: 60, imageSource: image),
                ),
                Expanded(child: Text(name)),
                Spacer(
                  flex: 1,
                ),
                Switch(
                    activeColor: Colors.green,
                    value: status,
                    onChanged: (v) {
                      if (v) {
                        enablePackage(true);
                      } else {
                        enablePackage(false);
                      }
                    }),
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
