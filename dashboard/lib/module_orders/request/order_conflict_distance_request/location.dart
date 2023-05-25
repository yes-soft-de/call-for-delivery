class Location {
  String? countryCode;
  double? latitude;
  double? longitude;
  String? comments;

  Location({
    this.countryCode,
    this.latitude,
    this.longitude,
    this.comments,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        countryCode: json['country_code'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        comments: json['comments'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'latitude': latitude,
        'longitude': longitude,
        'comments': comments,
      };
}
