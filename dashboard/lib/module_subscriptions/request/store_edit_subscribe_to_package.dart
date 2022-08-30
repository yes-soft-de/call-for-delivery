class EditStoreSubscribeToPackageRequest {
  int? id;
  int? packageId;

  EditStoreSubscribeToPackageRequest({this.id, this.packageId});

  factory EditStoreSubscribeToPackageRequest.fromJson(
      Map<String, dynamic> json) {
    return EditStoreSubscribeToPackageRequest(
        id: json['id'] as int?, packageId: json['package'] as int?);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'package': packageId,
      };
}
