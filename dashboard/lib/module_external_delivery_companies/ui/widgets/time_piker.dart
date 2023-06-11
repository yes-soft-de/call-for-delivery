import 'package:flutter/material.dart';

class TimePiker extends StatefulWidget {
  const TimePiker({
    super.key,
    required this.time,
    required this.onChange,
  });

  final TimeOfDay time;
  final Function(TimeOfDay time) onChange;

  @override
  State<TimePiker> createState() => _TimePikerState();
}

class _TimePikerState extends State<TimePiker> {
  late TimeOfDay time;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      time = widget.time;
    }
    return InkWell(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Container(
          constraints: BoxConstraints(minHeight: 50, minWidth: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('${time.format(context)}'),
            ),
          ),
        ),
      ),
      onTap: () async {
        var selected = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (selected != null) {
          setState(() {
            time = selected;
          });
        }
        widget.onChange(time);
      },
    );
  }
}
