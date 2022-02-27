import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class StatusHelper {
  static RoleEnum getStatusEnum(String? status) {
    if (status == 'ROLE_OWNER') {
      return RoleEnum.STORE_OWNER;
    } else if (status == 'ROLE_SUPER_ADMIN') {
      return RoleEnum.SUPER_ADMIN;
    } else if (status == 'ROLE_ADMIN') {
      return RoleEnum.ADMIN;
    } else if (status == 'ROLE_CAPTAIN') {
      return RoleEnum.CAPTAIN;
    }
    return RoleEnum.CAPTAIN;
  }

  static String getOrderStatusMessages(RoleEnum? orderStatus) {
    switch (orderStatus) {
      case RoleEnum.STORE_OWNER:
        return S.current.storeOwner;
      case RoleEnum.ADMIN:
        return S.current.admin;
      case RoleEnum.SUPER_ADMIN:
        return S.current.superAdmin;
      case RoleEnum.CAPTAIN:
        return S.current.captain;
      default:
        return S.current.waiting;
    }
  }
  static Color getRoleColor(RoleEnum status) {
    switch (status) {
      case RoleEnum.ADMIN:
        return Colors.blue.shade50;
      case RoleEnum.SUPER_ADMIN:
        return Colors.red.shade50;
      case RoleEnum.CAPTAIN:
        return Colors.yellow.shade50;
      case RoleEnum.STORE_OWNER:
        return Colors.green.shade50;
      default:
        return Colors.red;
    }
  }
  static String getEnumStatus(RoleEnum? orderStatus) {
    switch (orderStatus) {
      case RoleEnum.STORE_OWNER:
        return 'ROLE_OWNER';
      case RoleEnum.ADMIN:
        return 'ROLE_ADMIN';
      case RoleEnum.SUPER_ADMIN:
        return 'ROLE_SUPER_ADMIN';
      case RoleEnum.CAPTAIN:
        return 'ROLE_CAPTAIN';
      default:
        return '';
    }
  }
}
