class Data {
  int? id;
  int? subscriptionCostLimit;

  Data({
    this.id,
    this.subscriptionCostLimit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        subscriptionCostLimit: json['subscriptionCostLimit'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subscriptionCostLimit': subscriptionCostLimit,
      };
}
