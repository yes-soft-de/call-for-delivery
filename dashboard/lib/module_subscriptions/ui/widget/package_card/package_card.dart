import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_subscriptions/ui/widget/package_card/info_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PackageCard extends StatelessWidget {
  final PackagesModel package;
  final bool active;
  final bool short;
  PackageCard({required this.package, this.active = false, this.short = true});

  @override
  Widget build(BuildContext context) {
    var width = 185.0;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 8, left: 8),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          width: width,
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
                        : Theme.of(context).backgroundColor,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(-0.2, 0)),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoButton(onTap: () {
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
                          content: Container(child: Text(package.note)),
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
              // package name
              Center(
                child: Text(
                  package.name,
                  style: TextStyle(
                      color: active
                          ? Theme.of(context).textTheme.button?.color
                          : null,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // divider
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DottedLine(
                  dashColor: Theme.of(context).backgroundColor,
                  lineThickness: 2.5,
                  dashRadius: 25,
                ),
              ),
              // package info
              Visibility(
                visible: short == false,
                child: Text(
                  S.current.packageInfo,
                  style: TextStyle(
                      color: active
                          ? Theme.of(context).textTheme.button?.color
                          : null,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: short == false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.transparent,
                    thickness: 1.5,
                    endIndent: 24,
                    indent: 24,
                  ),
                ),
              ),
              // order in month
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor),
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
                    width: 100,
                    child: Text(
                      '${package.orderCount} ' + S.of(context).sOrder,
                      style: TextStyle(
                        color: active
                            ? Theme.of(context).textTheme.button?.color
                            : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 32.0, left: 32, top: 8, bottom: 8),
                child: DottedLine(
                  dashColor: Theme.of(context).backgroundColor,
                  lineThickness: 2.5,
                  dashRadius: 25,
                  dashLength: 4,
                ),
              ),
              // car count
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor),
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
                    width: 100,
                    child: package.carCount != 0
                        ? Text(
                            '${package.carCount} ' + S.of(context).car,
                            style: TextStyle(
                              color: active
                                  ? Theme.of(context).textTheme.button?.color
                                  : null,
                            ),
                          )
                        : Text(
                            '∞ ' + S.of(context).car,
                            style: TextStyle(
                              color: active
                                  ? Theme.of(context).textTheme.button?.color
                                  : null,
                            ),
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 32.0, left: 32, top: 8, bottom: 8),
                child: DottedLine(
                  dashColor: Theme.of(context).backgroundColor,
                  lineThickness: 2.5,
                  dashRadius: 25,
                  dashLength: 4,
                ),
              ),
              // expiration
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor),
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
                    width: 100,
                    child: Text(
                      '${package.expired}' +
                          ' ' +
                          S.current.day +
                          ' ' +
                          S.current.validation,
                      style: TextStyle(
                        color: active
                            ? Theme.of(context).textTheme.button?.color
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              // cost
              Padding(
                padding: const EdgeInsets.only(
                    right: 32.0, left: 32, top: 8, bottom: 8),
                child: DottedLine(
                  dashColor: Theme.of(context).backgroundColor,
                  lineThickness: 2.5,
                  dashRadius: 25,
                  dashLength: 4,
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FaIcon(FontAwesomeIcons.coins,
                          color: active
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).disabledColor),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      '${package.cost} ${S.current.sar}',
                      style: TextStyle(
                        color: active
                            ? Theme.of(context).textTheme.button?.color
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
