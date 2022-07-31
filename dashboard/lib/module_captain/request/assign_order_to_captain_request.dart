class AssignOrderToCaptainRequest {
  int? id;
  int? orderId;

  AssignOrderToCaptainRequest({this.id, this.orderId});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['orderId'] = orderId;
    return map;
  }
}
