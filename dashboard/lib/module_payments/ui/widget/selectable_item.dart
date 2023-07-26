import 'package:flutter/material.dart';

class SelectableItem<T> extends StatelessWidget {
  final Function() onTap;
  final T value;
  final T selectedValue;
  final String title;
  final Color? selectedColor;
  final double thumpSize;

  const SelectableItem({
    required this.onTap,
    required this.value,
    required this.selectedValue,
    required this.title,
    this.thumpSize = 20,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: thumpSize,
              width: thumpSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == selectedValue
                    ? (selectedColor ?? Color(0xff024D92))
                    : Colors.grey,
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
