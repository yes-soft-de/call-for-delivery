class BranchListResponse {
  List<Data>? data;
  String? statusCode;
  BranchListResponse({this.data});

  BranchListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  GeoJson? location;
  String? city;
  String? brancheName;
  String? userName;

  Data({this.id, this.location, this.brancheName, this.userName, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location =
        json['location'] != null ? GeoJson.fromJson(json['location']) : null;
    city = json['city'];
    brancheName = json['brancheName'];
    userName = json['userName'];
  }
}

class GeoJson {
  num? lat;
  num? lon;
  GeoJson.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
}
