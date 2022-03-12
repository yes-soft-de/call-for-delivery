class UsersResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  UsersResponse({this.statusCode, this.msg, this.data});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if(json['Data'] != null){
      data =[];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? id;
  String? userId;
  List<String>? roles;
  Data(
      {
        this.id,
        this.userId,
        this.roles
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    roles= List<String>.from(json['roles'].map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}
