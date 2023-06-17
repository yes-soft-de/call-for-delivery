import 'package:flutter/material.dart';

class SelectableItem<T> extends StatelessWidget {
  final Function() onTap;
  final T value;
  final T selectedValue;
  final String title;
  final TextDirection? textDirection;

  const SelectableItem({
    required this.onTap,
    required this.value,
    required this.selectedValue,
    required this.title,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          textDirection: textDirection,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffFFE9D1), width: 3),
                shape: BoxShape.circle,
                color: value == selectedValue ? Color(0xff03816A) : Colors.grey,
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Color(0xffFFE9D1),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
