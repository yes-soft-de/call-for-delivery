import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_previous_payments_model.dart';
import 'package:c4d/module_payments/request/captain_previous_payments_request.dart';
import 'package:c4d/module_payments/ui/screen/captain_previous_payments_screen.dart';
import 'package:c4d/module_payments/ui/widget/add_payment_to_captain_dialog.dart';
import 'package:c4d/module_payments/ui/widget/payment_card.dart' as p;
import 'package:c4d/module_payments/ui/widget/payment_widget.dart';
import 'package:c4d/module_payments/ui/widget/select_date_bar_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaptainPreviousPaymentsStateLoaded extends States {
  final CaptainPreviousPaymentsScreenState screenState;
  final CaptainPreviousPaymentsModel model;
  final CaptainPreviousPaymentRequest request;

  CaptainPreviousPaymentsStateLoaded(this.screenState, this.model, this.request)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.previousPayments),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PaymentWidget(
              model: model,
              onPressed: () {
                if (model.hasTpPay) {
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
                } else {
                  CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.thereIsNoPaymentToMade,
                  );
                }
              },
            ),
            SizedBox(height: 10),
            // date pickers
            Row(
              children: [
                Flexible(
                  child: SelectDataBar(
                    title: S.current.from,
                    selectedDate: request.fromDate,
                    onSelected: (selectedDate) {
                      screenState.filterCaptainPayment(
                        request.copyWith(fromDate: selectedDate),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: SelectDataBar(
                    onSelected: (selectedDate) {
                      screenState.filterCaptainPayment(
                        request.copyWith(toDate: selectedDate),
                      );
                    },
                    selectedDate: request.toDate,
                    title: S.current.to,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.ePayments.length,
                itemBuilder: (context, index) {
                  var payment = model.ePayments[index];
                  return p.PaymentCard(
                    paymentValue: S.current
                        .paymentValueRiyal(payment.amount.toStringAsFixed(2)),
                    paymentType: p.PaymentType.fromInt(payment.paymentGetaway),
                    date:
                        '${DateFormat('yyyy/MM/dd', 'en').format(payment.createdAt)}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
