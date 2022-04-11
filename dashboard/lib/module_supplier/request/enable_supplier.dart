class EnableSupplierRequest {
  int? id;
  String? status;

  EnableSupplierRequest({this.id, this.status});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    return map;
  }
}
