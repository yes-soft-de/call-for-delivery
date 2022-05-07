class FilterSupplierRequest {
  bool status;

  FilterSupplierRequest(this.status);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }
}
