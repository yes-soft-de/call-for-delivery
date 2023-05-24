class AddExtraDistanceRequest {
  int? id;
  String? adminNote;
  Destination? destination;
  double? additionalDistance;

  AddExtraDistanceRequest({
    this.id,
    this.adminNote,
    this.destination,
    this.additionalDistance,
  });

  factory AddExtraDistanceRequest.fromJson(Map<String, dynamic> json) {
    return AddExtraDistanceRequest(
      id: json['orderId'] as int?,
      adminNote:
          json['adminNote'] as String?,
      destination: json['destination'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['orderId'] = id;
    map['adminNote'] = adminNote;
    map['storeBranchToClientDistanceAdditionExplanation'] = '';
    if (destination != null) {
      map['destination'] = destination;
    }
    if (additionalDistance != null) {
      map['additionalDistance'] = additionalDistance;
    }
    return map;
  }
}

// Destination class contains lat and lon with double type .
class Destination {
  double? lat;
  double? lon;

  Destination({this.lat, this.lon});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        lat: json['lat'] is String
            ? double.tryParse(json['lat'] ?? '0')
            : json['lat'] as double?,
        lon: json['lon'] is String
            ? double.tryParse(json['lon'] ?? '0')
            : json['lon'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
