import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class ActionOrderCard extends StatelessWidget {
  final String orderStatus;
  final String createdDate;
  final String createdBy;
  final String action;
  final Color? background;
  final IconData? icon;
  final String image;
  final String userJobDescription;
  ActionOrderCard(
      {required this.orderStatus,
      required this.createdDate,
      this.background,
      this.icon,
      required this.createdBy,
      required this.action,
      required this.image,
      required this.userJobDescription});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(createdDate,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white)),
              ],
            ),
            //image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: 8, bottom: 8, top: 8),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: ClipOval(
                          // borderRadius: BorderRadius.circular(25),
                          child: CustomNetworkImage(
                            width: 30,
                            height: 30,
                            imageSource: image,
                          ),
                        ),
                      ),
                    ),
                    Text(userJobDescription,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
                Text(createdBy,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.normal)),
                // verticalTile(context,
                //     title: '', subtitle: createdBy),

                // verticalTile(context,
                //     title: S.current.action, subtitle: action),
                // verticalTile(context,
                //     title: S.of(context).actionDate, subtitle: createdDate),
              ],
            ),
            // action & date
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     verticalTile(context,
            //         title: S.current.action, subtitle: action),
            //     verticalTile(context,
            //         title: S.of(context).actionDate, subtitle: createdDate),
            //   ],
            // ),
            // divider
            divider(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.action, subtitle: action),
                verticalTile(context,
                    title: S.current.currentOrderStatus, subtitle: orderStatus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return SizedBox(
      width: 150,
      child: Column(
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
      ),
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
