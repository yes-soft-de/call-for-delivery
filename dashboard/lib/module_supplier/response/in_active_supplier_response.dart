 import 'package:c4d/utils/logger/logger.dart';

import '../../module_stores/response/store_profile_response.dart';

class SupplierResponse {
  String? statusCode;
  String? msg;
  List<SupplierData>? data;

  SupplierResponse({this.statusCode, this.msg, this.data});

  SupplierResponse.fromJson(dynamic json) {
    try {} catch (e) {
      statusCode = '-1';
      Logger()
          .error('InActiveCaptainResponse', e.toString(), StackTrace.current);
    }
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(SupplierData.fromJson(v));
      });
    }
  }

}

class SupplierData {
  int? id;
  String? supplierName;
  List<ImageUrl>? image;
  bool? state;

  SupplierData(
      {this.id,
      this.supplierName,
      this.image,
      this.state,});

  SupplierData.fromJson(dynamic json) {
    id = json['id'];
    supplierName = json['supplierName'];
    if (json['images'] != null) {
      image = [];
      json['images'].forEach((v) {
        image?.add(ImageUrl.fromJson(v));
      });
    }
    state = json['status'];
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
