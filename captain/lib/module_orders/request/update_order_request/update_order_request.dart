class UpdateOrderRequest {
  int? id;
  String? state;
  String? distance;
  double? orderCost;
  String? storeID;
  String? paymentNote;
  int? captainToStoreBranchDistance;
  int? paid;

  UpdateOrderRequest(
      {required this.id,
      required this.state,
      this.distance,
      this.orderCost,
      this.storeID,
      this.paymentNote,
      this.captainToStoreBranchDistance,
      this.paid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['state'] = state;
    if (distance != null) {
      data['kilometer'] = double.tryParse(distance ?? '0');
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
    if (captainToStoreBranchDistance != null) {
      data['captainToStoreBranchDistance'] = captainToStoreBranchDistance;
    }
    return data;
  }
}
