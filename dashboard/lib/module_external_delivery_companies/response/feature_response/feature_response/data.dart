class Data {
  int? id;
  String? featureName;
  bool? featureStatus;

  Data({
    this.id,
    this.featureName,
    this.featureStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        featureName: json['featureName'] as String?,
        featureStatus: json['featureStatus'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'featureName': featureName,
        'featureStatus': featureStatus,
      };
}
