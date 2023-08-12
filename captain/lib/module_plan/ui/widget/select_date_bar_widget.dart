import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color get _lightBlue => const Color(0xffF2FAFD);

class SelectDataBar extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime? selectedDate) onSelected;
  final String title;

  const SelectDataBar({
    super.key,
    required this.selectedDate,
    required this.onSelected,
    required this.title,
  });

  @override
  State<SelectDataBar> createState() => _SelectDataBarState();
}

class _SelectDataBarState extends State<SelectDataBar> {
  bool flag = true;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      _selectedDate = widget.selectedDate;
    }
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        color: _lightBlue,
        child: Material(
          color: Colors.transparent,
          child: TextButton(
            onPressed: () async {
              _selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025),
                  ) ??
                  DateTime.now();
              widget.onSelected(_selectedDate);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    (_selectedDate != null && _selectedDate != DateTime(0))
                        ? DateFormat('yyyy/MM/dd', 'en').format(_selectedDate!)
                        : '0000/00/00',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
