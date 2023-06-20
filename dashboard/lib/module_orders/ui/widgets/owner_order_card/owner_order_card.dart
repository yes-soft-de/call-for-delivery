import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/icon_info_button.dart';
import 'package:c4d/utils/extension/string_extensions.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OwnerOrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String createdDate;
  final num orderCost;
  final String? note;
  final Color? background;
  final bool orderIsMain;
  final String? primaryTitle;
  final IconData? icon;
  final bool? isDelivered;
  final int? captainProfileId;
  final String? storeOwner;
  final String? branchName;
  final String? externalCompanyName;
  final String? orderIdInExternalCompany;

  OwnerOrderCard({
    required this.orderNumber,
    required this.orderStatus,
    required this.createdDate,
    required this.deliveryDate,
    required this.orderCost,
    required this.note,
    this.background,
    this.primaryTitle,
    required this.orderIsMain,
    this.icon,
    this.isDelivered,
    required this.captainProfileId,
    this.storeOwner,
    this.branchName,
    this.externalCompanyName,
    this.orderIdInExternalCompany,
  });

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(colors: [
                color.withOpacity(0.85),
                color.withOpacity(0.85),
                color.withOpacity(0.9),
                color.withOpacity(0.93),
                color.withOpacity(0.95),
                color,
              ])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Visibility(
                  visible: orderIsMain || primaryTitle != null,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.tag,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.amber),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            primaryTitle ?? S.current.groupOrder,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                      Visibility(
                        visible: note != null,
                        child: InfoButtonOrder(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(S.current.note),
                                    content: Container(child: Text(note ?? '')),
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
                      ),
                    ],
                  ),
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      SizedBox(),
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
                      Visibility(
                        visible: note != null,
                        child: InfoButtonOrder(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(S.current.note),
                                    content: Container(child: Text(note ?? '')),
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
                      ),
                    ],
                  ),
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
                    verticalTile(
                      context,
                      title: isDelivered ?? false
                          ? S.current.captain
                          : S.current.deliverDate,
                      subtitle: isDelivered ?? false
                          ? captainProfileId == null
                              ? deliveryDate
                              : deliveryDate + ' ${{captainProfileId}}'
                          : deliveryDate,
                    ),
                    verticalTile(context,
                        title: S.current.createdDate, subtitle: createdDate),
                  ],
                ),
                // store related data
                Visibility(
                    visible: storeOwner != null && branchName != null,
                    child: Column(
                      children: [
                        divider(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            verticalTile(context,
                                title: S.current.storeOwner,
                                subtitle: storeOwner ?? ''),
                            verticalTile(context,
                                title: S.current.branch,
                                subtitle: branchName ?? ''),
                          ],
                        ),
                      ],
                    )),
                // divider
                divider(context),
                // order cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(context,
                        title: S.current.cost,
                        subtitle: FixedNumber.getFixedNumber(orderCost) +
                            ' ' +
                            S.current.sar),
                    Visibility(
                      visible: orderIdInExternalCompany == null,
                      child: Icon(
                        icon ?? Icons.arrow_circle_left_outlined,
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                      replacement: verticalTile(
                        context,
                        title: S.current.orderNumberInExternalCompany,
                        subtitle: orderIdInExternalCompany ?? '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
              color: Theme.of(context).textTheme.labelLarge?.color),
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
    Color dividerColor = Theme.of(context).textTheme.labelLarge!.color!;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}
