import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/receipts_model.dart';
import 'package:c4d/module_subscriptions/request/payment/paymnet_status_request.dart'
    as p;
import 'package:c4d/module_subscriptions/request/receiptsRequest.dart';
import 'package:c4d/module_subscriptions/ui/screen/receipts_screen.dart';
import 'package:c4d/module_subscriptions/ui/widget/payment_card.dart';
import 'package:c4d/module_subscriptions/ui/widget/payment_widget.dart';
import 'package:c4d/module_subscriptions/ui/widget/select_date_bar_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptsStateLoaded extends States {
  final ReceiptsScreenState screenState;
  final ReceiptsModel model;
  final ReceiptsRequest request;

  ReceiptsStateLoaded(this.screenState, this.model, this.request)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.receipts),
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
                      return Dialog(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      S.current.areYouSureAboutMakePayment,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(height: 30),
                                    Text(S.current
                                        .youCantEditOrDeleteAfterConfirm),
                                    SizedBox(height: 30),
                                    Center(
                                      child: ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Text(S.current.confirm),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          screenState.makePayment(
                                            p.PaymentStatusRequest(
                                              storeOwnerProfile: screenState
                                                  .storeProfileModel.id,
                                              status:
                                                  p.PaymentStatus.paidSuccess,
                                              amount: model.subscriptionCost,
                                              paymentFor: p.PaymentFor
                                                  .unifiedSubscription,
                                              paymentGetaway:
                                                  p.PaymentGetaway.manual,
                                              paymentType: p.PaymentType
                                                  .realPaymentByAdmin,
                                            ),
                                            () {
                                              screenState.getReceipts(request);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
            Text(
              S.current.paymentsRecords,
              style: Theme.of(context).textTheme.bodyLarge,
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
                      screenState.getReceipts(
                        request.copyWith(fromDate: selectedDate),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: SelectDataBar(
                    onSelected: (selectedDate) {
                      screenState.getReceipts(
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: model.ePayments.length,
              itemBuilder: (context, index) {
                var payment = model.ePayments[index];
                return PaymentCard(
                  paymentValue: S.current
                      .paymentValueRiyal(payment.amount.toStringAsFixed(2)),
                  paymentType: PaymentType.fromInt(payment.paymentGetaway),
                  date:
                      '${DateFormat('yyyy/MM/dd', 'en').format(payment.createdAt)}',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
