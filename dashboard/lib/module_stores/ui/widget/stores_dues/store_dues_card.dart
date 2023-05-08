import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_dues/stores_dues_model.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class StoreDuesCard extends StatelessWidget {
  final StoresDuesModel? model;
  final String? isPaid;

  const StoreDuesCard({Key? key, required this.model, required this.isPaid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StoresRoutes.STORE_DUES_SCREEN,
          arguments: [
            model?.storeOwnerProfileId,
            model?.storeOwnerName,
            isPaid
          ],
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.primary.withOpacity(0.9),
                Theme.of(context).colorScheme.primary.withOpacity(0.93),
                Theme.of(context).colorScheme.primary.withOpacity(0.95),
                Theme.of(context).colorScheme.primary,
              ])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: ClipOval(
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CustomNetworkImage(
                              imageSource: model?.image ?? '',
                              width: double.maxFinite,
                              height: double.maxFinite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          model?.storeOwnerName ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                        Text(
                          ' (${model?.storeOwnerProfileId.toString()}) ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                      ],
                    )
                  ],
                ),
                divider(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(context,
                        title: S.current.dues,
                        subtitle:
                            model?.amountSum.toString() ?? '' + S.current.sar),
                    verticalTile(context,
                        title: _getToBePaidFieldTitle(model?.toBePaid ?? 0),
                        subtitle: '${model?.toBePaid?.abs().toString() ?? ''}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getToBePaidFieldTitle(num toBePaid) {
    if (toBePaid < 0) {
      return S.current.prePayments;
    }
    return S.current.leftToPay;
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.background),
        ),
        Text(subtitle + ' ${S.current.sar}',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget divider(context) {
    Color dividerColor = Theme.of(context).colorScheme.background;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}
