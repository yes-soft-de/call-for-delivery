import 'package:the_country_number/the_country_number.dart';

class PhoneNumberFormatter {
  static String? format(String? text) {
    if (text == null) return null;
    if (text == '' || text.isEmpty) return '';
    if (text.length <= 9) return text;
    try {
      var phoneNumber =
          TheCountryNumber().parseNumber(internationalNumber: '+$text');
      var dial = phoneNumber.dialCode.substring(1);
      var number = phoneNumber.number;
      var formattedText =
          '+($dial)-${number.substring(0, 3)}-${number.substring(3, 6)}-${number.substring(6)}';
      return formattedText;
    } catch (e) {
      return null;
    }
  }
}
