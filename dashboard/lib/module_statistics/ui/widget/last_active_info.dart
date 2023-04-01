import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:flutter/material.dart';

class LastAvtiveInfo extends StatelessWidget {
  final LastThreeActive lastActive;

  const LastAvtiveInfo({Key? key, required this.lastActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
            height: 50,
            width: 50,
            child: Image.network(
              lastActive.image,
              fit: BoxFit.cover,
            )),
        title: Text(lastActive.id.toString()),
        subtitle: Text(lastActive.name),
      ),
    );
  }
}
