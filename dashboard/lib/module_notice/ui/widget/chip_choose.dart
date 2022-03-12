import 'package:flutter/material.dart';

class ChipChoose extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  ChipChoose({required this.title,required this.selected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: selected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title ,style: TextStyle(color: selected ? Colors.white :Colors.black),),
        ),
      ),
    );
  }
}
