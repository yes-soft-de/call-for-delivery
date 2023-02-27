class CaptainFinanceDailyResponse {
  String? statusCode;
  String? msg;
  List<CaptainData>? data;

  CaptainFinanceDailyResponse({this.statusCode, this.msg, this.data});

  CaptainFinanceDailyResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <CaptainData>[];
      json['Data'].forEach((v) {
        data!.add(new CaptainData.fromJson(v));
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

class CaptainData {
  int? id;
  String? captainName;
  Image? image;
  dynamic captainFinancialDailyId;
  int? amount;
  int? alreadyHadAmount;
  int? financialSystemType;
  dynamic? financialSystemPlan;
  int? isPaid;
  bool? withBonus;
  int? bonus;
  dynamic? captainFinancialDailyUpdatedAt;

  CaptainData(
      {this.id,
      this.captainName,
      this.image,
      this.captainFinancialDailyId,
      this.amount,
      this.alreadyHadAmount,
      this.financialSystemType,
      this.financialSystemPlan,
      this.isPaid,
      this.withBonus,
      this.bonus,
      this.captainFinancialDailyUpdatedAt});

  CaptainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainName = json['captainName'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    captainFinancialDailyId = json['captainFinancialDailyId'];
    amount = json['amount'];
    alreadyHadAmount = json['alreadyHadAmount'];
    financialSystemType = json['financialSystemType'];
    financialSystemPlan = json['financialSystemPlan'];
    isPaid = json['isPaid'];
    withBonus = json['withBonus'];
    bonus = json['bonus'];
    captainFinancialDailyUpdatedAt = json['captainFinancialDailyUpdatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainName'] = this.captainName;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['captainFinancialDailyId'] = this.captainFinancialDailyId;
    data['amount'] = this.amount;
    data['alreadyHadAmount'] = this.alreadyHadAmount;
    data['financialSystemType'] = this.financialSystemType;
    data['financialSystemPlan'] = this.financialSystemPlan;
    data['isPaid'] = this.isPaid;
    data['withBonus'] = this.withBonus;
    data['bonus'] = this.bonus;
    data['captainFinancialDailyUpdatedAt'] =
        this.captainFinancialDailyUpdatedAt;
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
