import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class  CaptainOfferCard extends StatelessWidget {
  final CaptainsOffersModel model;
  final VoidCallback onEdit;
  final Function onEnable;
  CaptainOfferCard(
      {required this.model,
        required this.onEdit,required this.onEnable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // package info
              Column(children: [
                Row(children: [
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
                  Expanded(
                    child: ListTileSwitch(
                        switchActiveColor: Colors.green.shade900,
                        switchInactiveColor: Colors.red.shade900,
                        value:model.status == 'active',
                        onChanged: (v) {
                          if(v){
                            onEnable('active');
                          }else{
                            onEnable('inactive');
                          }

                        }),
                  ),
                ],),
                Row(children: [
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
                  InkWell(
                    onTap: onEdit,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).primaryColorLight),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(Icons.edit,
                                  color:Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
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