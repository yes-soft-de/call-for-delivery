import 'package:store_web/consts/offer_status.dart';
import 'package:flutter/material.dart';
import 'package:store_web/generated/l10n.dart';

class OfferStatusHelper {
  static Color getOfferStatusColor(OfferStatusEnum status) {
    switch (status) {
      case OfferStatusEnum.PENDING:
        return Colors.blue.shade900;
      case OfferStatusEnum.REFUSED:
        return Colors.red;
      case OfferStatusEnum.ACCEPTED:
        return Colors.green.shade200;
      case OfferStatusEnum.CONFIRMED:
        return Colors.green.shade900;
      default:
        return Colors.red;
    }
  }

  static OfferStatusEnum getOfferEnum(String status) {
    if (status == 'pending') {
      return OfferStatusEnum.PENDING;
    } else if (status == 'accepted') {
      return OfferStatusEnum.ACCEPTED;
    } else if (status == 'refused') {
      return OfferStatusEnum.REFUSED;
    } else if (status == 'confirmed') {
      return OfferStatusEnum.CONFIRMED;
    }
    return OfferStatusEnum.PENDING;
  }

  static String getOfferStatusName(OfferStatusEnum status) {
    switch (status) {
      case OfferStatusEnum.PENDING:
        return S.current.pendingOffer;
      case OfferStatusEnum.REFUSED:
        return S.current.refusedOffer;
      case OfferStatusEnum.ACCEPTED:
        return S.current.acceptedOffer;
      case OfferStatusEnum.CONFIRMED:
        return S.current.confirmed;
      default:
        return S.current.pendingOffer;
    }
  }
}
