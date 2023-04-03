class Location {
  String? countryCode;
  num? latitude;
  num? longitude;
  String? comments;

  Location({
    this.countryCode,
    this.latitude,
    this.longitude,
    this.comments,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        countryCode: json['country_code'] as String?,
        latitude: json['latitude'] as num?,
        longitude: json['longitude'] as num?,
        comments: json['comments'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'latitude': latitude,
        'longitude': longitude,
        'comments': comments,
      };
}
