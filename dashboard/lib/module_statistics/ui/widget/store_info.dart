import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:flutter/material.dart';

class StoreInfo extends StatelessWidget {
  final LastThreeActive captain;
  const StoreInfo({Key? key, required this.captain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 50,
                width: 50,
                child: Image.network(
                  captain.image,
                  fit: BoxFit.cover,
                )),
            Text('${S.current.name}: ${captain.name}'),
            Text('${S.current.number}: ${captain.id}'),
            Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Text('${S.current.LastDeliveredDelivery}\n ${captain.createAt}'),
          ],
        ),
      ),
    );
  }
}
