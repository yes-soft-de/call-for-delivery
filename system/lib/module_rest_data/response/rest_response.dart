class RestDataResponse {
  String? statusCode;
  String? msg;
//  Data? data;

  RestDataResponse({this.statusCode, this.msg});

  RestDataResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    return data;
  }
}

