import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/ui/widget/orders/icon_info_button.dart';
import 'package:c4d/utils/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class OwnerOrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String createdDate;
  final String orderCost;
  final String note;
  final String? kilometer;
  final String? storeBranchToClientDistance;
  final String? externalCompanyName;
  final String? orderIdInExternalCompany;

  OwnerOrderCard({
    required this.orderNumber,
    required this.orderStatus,
    required this.createdDate,
    required this.deliveryDate,
    required this.orderCost,
    required this.note,
    this.storeBranchToClientDistance,
    this.kilometer,
    required this.externalCompanyName,
    this.orderIdInExternalCompany,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.primary.withOpacity(0.9),
            Theme.of(context).colorScheme.primary.withOpacity(0.93),
            Theme.of(context).colorScheme.primary.withOpacity(0.95),
            Theme.of(context).colorScheme.primary,
          ])),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Visibility(
                  visible: kilometer != null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        kilometer.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: storeBranchToClientDistance != null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.orange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        storeBranchToClientDistance.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: externalCompanyName.notNullOrEmpty(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Text(
                        externalCompanyName ?? '',
                      ),
                    ),
                  ),
                ),
                Spacer(),
                InfoButtonOrder(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(S.current.note),
                            content: Container(child: Text(note)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(S.current.close)),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            // order number & order status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.orderNumber, subtitle: orderNumber),
                verticalTile(context,
                    title: S.current.orderStatus, subtitle: orderStatus),
              ],
            ),
            // divider
            divider(context),
            // order date & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.deliverDate, subtitle: deliveryDate),
                verticalTile(context,
                    title: S.current.createdDate, subtitle: createdDate),
              ],
            ),
            // divider
            divider(context),
            // order cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.cost, subtitle: orderCost),
                Visibility(
                  visible: orderIdInExternalCompany == null,
                  child: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  replacement: verticalTile(
                    context,
                    title: S.current.orderNumberInExternalCompany,
                    subtitle: orderIdInExternalCompany ?? '',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.background),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget divider(context) {
    Color dividerColor = Theme.of(context).colorScheme.background;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}
