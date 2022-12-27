import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_delivary_car/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarCard extends StatelessWidget {
  final CarsModel model;
  final Function() edit;

  CarCard({required this.model, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.carCrash,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            title: Text(
              model.carModel,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.details.isNotEmpty ? Text(model.details) : Container(),
                Row(
                  children: [
                    Text(S.of(context).deliveryCarsCost + ':  '),
                    Text(
                      model.deliveryCost.toString() + ' ' + S.of(context).sar,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            trailing: InkWell(
              customBorder: CircleBorder(),
              onTap: edit,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
