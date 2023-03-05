class AddExtraDistanceRequest {
  int? id;
  String? storeBranchToClientDistanceAdditionExplanation;
  Map? destination;
  double? additionalDistance;

  AddExtraDistanceRequest({
    this.id,
    this.storeBranchToClientDistanceAdditionExplanation,
    this.destination,
    this.additionalDistance,
  });

  factory AddExtraDistanceRequest.fromJson(Map<String, dynamic> json) {
    return AddExtraDistanceRequest(
      id: json['orderId'] as int?,
      storeBranchToClientDistanceAdditionExplanation:
          json['storeBranchToClientDistanceAdditionExplanation'] as String?,
      destination: json['destination'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['orderId'] = id;
    map['storeBranchToClientDistanceAdditionExplanation'] =
        storeBranchToClientDistanceAdditionExplanation;
    if (destination != null) {
      map['destination'] = destination;
    }
    if (additionalDistance != null) {
      map['additionalDistance'] = additionalDistance;
    }
    return map;
  }
}
