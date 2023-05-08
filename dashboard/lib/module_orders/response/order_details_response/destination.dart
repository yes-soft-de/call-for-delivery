class Destination {
  num? lat;
  num? lon;
  String? link;

  Destination({this.lat, this.lon, this.link});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        lat: json['lat'] is num? ? json['lat'] : num.tryParse(json['lat']),
        lon: json['lon'] is num? ? json['lon'] : num.tryParse(json['lon']),
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'link': link,
      };
}
