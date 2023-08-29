// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';

class GeoHive {
  GeoDistanceRequest request;
  GeoDistanceX response;
  
  GeoHive({
    required this.request,
    required this.response,
  });

  GeoHive copyWith({
    GeoDistanceRequest? request,
    GeoDistanceX? response,
  }) {
    return GeoHive(
      request: request ?? this.request,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'request': request.toMap(),
      'response': response.toMap(),
    };
  }

  factory GeoHive.fromMap(Map<String, dynamic> map) {
    return GeoHive(
      request: GeoDistanceRequest.fromMap(map['request'] as Map<String,dynamic>),
      response: GeoDistanceX.fromMap(map['response'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoHive.fromJson(String source) => GeoHive.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GeoHive(request: $request, response: $response)';

  @override
  bool operator ==(covariant GeoHive other) {
    if (identical(this, other)) return true;
  
    return 
      other.request == request &&
      other.response == response;
  }

  @override
  int get hashCode => request.hashCode ^ response.hashCode;
}
