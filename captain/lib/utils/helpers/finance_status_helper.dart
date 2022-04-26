import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';

class FinanceHelper {
  static String getStatusString(int? status) {
    switch (status) {
      case 1:
        return S.current.financePaid;
      case 2:
        return S.current.financeUnPaid;
      case 3:
        return S.current.financePartlyPaid;
      default:
        return S.current.unknown;
    }
  }

  static Color? getFinanceStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return Colors.purple;
      default:
        return null;
    }
  }
}
