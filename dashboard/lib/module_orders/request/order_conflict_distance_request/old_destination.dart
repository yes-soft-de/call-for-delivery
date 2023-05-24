class OldDestination {
  double? lat;
  double? lon;
  String? link;

  OldDestination({this.lat, this.lon, this.link});

  factory OldDestination.fromJson(Map<String, dynamic> json) {
    return OldDestination(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      link: json['link'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'link': link,
      };
}
