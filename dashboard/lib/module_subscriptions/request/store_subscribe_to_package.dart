class StoreSubscribeToPackageRequest {
  int? storeOwnerProfileId;
  int? packageId;

  StoreSubscribeToPackageRequest({this.storeOwnerProfileId, this.packageId});

  factory StoreSubscribeToPackageRequest.fromJson(Map<String, dynamic> json) {
    return StoreSubscribeToPackageRequest(
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
        packageId: json['packageId'] as int?);
  }

  Map<String, dynamic> toJson() => {
        'storeProfileId': storeOwnerProfileId,
        'packageId': packageId,
      };
}
