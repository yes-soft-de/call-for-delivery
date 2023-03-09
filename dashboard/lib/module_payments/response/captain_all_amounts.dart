import 'package:c4d/module_payments/response/captain_dialy_finance/created_at.dart';

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
  CreatedAt? createdAt;
  String? note;

  CaptainDataAmount({this.id, this.amount, this.createdAt, this.note});

  CaptainDataAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    createdAt = CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>);
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    data['createdAt'] = createdAt?.toJson();
    data['note'] = note;

    return data;
  }
}
