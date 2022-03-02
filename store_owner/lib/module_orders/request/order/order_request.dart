import 'package:c4d/module_orders/response/orders/orders_response.dart';

class CreateOrderRequest {
  int? fromBranch;
  String? note;
  String? payment;
  String? recipientName;
  String? recipientPhone;
  String? date;
  GeoJson? destination;
  num? orderCost;
  String? detail;
  String? image;
  CreateOrderRequest(
      {this.fromBranch,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.date,
      this.destination,
      this.orderCost,
      this.image,
      this.detail});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch'] = this.fromBranch;
    if (this.destination != null) {
      data['destination'] = this.destination?.toJson();
    }
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['deliveryDate'] = this.date;
    data['image'] = this.image;
    data['orderCost'] = this.orderCost;
    data['detail'] = this.detail ?? '';

    return data;
  }
}
