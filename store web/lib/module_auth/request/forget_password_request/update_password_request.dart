import 'package:store_web/consts/country_code.dart';

class UpdatePassRequest {
  String userID;
  String newPassword;

  UpdatePassRequest({required this.userID, required this.newPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userID;
    data['password'] = newPassword;
    return data;
  }
}
