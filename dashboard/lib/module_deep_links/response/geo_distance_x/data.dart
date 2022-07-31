class Data {
  String? distance;

  Data({this.distance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        distance: json['distance'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
      };
}
