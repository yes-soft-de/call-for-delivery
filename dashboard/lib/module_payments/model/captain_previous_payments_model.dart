// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_subscriptions/response/receipts_response/e_payment.dart';
import 'package:c4d/module_subscriptions/response/receipts_response/receipts_response.dart';

class CaptainPreviousPaymentsModel extends DataModel {
  late num subscriptionCost;
  late List<EPaymentModel> ePayments;
  late bool hasTpPay;

  late CaptainPreviousPaymentsModel _model;

  CaptainPreviousPaymentsModel({
    required this.subscriptionCost,
    required this.ePayments,
    required this.hasTpPay,
  });

  CaptainPreviousPaymentsModel.withData(ReceiptsResponse response) {
    var data = response.data;

    _model = CaptainPreviousPaymentsModel(
      subscriptionCost: data?.subscriptionCost ?? 0,
      ePayments: _getEPaymentModel(data?.ePayments),
      hasTpPay: data?.hasToPay ?? false,
    );
  }

  List<EPaymentModel> _getEPaymentModel(List<EPayment?>? data) {
    List<EPaymentModel> list = [];

    data?.forEach(
      (element) {
        list.add(
          EPaymentModel(
            id: element?.id ?? 0,
            amount: element?.amount ?? 0,
            createdBy: element?.createdBy ?? 0,
            details: element?.details ?? '',
            paymentFor: element?.paymentFor ?? 0,
            paymentGetaway: element?.paymentGetaway ?? 0,
            paymentType: element?.paymentType ?? 0,
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
  late int id;
  late int paymentGetaway;
  late num amount;
  late int paymentFor;
  late String details;
  late DateTime createdAt;
  late int paymentType;
  late int createdBy;

  EPaymentModel({
    required this.id,
    required this.paymentGetaway,
    required this.amount,
    required this.paymentFor,
    required this.details,
    required this.createdAt,
    required this.paymentType,
    required this.createdBy,
  });
}
