import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/selectable_item.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_pick_branches_dialog.dart';
import 'package:flutter/material.dart';

class StoresCard extends StatefulWidget {
  final StoreType storeType;
  final List<BranchesModel> Stores;

  final Function(StoreType storeType) onStoreTypeChange;
  final Function(List<BranchesModel> stores) onStoresChange;

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
  late List<BranchesModel> branches;
  bool flag = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      storeType = widget.storeType;
      branches = widget.Stores;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Visibility(
                  visible: storeType == StoreType.some,
                  child: InkWell(
                    onTap: () async {
                      // show pick branch dialog
                      var v = await showPickBranchDialog(context);
                      if (v != null)
                        branches.addAll(v.map((e) {
                          return e;
                        }));
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff024D92),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: storeType == StoreType.some,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                constraints: BoxConstraints(
                  minHeight: 50,
                  minWidth: double.infinity,
                ),
                child: Wrap(
                  children: [
                    for (var branch in branches)
                      _BranchCard(
                        branch: branch.branchName,
                        onDelete: () {
                          branches.remove(branch);
                          setState(() {});
                        },
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  const _BranchCard({
    required this.branch,
    required this.onDelete,
  });

  final Function() onDelete;
  final String branch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDelete,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                branch,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Color(0xff024D92), fontSize: 16),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.cancel,
                color: Color(0xff024D92),
              )
            ],
          ),
        ),
      ),
    );
  }
}
