class CreateTestOrderRequest {
  int? storeOwner;
  int? branch;
  bool? orderIsMain;
  int? ordersCount;

  CreateTestOrderRequest({
    this.storeOwner,
    this.branch,
    this.orderIsMain,
    this.ordersCount,
  });

  factory CreateTestOrderRequest.fromJson(Map<String, dynamic> json) {
    return CreateTestOrderRequest(
      storeOwner: json['storeOwner'] as int?,
      branch: json['branch'] as int?,
      orderIsMain: json['orderIsMain'] as bool?,
      ordersCount: json['ordersCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'storeOwner': storeOwner,
        'branch': branch,
        'orderIsMain': orderIsMain,
        'ordersCount': ordersCount,
      };
}
