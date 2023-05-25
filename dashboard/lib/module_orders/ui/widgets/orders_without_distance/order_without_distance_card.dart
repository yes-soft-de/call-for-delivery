import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderWithoutDistance extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String createdDate;
  final num orderCost;
  final Color? background;
  final String destinationUrl;
  final LatLng branchLocation;
  final Function() onEdit;
  OrderWithoutDistance(
      {required this.orderNumber,
      required this.orderStatus,
      required this.createdDate,
      required this.deliveryDate,
      required this.orderCost,
      this.background,
      required this.destinationUrl,
      required this.branchLocation,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    return Container(
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
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: IconButton(
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit_road_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )),
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
                verticalTile(context,
                    title: S.current.deliverDate, subtitle: deliveryDate),
                verticalTile(context,
                    title: S.current.createdDate, subtitle: createdDate),
              ],
            ),
            divider(context),
            // branch location && destination location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // branch
                Expanded(
                  child: InkWell(
                    onTap: () {
                      String url = '';
                      url = LauncherLinkHelper.getMapsLink(
                          branchLocation.latitude, branchLocation.longitude);
                      canLaunch(url).then((value) {
                        if (value) {
                          launch(url);
                        } else {
                          Fluttertoast.showToast(msg: S.current.invalidMapLink);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.store_mall_directory_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          S.current.branchLocation,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // destination
                Expanded(
                  child: InkWell(
                    onTap: () {
                      String url = '';
                      url = destinationUrl;
                      canLaunch(url).then((value) {
                        if (value) {
                          launch(url);
                        } else {
                          Fluttertoast.showToast(msg: S.current.invalidMapLink);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.person_pin_circle_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          S.current.clientLocation,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Theme.of(context).textTheme.button?.color,
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
              color: Theme.of(context).textTheme.button?.color),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget divider(context) {
    Color dividerColor = Theme.of(context).textTheme.button!.color!;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}
