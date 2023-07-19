// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profit_model.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/plan_details_screen.dart';
import 'package:flutter/material.dart';

Color get _blue => const Color(0xff2C5085);
Color get _grey => const Color(0xff646363);
Color get _white => Colors.white;
Color get _lightBlue => const Color(0xffF2FAFD);
Color get _lightBlue2 => const Color(0xff00A1C5);

class PlanDetailsStateLoaded extends States {
  final PlanDetailsScreenState screenState;
  final MyProfitModel model;

  PlanDetailsStateLoaded(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _FirstCard(
              model: model,
            ),
            const SizedBox(height: 20),
            _CalculateEarningCard(model: model),
            const SizedBox(height: 20),
            _PlanDetailsCard(
              model: model,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanDetailsCard extends StatelessWidget {
  final MyProfitModel model;

  const _PlanDetailsCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            _DetailRow(
              icon: Icons.shopping_cart_outlined,
              text: S.current.openOrderPrice,
              value: model.openOrderCost.toString(),
            ),
            _DetailRow(
              icon: Icons.local_shipping_outlined,
              text: S.current.ordersFromTo(
                model.firstSliceFromLimit.toString(),
                model.firstSliceToLimit.toString(),
              ),
              value: model.firstSliceCost.toString(),
            ),
            _DetailRow(
              icon: Icons.local_shipping_outlined,
              text: S.current.everyOneKMOrdersGreaterThenTo(
                model.secondSliceFromLimit.toString(),
                model.secondSliceToLimit.toString(),
              ),
              value: model.secondSliceOneKilometerCost.toString(),
            ),
            _DetailRow(
              icon: Icons.local_shipping_outlined,
              text: S.current.everyOneKMOrdersFromAndMore(
                  model.thirdSliceFromLimit.toString()),
              value: model.thirdSliceOneKilometerCost.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: _grey,
            size: 30,
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _grey,
                        ),
                  ),
                  Divider(
                    color: _grey,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Card(
              color: _white,
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    S.current.valueRiyal(value),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: _grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalculateEarningCard extends StatelessWidget {
  final MyProfitModel model;

  final TextEditingController _kilometerTextController =
      TextEditingController();
  final ValueNotifier<num> _calculatedProfits = ValueNotifier(0);

  _CalculateEarningCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _blue,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Row(),
            Text(
              S.current.calculateYourDues,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    color: _white,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              S.current.enterTheNumberOfKilometer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _white,
                  ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: 50,
              child: Card(
                color: _white,
                child: TextField(
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _blue,
                      ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      _calculatedProfits.value = 0;
                    } else {
                      var kilometer = num.tryParse(value);
                      _calculatedProfits.value = getIt<PlanService>()
                          .calculateProfit(model, kilometer ?? 0);
                    }
                  },
                  controller: _kilometerTextController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.current.theProfits,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _white,
                  ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: 50,
              child: Card(
                color: _white,
                child: Center(
                  child: ValueListenableBuilder<num>(
                    valueListenable: _calculatedProfits,
                    builder: (context, value, child) {
                      return Text(
                        value.toStringAsFixed(2),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: _blue,
                                ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstCard extends StatelessWidget {
  final MyProfitModel model;
  const _FirstCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(),
            Text(
              // TODO: update this value
              S.current.planDetailsDescription(10.toString()),
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 2),
            ),
            Text(
              S.current.theHigherDeliveryDistance,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: _lightBlue2),
            ),
          ],
        ),
      ),
    );
  }
}
