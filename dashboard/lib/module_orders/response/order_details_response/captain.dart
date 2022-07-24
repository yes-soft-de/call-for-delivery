import 'package:c4d/module_orders/response/order_details_response/images.dart';

class Captain {
  int? id;
  int? captainId;
  String? captainName;
  List<dynamic>? location;
  int? age;
  String? car;
  dynamic salary;
  dynamic bounce;
  String? phone;
  bool? isOnline;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? status;
  num? rating;
  Images? images;
  Captain(
      {this.id,
      this.captainId,
      this.captainName,
      this.location,
      this.age,
      this.car,
      this.salary,
      this.bounce,
      this.phone,
      this.isOnline,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.status,
      this.rating,
      this.images});

  factory Captain.fromJson(Map<String, dynamic> json) => Captain(
        id: json['id'] as int?,
        captainId: json['captainId'] as int?,
        captainName: json['captainName'] as String?,
        location: json['location'] as List<dynamic>?,
        age: json['age'] as int?,
        car: json['car'] as String?,
        salary: json['salary'] as dynamic,
        bounce: json['bounce'] as dynamic,
        phone: json['phone'] as String?,
        isOnline: json['isOnline'] as bool?,
        bankName: json['bankName'] as String?,
        bankAccountNumber: json['bankAccountNumber'] as String?,
        stcPay: json['stcPay'] as String?,
        status: json['status'] as String?,
        rating: json['averageRating'] as num?,
        images: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainId': captainId,
        'captainName': captainName,
        'location': location,
        'age': age,
        'car': car,
        'salary': salary,
        'bounce': bounce,
        'phone': phone,
        'isOnline': isOnline,
        'bankName': bankName,
        'bankAccountNumber': bankAccountNumber,
        'stcPay': stcPay,
        'status': status,
      };
}
