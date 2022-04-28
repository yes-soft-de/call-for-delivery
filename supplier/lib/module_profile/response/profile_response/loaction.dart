class GeoJson {
  num? lat;
  num? lon;
  GeoJson({
    this.lat,
    this.lon,
  });
  GeoJson.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}