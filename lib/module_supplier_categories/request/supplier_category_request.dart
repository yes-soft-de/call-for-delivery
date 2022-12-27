class SupplierCategoryRequest {
  int? id;
  String? name;
  String? description;
  bool? status;
  String? image;

  SupplierCategoryRequest(
      {this.id, this.name, this.description, this.image, this.status});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    map['status'] = status;
    map['image'] = image;
    return map;
  }
}
