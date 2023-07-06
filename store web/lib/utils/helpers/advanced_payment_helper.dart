import 'package:flutter/material.dart';

class AdvancedPaymentHelper {
  static Color? getFinanceStatusColor(int? status) {
    switch (status) {
      case 158:
        return Colors.grey;
      case 159:
        return Colors.red;
      case 160:
        return Colors.green;
    }
    return null;
  }
}
