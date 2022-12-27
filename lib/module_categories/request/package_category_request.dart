class PackageCategoryRequest {
  int? id;
  String? name;
  String? description;

  PackageCategoryRequest({this.id, this.name, this.description});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
