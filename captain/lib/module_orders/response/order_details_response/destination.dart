class Destination {
  num? lat;
  num? lon;
  String? link;

  Destination({this.lat, this.lon, this.link});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        lat: json['lat'] as dynamic,
        lon: json['lon'] as dynamic,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'link': link,
      };
}
