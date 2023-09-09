import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class NaherEvanCaptainsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  NaherEvanCaptainsResponse({this.statusCode, this.msg, this.data});

  NaherEvanCaptainsResponse.fromJson(dynamic json) {
    try {} catch (e) {
      statusCode = '-1';
      Logger.error('InActiveCaptainResponse', e.toString(), StackTrace.current);
    }
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? id;
  int? captainID;
  String? captainName;
  ImageUrl? image;
  bool? status;

  Data({
    this.id,
    this.captainID,
    this.captainName,
    this.image,
    this.status,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainId'];
    captainName = json['captainName'];
    image = json['image'] != null ? ImageUrl.fromJson(json['image']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['image'] = image;
    map['status'] = status;
    return map;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }
}
