import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/ui/widget/package_card/info_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SinglePackageCard extends StatelessWidget {
  final String packageName;
  final int packageType;
  final String packageInfo;
  final String ordersCount;
  final String carsCount;
  final bool active;
  final String expired;
  final dynamic unPaidCashOrdersSum;
  final num geographicalRange;
  final num packageExtraCost;
  SinglePackageCard(
      {this.active = false,
      required this.packageInfo,
      required this.packageName,
      required this.carsCount,
      required this.ordersCount,
      required this.expired,
      required this.geographicalRange,
      required this.packageExtraCost,
      this.unPaidCashOrdersSum, required this.packageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 8, left: 8),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          decoration: BoxDecoration(
              gradient: active
                  ? LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary.withOpacity(0.9),
                      Theme.of(context).colorScheme.primary,
                    ])
                  : null,
              borderRadius: BorderRadius.circular(25),
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: active
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                        : Theme.of(context).colorScheme.background,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(-0.2, 0)),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: packageInfo != '',
                replacement: SizedBox(
                  height: 16,
                ),
                child: InfoButton(onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 350),
                          tween: Tween<double>(begin: 0, end: 1),
                          curve: Curves.linear,
                          builder: (context, double val, child) {
                            return Transform.scale(
                              scale: val,
                              child: child,
                            );
                          },
                          child: AlertDialog(
                            title: Text(S.current.note),
                            content: Container(child: Text(packageInfo)),
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
                          ),
                        );
                      });
                }),
              ),
              // package name
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  packageName,
                  style: TextStyle(
                      color: active
                          ? Theme.of(context).textTheme.labelLarge?.color
                          : null,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // divider
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, top: 16, bottom: 16),
                child: DottedLine(
                  dashColor: Theme.of(context).colorScheme.background,
                  lineThickness: 2.5,
                  dashRadius: 25,
                ),
              ),
              // package info
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  S.current.packageInfo,
                  style: TextStyle(
                      color: active
                          ? Theme.of(context).textTheme.labelLarge?.color
                          : null,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // order in month
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.sync_alt_rounded,
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      // width: 105,
                      child: Text(
                        (packageType == 1
                            ? S.current.unLimitedOrders
                            : '${ordersCount} ' + S.of(context).sOrder),
                        style: TextStyle(
                          color: active
                              ? Theme.of(context).textTheme.labelLarge?.color
                              : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // car count
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.car,
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).disabledColor),
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
                              style: TextStyle(
                                color: active
                                    ? Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.color
                                    : null,
                              ),
                            )
                          : Text(
                              '∞ ' + S.of(context).car,
                              style: TextStyle(
                                color: active
                                    ? Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.color
                                    : null,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.date_range_rounded,
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 105,
                      child: Text(
                        '$expired' +
                            ' ' +
                            S.current.day +
                            ' ' +
                            S.current.validation,
                        style: TextStyle(
                          color: active
                              ? Theme.of(context).textTheme.labelLarge?.color
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // packageExtraCost
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.attach_money_rounded,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 105,
                      child: Text(
                        '$packageExtraCost' + ' ' + S.current.sar,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // geographicalRange
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_road_rounded,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 105,
                      child: Text(
                        '$geographicalRange' + ' ' + S.current.km,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 16,
              ),
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
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.moneyCheck,
                            color: active
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          '$unPaidCashOrdersSum' + ' ' + S.current.sar,
                          style: TextStyle(
                            color: active
                                ? Theme.of(context).textTheme.labelLarge?.color
                                : null,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${S.current.unpaidOrders}',
                          style: TextStyle(
                            color: active
                                ? Theme.of(context).textTheme.labelLarge?.color
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          )),
    );
  }
}
