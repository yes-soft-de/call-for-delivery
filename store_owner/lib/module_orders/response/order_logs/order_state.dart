class OrderState {
  String? completionTime;
  String? currentStage;
  String? deliveredTime;

  OrderState({this.completionTime, this.currentStage, this.deliveredTime});

  factory OrderState.fromJson(Map<String, dynamic> json) => OrderState(
        completionTime: json['completionTime'] as String?,
        currentStage: json['currentStage'] as String?,
        deliveredTime: json['deliveredTime'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'completionTime': completionTime,
        'currentStage': currentStage,
        'deliveredTime': deliveredTime,
      };
}
