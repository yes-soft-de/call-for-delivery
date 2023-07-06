import 'package:store_web/module_main/response/profile_response/date/date.dart';
import 'images.dart';

class Data {
  int? id;
  String? storeOwnerName;
  Images? images;
  String? phone;
  String? status;
  dynamic commission;
  String? employeeCount;
  String? city;
  String? bankName;
  String? bankNumber;
  Date? openingTime;
  Date? closeTime;
  String? roomId;
  Data(
      {this.id,
      this.storeOwnerName,
      this.images,
      this.phone,
      this.status,
      this.commission,
      this.employeeCount,
      this.bankName,
      this.bankNumber,
      this.city,
      this.closeTime,
      this.openingTime,
      this.roomId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        images: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        status: json['status'] as String?,
        commission: json['commission'] as dynamic,
        employeeCount: json['employeeCount'] as String?,
        city: json['city'] as String?,
        bankName: json['bankName'] as String?,
        bankNumber: json['bankAccountNumber'] as String?,
        roomId: json['roomId'] as String?,
        openingTime: json['openingTime'] == null
            ? null
            : Date.fromJson(json['openingTime'] as Map<String, dynamic>),
        closeTime: json['closingTime'] == null
            ? null
            : Date.fromJson(json['closingTime'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'images': images?.toJson(),
        'phone': phone,
        'status': status,
        'commission': commission,
        'employeeCount': employeeCount,
      };
}
