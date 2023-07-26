import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_dues_model.dart';
import 'package:c4d/module_payments/ui/screen/captain_payment_screen.dart';
import 'package:c4d/module_payments/ui/widget/add_payment_to_captain_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color _primary = Color(0xff7E7ED4);
Color _blue = Color(0xff335689);
Color _orange = Color(0xffF5930A);
Color _white = Colors.white;

class CaptainPaymentStateLoaded extends States {
  final CaptainPaymentScreenState screenState;
  final CaptainPaymentModel model;

  CaptainPaymentStateLoaded(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            _DuesCard(
              model: model,
            ),
            SizedBox(height: 30),
            _CustomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddPaymentToCaptainDialog(
                      onConfirmed: (request) {
                        screenState.addPayment(request);
                      },
                    );
                  },
                );
              },
              title: S.current.pay,
              backgroundColor: _orange,
            ),
            SizedBox(height: 15),
            _CustomButton(
              onPressed: () {
                // TODO: navigate to previous payment screen
              },
              title: S.current.showPreviousPayments,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String title;
  late final Color _backgroundColor;
  final void Function() onPressed;

  _CustomButton({
    required this.title,
    required this.onPressed,
    Color? backgroundColor,
  }) {
    if (backgroundColor != null) {
      _backgroundColor = backgroundColor;
    } else {
      _backgroundColor = _primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.75,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: _backgroundColor),
        onPressed: onPressed,
        child: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            color: _white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _DuesCard extends StatelessWidget {
  const _DuesCard({
    required this.model,
  });

  final CaptainPaymentModel model;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      color: _primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            // title
            Row(
              children: [
                Text(
                  S.current.FinancialDues,
                  style: textTheme.titleMedium?.copyWith(
                    color: _white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '(${S.current.sinceLastPaymentUntilNow})',
                  style: textTheme.bodySmall?.copyWith(
                    color: _white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // dues card
            Card(
              color: _white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.duesSinceLastPayment.toStringAsFixed(2),
                      style: textTheme.titleLarge?.copyWith(
                        color: _blue,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      S.current.saudiRiyal,
                      style: textTheme.bodyMedium?.copyWith(
                        color: _blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _RowDetailCard(
              title: S.current.unpaidAmountsFromCashToStores,
              value: S.current.valueRiyal(
                model.unpaidAmountsFromCashToStores.toStringAsFixed(2),
              ),
            ),
            _RowDetailCard(
              title: S.current.profitsFromOrders,
              value: S.current.valueRiyal(
                model.profitsFromOrders.toStringAsFixed(2),
              ),
            ),
            _RowDetailCard(
              title: S.current.lastPayment,
              centerValue: S.current.valueRiyal(
                model.lastPayment.toStringAsFixed(2),
              ),
              value:
                  DateFormat('yyy-MM-dd', 'en').format(model.lastPaymentDate),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowDetailCard extends StatelessWidget {
  final String title;
  final String value;
  final String? centerValue;

  const _RowDetailCard(
      {required this.title, required this.value, this.centerValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: _blue),
              ),
              Text(
                centerValue ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: _blue),
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: _blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
