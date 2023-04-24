import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Function() onTap;

  const DetailRow(
      {Key? key, required this.title, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title),
          Card(
            child: SizedBox(
                height: 30, width: 30, child: Center(child: Text(value))),
          )
        ],
      ),
    );
  }
}
