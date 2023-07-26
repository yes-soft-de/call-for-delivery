// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';

class CaptainPaymentModel extends DataModel {
  num duesSinceLastPayment;
  num unpaidAmountsFromCashToStores;
  num profitsFromOrders;
  num lastPayment;
  DateTime lastPaymentDate;
  
  CaptainPaymentModel({
    required this.duesSinceLastPayment,
    required this.unpaidAmountsFromCashToStores,
    required this.profitsFromOrders,
    required this.lastPayment,
    required this.lastPaymentDate,
  });
}
