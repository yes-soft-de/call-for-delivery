import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/captain_info.dart';
import 'package:c4d/module_statistics/ui/widget/order/detail_row.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CaptainsCard extends StatelessWidget {
  final StatisticsCaptains captains;

  const CaptainsCard({Key? key, required this.captains}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DetailRow(
                      title: S.current.activeCapitan,
                      value: captains.active.toString()),
                  DetailRow(
                      title: S.current.inActiveCaptains,
                      value: captains.nonActive.toString()),
                ],
              ),
            ),
            Text(S.current.last3Active),
            Expanded(
              child: Swiper(
                itemCount: captains.captains.length,
                itemBuilder: (BuildContext context, int index) {
                  return CaptainInfo(captain: captains.captains[index]);
                },
                pagination: SwiperPagination(
                    margin: EdgeInsets.only(bottom: 5),
                    builder: SwiperPagination.dots,
                    alignment: Alignment.bottomCenter),
              ),
            )
          ],
        ),
      ),
    );
  }
}
