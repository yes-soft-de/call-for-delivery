import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/ui/widget/info_button.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class SinglePackageCard extends StatelessWidget {
  final String packageName;
  final String packageInfo;
  final String ordersCount;
  final String carsCount;
  final String cost;
  final String expaired;
  final String city;
  final String status;
  final Function enablePackage;
  final Function() edit;

  SinglePackageCard(
      {required this.enablePackage,
      required this.edit,
      required this.status,
      required this.packageInfo,
      required this.packageName,
      required this.carsCount,
      required this.city,
      required this.ordersCount,
      required this.cost,
      required this.expaired});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).backgroundColor,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-0.2, 0)),
            ]),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // package name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      packageName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                      activeColor: Colors.green,
                      value: status == 'active',
                      onChanged: (v) {
                        if (v) {
                          enablePackage('active');
                        } else {
                          enablePackage('inactive');
                        }
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      city,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomC4dAppBar.actionIcon(context,
                      onTap: edit,
                      icon: Icons.edit,
                      padding: EdgeInsetsDirectional.only(end: 8))
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Text(packageInfo),
              ),
              // divider
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, top: 16, bottom: 16),
                child: DottedLine(
                  dashColor: Theme.of(context).backgroundColor,
                  lineThickness: 2.5,
                  dashRadius: 25,
                ),
              ),
              // package info
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.sync_alt_rounded,
                                    color: Theme.of(context).disabledColor),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 105,
                              child: Text(
                                '${ordersCount} ' + S.of(context).ordermonth,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // car count
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.car,
                                    color: Theme.of(context).disabledColor),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: 105,
                              child: carsCount != 0
                                  ? Text(
                                      '${carsCount} ' + S.of(context).car,
                                    )
                                  : Text(
                                      '∞ ' + S.of(context).car,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: DottedLine(
                      direction: Axis.vertical,
                      dashColor: Theme.of(context).backgroundColor,
                      lineLength: 125,
                      lineThickness: 2.5,
                      dashRadius: 25,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.coins,
                                    color: Theme.of(context).disabledColor),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              child: Text(
                                '${cost} ' + S.current.sar,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // expiration
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.calendarAlt,
                                    color: Theme.of(context).disabledColor),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              child: Text(
                                '${expaired} ' + S.current.day,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
