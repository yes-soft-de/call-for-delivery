import 'package:c4d/consts/urls.dart';

class CaptainPaymentRequest {
  String? fromDate;
  String? toDate;

  CaptainPaymentRequest.empty();

  CaptainPaymentRequest({
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
