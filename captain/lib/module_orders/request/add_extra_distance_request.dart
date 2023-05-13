class AddExtraDistanceRequest {
  int? id;
  String? storeBranchToClientDistanceAdditionExplanation;
  Destination? destination;
  double? additionalDistance;

  AddExtraDistanceRequest({
    this.id,
    this.storeBranchToClientDistanceAdditionExplanation,
    this.destination,
    this.additionalDistance,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['storeBranchToClientDistanceAdditionExplanation'] =
        storeBranchToClientDistanceAdditionExplanation;
    if (destination != null) {
      map['destination'] = destination?.toJson();
    }
    if (additionalDistance != null) {
      map['additionalDistance'] = additionalDistance;
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
