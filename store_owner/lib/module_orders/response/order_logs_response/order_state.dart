class OrderState {
  String? completionTime;
  String? currentStage;

  OrderState({this.completionTime, this.currentStage});

  factory OrderState.fromJson(Map<String, dynamic> json) => OrderState(
        completionTime: json['completionTime'] as String?,
        currentStage: json['currentStage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'completionTime': completionTime,
        'currentStage': currentStage,
      };
}
