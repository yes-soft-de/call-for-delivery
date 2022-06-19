class SupplierCategoriesResponse {
  List<Data>? data;
  String? statusCode;
  SupplierCategoriesResponse({this.data});

  SupplierCategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? name;

  Data({this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
