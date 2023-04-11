import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class OrderCancelDialog extends StatelessWidget {
  final Function(bool, bool) onDone;
  final Function() onExit;
  const OrderCancelDialog({Key? key, required this.onDone,required this.onExit,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool cutOrder = false;
    bool captainProfit = false;
    return AlertDialog(
      title: Text(S.current.warnning),
      content: StatefulBuilder(
        builder: (ctx, setState) {
          return SizedBox(
            height: 125,
            child: Column(
              children: [
                ListTileSwitch(
                  value: cutOrder,
                  onChanged: (v) {
                    cutOrder = v;
                    setState(() {});
                  },
                  title: Text(S.current.cutOrderForStore),
                ),
                ListTileSwitch(
                  value: captainProfit,
                  onChanged: (v) {
                    captainProfit = v;
                    setState(() {});
                  },
                  title: Text(S.current.giveCaptainHalfProfit),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              onDone(cutOrder, captainProfit);
            },
            child: Text(S.current.next)),
             ElevatedButton(
            onPressed: () {
              onExit();
            },
            child: Text(S.current.cancel))
      ],
    );
  }
}
