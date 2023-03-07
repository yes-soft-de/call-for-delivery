class CaptainFinanceDailyNewResponse {
  String? statusCode;
  String? msg;
  List<CaptainDataFinance>? data;

  CaptainFinanceDailyNewResponse({this.statusCode, this.msg, this.data});

  CaptainFinanceDailyNewResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <CaptainDataFinance>[];
      json['Data'].forEach((v) {
        data!.add(new CaptainDataFinance.fromJson(v));
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

class CaptainDataFinance {
  int? id;
  int? captainProfileId;
  String? captainName;
  Image? image;
  int? amountSum;
  int? toBePaid;

  CaptainDataFinance(
      {this.id,
      this.captainProfileId,
      this.captainName,
      this.image,
      this.amountSum,
      this.toBePaid});

  CaptainDataFinance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainProfileId = json['captainProfileId'];
    captainName = json['captainName'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    amountSum = json['amountSum'];
    toBePaid = json['toBePaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainProfileId'] = this.captainProfileId;
    data['captainName'] = this.captainName;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['amountSum'] = this.amountSum;
    data['toBePaid'] = this.toBePaid;
    return data;
  }
}

class Image {
  String? imageURL;
  String? image;
  String? baseURL;

  Image({this.imageURL, this.image, this.baseURL});

  Image.fromJson(Map<String, dynamic> json) {
    imageURL = json['imageURL'];
    image = json['image'];
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageURL'] = this.imageURL;
    data['image'] = this.image;
    data['baseURL'] = this.baseURL;
    return data;
  }
}
