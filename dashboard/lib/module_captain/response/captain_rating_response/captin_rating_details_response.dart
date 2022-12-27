class CaptinRatingDetailsResponse {
  String? statusCode;
  String? msg;
  List<DataRating>? data;

  CaptinRatingDetailsResponse({this.statusCode, this.msg, this.data});

  CaptinRatingDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <DataRating>[];
      json['Data'].forEach((v) {
        data!.add(new DataRating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataRating {
  int? id;
  String? comment;
  int? rating;
  String? storeOwnerName;
  int? orderId;

  DataRating(
      {this.id, this.comment, this.rating, this.storeOwnerName, this.orderId});

  DataRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    storeOwnerName = json['storeOwnerName'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['storeOwnerName'] = this.storeOwnerName;
    data['orderId'] = this.orderId;
    return data;
  }
}
