import 'package:the_country_number/the_country_number.dart';

class PhoneNumberDetection {
  static String getPhoneNumber(String phone) {
    var result = '';
    if (!isMobileNumberValid(phone)) {
      return result;
    }
    // remove white spaces
    result = phone.replaceAll(RegExp(r'[()-\s]'), '');
    if (result.length == 9) {
      return result;
    }
    if (result.length == 10 && result[0] == '0') {
      return result.substring(1);
    }
    if (result[0] + result[1] == '00') {
      result = '+${result.substring(2)}';
    }
    if (result[0] != '+') {
      result = '+$result';
    }
    final sNumber = TheCountryNumber().parseNumber(internationalNumber: result);
    result = sNumber.number;
    if (result.length == 10 && result[0] == '0') {
      return result.substring(1);
    }
    return result;
  }

  static bool isMobileNumberValid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{9,14}$';
    var regExp = RegExp(regexPattern);
    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp
        .hasMatch(phoneNumber.replaceAll(RegExp(r'[()-\s]'), ''))) {
      return true;
    }
    return false;
  }
}
