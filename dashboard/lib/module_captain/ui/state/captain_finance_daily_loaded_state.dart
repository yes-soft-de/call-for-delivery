import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_finance_daily_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class CaptainFinanceDailyLoadedState extends States {
  final CaptainFinanceDailyScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainFinanceDailyModel>? model;
  CaptainFinanceDailyLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model?.length,
            itemBuilder: (context, index) {
              return Padding(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: ClipOval(
                                  //   borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: CustomNetworkImage(
                                      imageSource: model?[index].image ?? '',
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
                                  model?[index].captainName ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                                Text(
                                  model?[index].id.toString() ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                              ],
                            )
                          ],
                        ),
                        // verticalTile(context,
                        //     title: model?[index].captainName ?? '',
                        //     subtitle: model?[index].id.toString() ?? ''),
                        divider(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            verticalTile(context,
                                title: S.current.amount_daily_captain,
                                subtitle:
                                    model?[index].amount.toString() ?? ''),
                            verticalTile(context,
                                title: S.current.had_amount_daily_captain,
                                subtitle:
                                    model?[index].alreadyHadAmount.toString() ??
                                        ''),
                          ],
                        ),
                        // divider
                        divider(context),
                        // order date & create date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            verticalTile(context,
                                title: S.current.payments,
                                subtitle: model?[index].isPaid == 176
                                    ? S.current.unpaidCaptainFinanceDaily
                                    : model?[index].isPaid == 177
                                        ? S.current.paidCaptainFinanceDaily
                                        : model?[index].isPaid == 179
                                            ? S.current
                                                .paidPartiallyCaptainFinanceDaily
                                            : model?[index].isPaid == 182
                                                ? S.current.overPaid
                                                : 'unknown'),
                            verticalTile(context,
                                title: S.current.bonusCaptainDaily,
                                subtitle: model?[index].bonus.toString() ?? '')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
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
        Text(subtitle,
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
