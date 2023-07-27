// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddExtraDistanceRequest {
  int? id;
  String? adminNote;
  Destination? destination;
  double? additionalDistance;

  AddExtraDistanceRequest({
    required this.id,
    this.adminNote,
    this.destination,
    this.additionalDistance,
  });

  factory AddExtraDistanceRequest.fromJson(Map<String, dynamic> json) {
    return AddExtraDistanceRequest(
      id: json['orderId'] as int?,
      adminNote: json['adminNote'] as String?,
      destination: json['destination'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['orderId'] = id;
    map['adminNote'] = adminNote ?? '';
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
  num? lat;
  num? lon;

  Destination({this.lat, this.lon});

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };

  @override
  String toString() => '$lat,$lon';
}
