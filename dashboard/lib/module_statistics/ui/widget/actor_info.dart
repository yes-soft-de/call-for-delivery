import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActorInfo extends StatelessWidget {
  final Actor actor;

  const ActorInfo({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          actor is Captain ? Colors.lightBlue.shade200 : Colors.yellow.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 50,
                width: 50,
                child: Image.network(
                  actor.image,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                      actor is Captain
                          ? ImageAsset.DELIVERY_MOTOR
                          : ImageAsset.STORE_CATEGORY_SUPER_MARKET),
                  fit: BoxFit.cover,
                )),
            Text('${S.current.name}: ${actor.name}'),
            Text('${S.current.number}: ${actor.id}'),
            Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Text(
              '${actor is Captain ? S.current.LastDeliveredDelivery : S.current.LastCreatedDelivery}',
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${S.current.time}: ${DateFormat.jm().format(actor.createAt)}'),
                Text(
                  '${S.current.date}: ${DateFormat.MMMMd().format(actor.createAt)}',
                ),
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
