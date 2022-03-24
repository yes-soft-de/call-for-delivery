class UpdateOrderRequest {
  int? id;
  String? state;
  String? distance;
  double? orderCost;
  String? storeID;
  UpdateOrderRequest(
      {required this.id,
      required this.state,
      this.distance,
       this.orderCost,this.storeID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id.toString();
    data['state'] = this.state;
    if (distance != null) {
      data['kilometer'] = double.tryParse(this.distance ?? '0');
    }
    if (orderCost != null) {
      data['orderCost'] = orderCost;
    }
    return data;
  }
}
