import 'package:flutter/material.dart';

class SelectableItem<T> extends StatelessWidget {
  final Function() onTap;
  final T value;
  final T selectedValue;
  final String title;

  const SelectableItem(
      {required this.onTap,
      required this.value,
      required this.selectedValue,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == selectedValue ? Color(0xff024D92) : Colors.grey,
              ),
            ),
            SizedBox(width: 10),
            Text(title)
          ],
        ),
      ),
    );
  }
}