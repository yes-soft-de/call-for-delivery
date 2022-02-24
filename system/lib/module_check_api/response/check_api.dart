class CheckApiResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CheckApiResponse({this.statusCode, this.msg, this.data});

  CheckApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new Data.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? result;
  Data(
      {this.result,
      });

  Data.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}
