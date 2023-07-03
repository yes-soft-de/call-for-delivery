class Data {
  bool? canCreateOrder;
  String? subscriptionStatus;
  String? percentageOfOrdersConsumed;
  String? packageName;
  int? packageType;
  bool? hasToPay;
  bool? firstTimeSubscriptionWithUniformPackage;

  Data({
    this.canCreateOrder,
    this.subscriptionStatus,
    this.percentageOfOrdersConsumed,
    this.packageType,
    this.hasToPay,
    this.firstTimeSubscriptionWithUniformPackage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canCreateOrder: json['canCreateOrder'] as bool?,
        subscriptionStatus: json['subscriptionStatus'] as String?,
        percentageOfOrdersConsumed:
            json['percentageOfOrdersConsumed'] as String?,
        packageType: json['packageType'] as int?,
        hasToPay: json['hasToPay'] as bool?,
        firstTimeSubscriptionWithUniformPackage: json['firstTimeSubscriptionWithUniformPackage'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'canCreateOrder': canCreateOrder,
        'subscriptionStatus': subscriptionStatus,
      };
}
