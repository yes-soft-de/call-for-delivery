import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class  CaptainOfferCard extends StatelessWidget {
  final CaptainsOffersModel model;
  final VoidCallback onEdit;
  CaptainOfferCard(
      {required this.model,
        required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              Row(children: [
                Column(children: [
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
                                color:Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 105,
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
                ],),
                Column(children: [
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
                            child: Icon(FontAwesomeIcons.coins,color:
                            Theme.of(context).colorScheme.primary),
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
                            child: FaIcon(FontAwesomeIcons.calendarDay,
                                color:Theme.of(context).colorScheme.primary),
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
                ],),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}