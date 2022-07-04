class UpdateOrderRequest {
  int? id;
  String? state;
  String? distance;
  double? orderCost;
  String? storeID;
  String? paymentNote;
  int? paid;
  UpdateOrderRequest(
      {required this.id,
      required this.state,
      this.distance,
      this.orderCost,
      this.storeID,
      this.paymentNote,
      this.paid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id.toString();
    data['state'] = this.state;
    if (distance != null && distance != '') {
      data['kilometer'] = double.tryParse(this.distance ?? '0');
    }
    if (orderCost != null) {
      data['captainOrderCost'] = orderCost;
    }
    if (paid != null) {
      data['paidToProvider'] = paid;
    }
    if (paymentNote != null && paymentNote != '') {
      data['noteCaptainOrderCost'] = paymentNote;
    }
    return data;
  }
}
