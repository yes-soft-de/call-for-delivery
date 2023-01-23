class UpdateRemainingCarsRequest {
  int? id;
  num? factor;
  String? operationType;

  UpdateRemainingCarsRequest({this.id, this.factor, this.operationType});

  factory UpdateRemainingCarsRequest.fromJson(Map<String, dynamic> json) {
    return UpdateRemainingCarsRequest(
      id: json['id'] as int?,
      factor: json['factor'] as num?,
      operationType: json['operationType'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'factor': factor,
        'operationType': operationType,
      };
}
