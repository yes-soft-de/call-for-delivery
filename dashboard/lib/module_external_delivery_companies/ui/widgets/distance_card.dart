import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class DistanceCard extends StatefulWidget {
  const DistanceCard({
    super.key,
    required this.distance,
    required this.onChange,
  });

  final FromTo<int> distance;
  final Function(FromTo<int> distance) onChange;

  @override
  State<DistanceCard> createState() => _DistanceCardState();
}

class _DistanceCardState extends State<DistanceCard> {
  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      fromTextController.text = widget.distance.from.toString();
      toTextController.text = widget.distance.to.toString();
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.distance),
                Switch(
                  thumbColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  activeColor: Colors.green,
                  value: widget.distance.isFilterActive,
                  onChanged: (value) {
                    widget.distance.isFilterActive = value;
                    setState(() {});
                    widget.onChange(widget.distance);
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
                    Row(
                      children: [
                        _Form(
                          textController: fromTextController,
                          onChange: (value) {
                            widget.distance.from =
                                int.tryParse(value ?? '') ?? 0;
                            widget.onChange(widget.distance);
                          },
                        ),
                        SizedBox(width: 10),
                        Text(S.current.km),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.current.to),
                    Row(
                      children: [
                        _Form(
                          textController: toTextController,
                          onChange: (value) {
                            widget.distance.to = int.tryParse(value ?? '') ?? 0;
                            widget.onChange(widget.distance);
                          },
                        ),
                        SizedBox(width: 10),
                        Text(S.current.km),
                      ],
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

class _Form extends StatelessWidget {
  const _Form({
    required this.textController,
    required this.onChange,
  });

  final TextEditingController textController;
  final Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Container(
        width: 100,
        child: CustomFormField(
          radius: 10,
          backgroundColor: Colors.white,
          controller: textController,
          numbers: true,
          onChanged: () {
            onChange(textController.text);
          },
        ),
      ),
    );
  }
}
