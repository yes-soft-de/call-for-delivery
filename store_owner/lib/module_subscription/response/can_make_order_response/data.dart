class Data {
  bool? canCreateOrder;
  String? subscriptionStatus;
  String? percentageOfOrdersConsumed;
  String? packageName;
  int? packageType;

  Data({
    this.canCreateOrder,
    this.subscriptionStatus,
    this.percentageOfOrdersConsumed,
    this.packageType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canCreateOrder: json['canCreateOrder'] as bool?,
        subscriptionStatus: json['subscriptionStatus'] as String?,
        percentageOfOrdersConsumed:
            json['percentageOfOrdersConsumed'] as String?,
        packageType: json['packageType'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'canCreateOrder': canCreateOrder,
        'subscriptionStatus': subscriptionStatus,
      };
}
