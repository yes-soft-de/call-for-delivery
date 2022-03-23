class EnquiryResponse {
  String? statusCode;
  String? msg;
  Data? data;

  EnquiryResponse({this.statusCode, this.msg, this.data});

  factory EnquiryResponse.fromJson(Map<String, dynamic> json) {
    return EnquiryResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  int? id;
  String? roomId;
  Data({
    this.id,
    this.roomId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        roomId: json['roomId'] as String?,
      );
}
