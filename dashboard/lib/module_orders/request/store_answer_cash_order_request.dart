import 'package:c4d/generated/l10n.dart';

class StoreAnswerForOrderCashRequest {
  int? id;
  int? isCashPaymentConfirmedByStore;
  StoreAnswerForOrderCashRequest({this.id, this.isCashPaymentConfirmedByStore});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isCashPaymentConfirmedByStore'] = isCashPaymentConfirmedByStore;
    return data;
  }
}
