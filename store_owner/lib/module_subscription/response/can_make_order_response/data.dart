class Data {
  bool? canCreateOrder;
  String? subscriptionStatus;

  Data({this.canCreateOrder, this.subscriptionStatus});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canCreateOrder: json['canCreateOrder'] as bool?,
        subscriptionStatus: json['subscriptionStatus'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'canCreateOrder': canCreateOrder,
        'subscriptionStatus': subscriptionStatus,
      };
}
