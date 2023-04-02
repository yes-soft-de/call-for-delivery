import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/detail_row.dart';
import 'package:c4d/module_statistics/ui/widget/store_info.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class StoresCard extends StatelessWidget {
  final StatisticsStores stores;

  const StoresCard({Key? key, required this.stores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DetailRow(
              title: S.current.activeStores, value: stores.active.toString()),
          DetailRow(
              title: S.current.inactiveStores,
              value: stores.nonActive.toString()),
          Text(S.current.last3Active),
          Expanded(
            child: Swiper(
              pagination: SwiperPagination(
                  margin: EdgeInsets.only(bottom: 5),
                  builder: SwiperPagination.dots,
                  alignment: Alignment.bottomCenter),
              itemCount: stores.stores.length,
              itemBuilder: (BuildContext context, int index) {
                return StoreInfo(store: stores.stores[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
