class AddExtraDistanceRequest {
  int? id;
  String? conflictNote;
  Destination? destination;
  String? additionalDistance;

  AddExtraDistanceRequest({
    this.id,
    this.conflictNote,
    this.destination,
    this.additionalDistance,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['orderId'] = id;
    map['conflictNote'] = conflictNote;
    if (destination != null) {
      map['destination'] = destination?.toJson();
      map['proposedDestinationOrDistance'] = '${destination?.lat ?? 0},${destination?.lon ?? 0}';
    }
    if (additionalDistance != null) {
      map['additionalDistance'] = additionalDistance;
      map['proposedDestinationOrDistance'] = additionalDistance;
    }
    return map;
  }
}

class Destination {
  double? lat;
  double? lon;

  Destination({
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }
}
