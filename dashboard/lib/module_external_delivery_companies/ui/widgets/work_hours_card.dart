import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/time_piker.dart';
import 'package:flutter/material.dart';

class WorkHoursCard extends StatefulWidget {
  const WorkHoursCard({
    super.key,
    required this.workHours,
    required this.onChange,
  });

  final FromTo<TimeOfDay> workHours;
  final Function(FromTo<TimeOfDay> workHours) onChange;

  @override
  State<WorkHoursCard> createState() => _WorkHoursCardState();
}

class _WorkHoursCardState extends State<WorkHoursCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.workHours),
                Switch(
                  thumbColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  activeColor: Colors.green,
                  value: widget.workHours.isFilterActive,
                  onChanged: (value) {
                    widget.workHours.isFilterActive = value;
                    setState(() {});
                    widget.onChange(widget.workHours);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.current.from),
                    TimePiker(
                      time: widget.workHours.from,
                      onChange: (time) {
                        widget.workHours.from = time;
                        widget.onChange(widget.workHours);
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.current.to),
                    TimePiker(
                      time: widget.workHours.to,
                      onChange: (time) {
                        widget.workHours.to = time;
                        widget.onChange(widget.workHours);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
