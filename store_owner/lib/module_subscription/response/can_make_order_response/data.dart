class Data {
  bool? canCreateOrder;
  String? subscriptionStatus;
  String? percentageOfOrdersConsumed;

  Data(
      {this.canCreateOrder,
      this.subscriptionStatus,
      this.percentageOfOrdersConsumed});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        canCreateOrder: json['canCreateOrder'] as bool?,
        subscriptionStatus: json['subscriptionStatus'] as String?,
        percentageOfOrdersConsumed:
            json['percentageOfOrdersConsumed'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'canCreateOrder': canCreateOrder,
        'subscriptionStatus': subscriptionStatus,
      };
}
