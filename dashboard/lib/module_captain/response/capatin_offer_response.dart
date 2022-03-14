import 'package:c4d/utils/logger/logger.dart';

class CaptainOfferResponse {
  CaptainOfferResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  CaptainOfferResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(CaptainOfferData.fromJson(v));
        });
      }
    } catch (e) {
      statusCode = '-1';
      Logger().error(
          'Captain Offer Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<CaptainOfferData>? data;
}

class CaptainOfferData {
  int? id;
  String? status;
  num? price;
  num? carCount;
  num? expired;

  CaptainOfferData({
    this.id,
    this.expired,this.price,this.carCount,this.status
  });

  CaptainOfferData.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    price = json['price'];
    carCount = json['carCount'];
    expired = json['expired'];
  }

}
