class NewDestination {
  double? lat;
  double? lon;

  NewDestination({this.lat, this.lon});

  factory NewDestination.fromJson(Map<String, dynamic> json) {
    return NewDestination(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
