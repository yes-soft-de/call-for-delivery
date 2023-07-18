// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profit_model.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/my_profits_screen.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';

Color get blue => const Color(0xff2C5085);
Color get lightBlue => const Color(0xffF2FAFD);
Color get transparentBlue => const Color(0xff5E789D);

class MyProfitsStateLoaded extends States {
  final MyProfitsScreenState screenState;
  final MyProfitModel model;

  MyProfitsStateLoaded(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.today,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: blue,
                ),
          ),
          const SizedBox(height: 10),
          _FirstCard(model),
          const SizedBox(height: 30),
          _SecondCard(
            model: model,
            onDuesClaimButtonPressed: () {
              // TODO: call the dues claim api
            },
          ),
          const SizedBox(height: 40),
          _CustomButton(
            title: S.current.historyOfPreviousPayments,
            onPressed: () {
              Navigator.pushNamed(context, PlanRoutes.PAYMENT_HISTORY);
            },
          ),
          const SizedBox(height: 20),
          _CustomButton(
            title: S.current.planDetails,
            onPressed: () {
              // TODO: navigate to plan ditailes screen
            },
          ),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const _CustomButton({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}

class _SecondCard extends StatelessWidget {
  final MyProfitModel model;
  final void Function() onDuesClaimButtonPressed;

  const _SecondCard({
    required this.model,
    required this.onDuesClaimButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  S.current.yourFinancialDues,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(width: 4),
                Text(
                  S.current.sinceTheLastPayment,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: _TransparentCard(
                    title: S.current.ordersTotal,
                    value: model.orderCountSinceLastPayment.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: _TransparentCard(
                    title: S.current.saudiRiyal,
                    value: model.profitSinceLastPayment.toStringAsFixed(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmDialog(
                    context,
                    onDuesClaimButtonPressed,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: transparentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.current.duesClaim),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, void Function() onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.areYouSureToAskTheAdministrationToPay,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: blue),
                ),
                const SizedBox(height: 80),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(S.current.confirm),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TransparentCard extends StatelessWidget {
  final String title;
  final String value;

  const _TransparentCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: transparentBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        child: Column(
          children: [
            const Row(),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
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

  const _FirstCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              ImageAsset.CASH_PERSON,
              width: 95,
            ),
            _CardDetail(
              title: S.current.orders,
              value: model.ordersCountToday,
            ),
            _CardDetail(
              title: S.current.theProfitRiyal,
              value: model.profitToday,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String title;
  final num value;

  const _CardDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: blue, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: blue,
              ),
        ),
      ],
    );
  }
}
