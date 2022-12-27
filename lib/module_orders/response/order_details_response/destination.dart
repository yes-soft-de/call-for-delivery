class Destination {
  num? lat;
  num? lon;
  String? link;

  Destination({this.lat, this.lon, this.link});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        lat: json['lat'] as num?,
        lon: json['lon'] as num?,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'link': link,
      };
}
