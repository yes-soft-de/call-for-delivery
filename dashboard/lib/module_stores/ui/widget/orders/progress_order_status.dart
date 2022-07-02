import 'package:c4d/consts/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/images/images.dart';

class OrderProgressionHelper {
  static Widget getStatusIcon(
      OrderStatusEnum status, double height, BuildContext context) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return SvgPicture.asset(
          SvgAsset.SEARCHING_SVG,
          height: height,
        );
      case OrderStatusEnum.GOT_CAPTAIN:
        return SvgPicture.asset(
          SvgAsset.DELIVER,
          height: height,
        );
      case OrderStatusEnum.IN_STORE:
        return SvgPicture.asset(
          SvgAsset.ACCEPT_ORDER,
          height: height,
        );
      case OrderStatusEnum.DELIVERING:
        return SvgPicture.asset(
          SvgAsset.ACCEPT_ORDER,
          height: height,
        );
      case OrderStatusEnum.FINISHED:
        return SvgPicture.asset(
          SvgAsset.SUCCESS_SVG,
          height: height,
        );
      default:
        return SvgPicture.asset(
          SvgAsset.ERROR_SVG,
          height: height,
        );
    }
  }

  static String getNextStageHelper(
      OrderStatusEnum status, bool isOnline, BuildContext context) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return S.of(context).acceptOrder;

      case OrderStatusEnum.GOT_CAPTAIN:
        return S.of(context).iArrivedAtTheStore;

      case OrderStatusEnum.IN_STORE:
        return S.of(context).iGotThePackage;

      case OrderStatusEnum.DELIVERING:
        return S.of(context).iFinishedDelivering;

      case OrderStatusEnum.FINISHED:
        return S.of(context).iFinishedDelivering;
      default:
        return S.of(context).orderIsInUndefinedState;
    }
  }

  static String getCurrentStageHelper(
      OrderStatusEnum status, BuildContext context) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return S.of(context).searchingForCaptain;
      case OrderStatusEnum.GOT_CAPTAIN:
        return S.of(context).captainIsInTheWay;
      case OrderStatusEnum.IN_STORE:
        return S.of(context).captainIsInStore;
      case OrderStatusEnum.DELIVERING:
        return S.of(context).captainIsDelivering;
      case OrderStatusEnum.FINISHED:
        return S.of(context).orderIsDone;
      default:
        return S.of(context).orderIsInUndefinedState;
    }
  }
}
