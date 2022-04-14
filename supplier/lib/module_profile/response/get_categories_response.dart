class GetCategoriesResponse {
  String? statusCode;
  String? msg;
  List<SupplierCategory>? data;

  GetCategoriesResponse(
      {required this.statusCode, required this.msg, required this.data});

  GetCategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <SupplierCategory>[];
      json['Data'].forEach((v) {
        data?.add(new SupplierCategory.fromJson(v));
      });
    }
  }


}
class SupplierCategory{
  int? id;
  String? name;

  SupplierCategory({this.id, this.name});

  SupplierCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}