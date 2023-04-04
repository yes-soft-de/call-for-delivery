import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/actor_info.dart';
import 'package:c4d/module_statistics/ui/widget/order/detail_row.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

enum Mode { lastActive, lastTransaction }

class ActorCard extends StatelessWidget {
  final StatisticsActors actor;
  final Mode mode = Mode.lastTransaction;

  const ActorCard({Key? key, required this.actor}) : super(key: key);

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
                      onTap: () {
                        actor is Store
                            ? Navigator.pushNamed(context, StoresRoutes.STORES)
                            : Navigator.pushNamed(
                                context, CaptainsRoutes.CAPTAINS);
                      },
                      title: actor is StatisticsStores
                          ? S.current.activeStores
                          : S.current.activeCapitan,
                      value: actor.active.toString()),
                  DetailRow(
                      onTap: () {
                        actor is Store
                            ? Navigator.pushNamed(
                                context, StoresRoutes.STORES_INACTIVE)
                            : Navigator.pushNamed(
                                context, CaptainsRoutes.IN_ACTIVE_CAPTAINS);
                      },
                      title: actor is StatisticsStores
                          ? S.current.inactiveStores
                          : S.current.inActiveCaptains,
                      value: actor.nonActive.toString()),
                ],
              ),
            ),
            mode == Mode.lastActive
                ? Text(
                    '${S.current.last} ${actor.lastActorsActive.length} ${S.current.actives}')
                : Text(
                    '${S.current.last} ${actor.lastActorsMadeTransactions.length} ' +
                        (actor is StatisticsCaptains
                            ? '${S.current.deliveredOrders}'
                            : '${S.current.createdOrders}')),
            Expanded(
              child: Swiper(
                pagination: SwiperPagination(
                    margin: EdgeInsets.only(bottom: 5),
                    builder: SwiperPagination.dots,
                    alignment: Alignment.bottomCenter),
                itemCount: mode == Mode.lastActive
                    ? actor.lastActorsActive.length
                    : actor.lastActorsMadeTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ActorInfo(
                    actor: mode == Mode.lastActive
                        ? actor.lastActorsActive[index]
                        : actor.lastActorsMadeTransactions[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
