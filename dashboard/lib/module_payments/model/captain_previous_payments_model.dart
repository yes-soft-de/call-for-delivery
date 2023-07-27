// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_previous_payment_response/captain_previous_payment_response.dart';
import 'package:c4d/module_payments/response/captain_previous_payment_response/payment.dart';

class CaptainPreviousPaymentsModel extends DataModel {
  late num paymentsTotalAmount;
  late List<EPaymentModel> ePayments;
  late bool hasTpPay;

  late CaptainPreviousPaymentsModel _model;

  CaptainPreviousPaymentsModel({
    required this.paymentsTotalAmount,
    required this.ePayments,
    required this.hasTpPay,
  });

  CaptainPreviousPaymentsModel.withData(
      CaptainPreviousPaymentResponse response) {
    var data = response.data;

    _model = CaptainPreviousPaymentsModel(
      paymentsTotalAmount: data?.paymentsTotalAmount ?? 0,
      ePayments: _getEPaymentModel(data?.payments),
      hasTpPay: (data?.paymentsTotalAmount ?? 0) > 0,
    );
  }

  List<EPaymentModel> _getEPaymentModel(List<Payment?>? data) {
    List<EPaymentModel> list = [];

    data?.forEach(
      (element) {
        list.add(
          EPaymentModel(
            id: element?.id ?? 0,
            amount: element?.amount ?? 0,
            paymentGetaway: element?.paymentGetaway ?? 0,
            createdAt: element?.createdAt ?? DateTime(2000),
          ),
        );
      },
    );

    return list;
  }

  CaptainPreviousPaymentsModel get data => _model;
}

class EPaymentModel {
  int id;
  double amount;
  DateTime createdAt;
  int paymentGetaway;

  EPaymentModel({
    required this.id,
    required this.paymentGetaway,
    required this.amount,
    required this.createdAt,
  });
}
