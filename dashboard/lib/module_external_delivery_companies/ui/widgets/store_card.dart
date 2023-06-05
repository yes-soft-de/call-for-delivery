import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class StoresCard extends StatefulWidget {
  final StoreType storeType;
  final List<String> Stores;

  final Function(StoreType storeType) onStoreTypeChange;
  final Function(List<String> stores) onStoresChange;

  const StoresCard({
    super.key,
    required this.storeType,
    required this.Stores,
    required this.onStoreTypeChange,
    required this.onStoresChange,
  });

  @override
  State<StoresCard> createState() => _StoresCardState();
}

class _StoresCardState extends State<StoresCard> {
  late StoreType storeType;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      storeType = widget.storeType;
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.stores),
            SelectableItem<StoreType>(
              onTap: () {
                setState(() {
                  storeType = StoreType.all;
                });
                widget.onStoreTypeChange(storeType);
              },
              value: StoreType.all,
              selectedValue: storeType,
              title: S.current.allStores,
            ),
            SelectableItem<StoreType>(
              onTap: () {
                setState(() {
                  storeType = StoreType.some;
                });
                widget.onStoreTypeChange(storeType);
              },
              value: StoreType.some,
              selectedValue: storeType,
              title: S.current.someStores,
            ),
          ],
        ),
      ),
    );
  }
}
