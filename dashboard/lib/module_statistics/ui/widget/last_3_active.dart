import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/last_active_info.dart';
import 'package:flutter/material.dart';

class Last3Active extends StatelessWidget {
  final List<LastThreeActive> lastActive;

  const Last3Active({Key? key, required this.lastActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            S.current.last3Active,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          LastAvtiveInfo(
            lastActive: lastActive[0],
          ),
          LastAvtiveInfo(
            lastActive: lastActive[1],
          ),
          LastAvtiveInfo(
            lastActive: lastActive[2],
          ),
        ],
      ),
    );
  }
}
