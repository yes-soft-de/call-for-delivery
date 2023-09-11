import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captain_model.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captain_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NaherEvanCaptainStateLoaded extends States {
  NaherEvanCaptainScreenState screenState;
  NaherEvanCaptainModel captain;

  NaherEvanCaptainStateLoaded(this.screenState, this.captain)
      : super(screenState);

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    return FixedContainer(
      child: Visibility(
        visible:
            captain.deliveredOrderCount != 0 && captain.onlineHoursCount != 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _RowInfo(
                        title: S.current.onlineHoursCount,
                        value: captain.onlineHoursCount.toString(),
                      ),
                      _RowInfo(
                        title: S.current.deliveredOrderCount,
                        value: captain.deliveredOrderCount.toString(),
                      ),
                      _RowInfo(
                        title: S.current.createdOrderCount,
                        value: captain.createdOrderCount.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Flexible(child: _CaptainActivity(logList: captain.logs)),
            ],
          ),
        ),
        replacement: Center(
          child: Card(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                S.current.noCaptainActivityInTheSelectedDateRange,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String title;
  final String value;

  const _RowInfo({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          Text(
            value,
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _CaptainActivity extends StatelessWidget {
  final List<Log> logList;

  _CaptainActivity({required this.logList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.captainPresence,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            Flexible(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: logList.length,
              itemBuilder: (context, index) {
                return _LogCard(log: logList[index]);
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final Log log;

  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        color: log.isOnline ? Colors.greenAccent : Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                log.isOnline
                    ? S.current.captainOnline
                    : S.current.captainOffline,
              ),
              Text(DateFormat('yyyy-MM-dd HH:mm', 'en').format(log.createdAt)),
            ],
          ),
        ),
      ),
    );
  }
}
