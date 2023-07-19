// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/response/payment_history_response/payment.dart';
import 'package:c4d/module_plan/response/payment_history_response/payment_history_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class PaymentHistoryModel extends DataModel {
  late int paymentsTotalAmount;
  late List<EPaymentModel> payments;

  late PaymentHistoryModel _model;

  PaymentHistoryModel({
    required this.paymentsTotalAmount,
    required this.payments,
  });

  PaymentHistoryModel.withData(PaymentHistoryResponse response) {
    var data = response.data;

    _model = PaymentHistoryModel(
      paymentsTotalAmount: data?.paymentsTotalAmount ?? 0,
      payments: _getEPaymentModel(data?.payments),
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
            createdAt: DateHelper.convert(element?.createdAt?.timestamp),
          ),
        );
      },
    );

    return list;
  }

  PaymentHistoryModel get data => _model;
}

class EPaymentModel {
  late int id;
  late int paymentGetaway;
  late num amount;
  late DateTime createdAt;

  EPaymentModel({
    required this.id,
    required this.paymentGetaway,
    required this.amount,
    required this.createdAt,
  });
}
