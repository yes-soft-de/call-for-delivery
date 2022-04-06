import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class CaptainOfferCard extends StatelessWidget {
  final CaptainsOffersModel model;
  final VoidCallback onEdit;
  final Function onEnable;
  CaptainOfferCard(
      {required this.model, required this.onEdit, required this.onEnable});

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
                  blurRadius: 10,
                  offset: Offset(-0.2, 0)),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomC4dAppBar.actionIcon(context,
                    icon: Icons.edit, onTap: onEdit,padding: EdgeInsetsDirectional.only(start: 16,top: 8)),
                Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16,top: 8),
                  child: Switch(
                      activeColor: Colors.green,
                      value: model.status == 'active',
                      onChanged: (v) {
                        if (v) {
                          onEnable('active');
                        } else {
                          onEnable('inactive');
                        }
                      }),
                ),
              ],
            ),
            // package info
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 16, end: 16, top: 16, bottom: 16),
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
                      child: Icon(FontAwesomeIcons.car,
                          color: Theme.of(context).disabledColor),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 80,
                    child: model.carCount != 0
                        ? Text(
                            '${model.carCount} ' + S.of(context).car,
                          )
                        : Text(
                            '∞ ' + S.of(context).car,
                          ),
                  ),
                ],
              ),
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
                      '${model.price} ' + S.current.sar,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
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
                      child: Icon(FontAwesomeIcons.calendarDay,
                          color: Theme.of(context).disabledColor),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    child: Text(
                      '${model.expired} ' + S.current.day,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
