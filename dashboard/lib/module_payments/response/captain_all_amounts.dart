class CaptainAllFinanceResponse {
  String? statusCode;
  String? msg;
  List<CaptainDataAmount>? data;

  CaptainAllFinanceResponse({this.statusCode, this.msg, this.data});

  CaptainAllFinanceResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <CaptainDataAmount>[];
      json['Data'].forEach((v) {
        data!.add(new CaptainDataAmount.fromJson(v));
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

class CaptainDataAmount {
  int? id;
  int? amount;
  // CreatedAt? createdAt;
  String? note;

  CaptainDataAmount(
      {this.id,
      this.amount,
      //  this.createdAt,
      this.note});

  CaptainDataAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    // createdAt = json['createdAt'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    // data['createdAt'] = this.createdAt;
    data['note'] = this.note;

    return data;
  }
}
