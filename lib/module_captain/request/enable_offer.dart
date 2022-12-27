class EnableOfferRequest {
  int? id;
  String? status;

  EnableOfferRequest({this.id, this.status});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    return map;
  }
}
