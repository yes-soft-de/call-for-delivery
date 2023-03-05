import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';

class NotificationModel extends DataModel {
  String? orderNumber;
  String body = S.current.orderDetails;
  String title = S.current.orderNumber;
  String date = '';
  late DateTime dateTime;
  bool marked = false;
  late int id;
  OrderStatusEnum? orderStatus;
  int? captainID;
  List<NotificationModel> models = [];
  bool seen = true;
  NotificationModel(
      {required this.orderNumber,
      required this.title,
      required this.body,
      required this.date,
      required this.marked,
      required this.id,
      required this.captainID,
      required this.orderStatus,
      required this.dateTime,
      required this.seen});

  NotificationModel.withData(MyNotificationResponse orders) {
    var data = orders.data;
    data?.forEach((element) {
      String notificationDate = DateFormat.jm().format(
              DateTime.fromMillisecondsSinceEpoch(
                  (element.createdAt?.timestamp ??
                          DateTime.now().millisecondsSinceEpoch) *
                      1000)) +
          ' 📅 ' +
          DateFormat.Md().format(DateTime.fromMillisecondsSinceEpoch(
              (element.createdAt?.timestamp ??
                      DateTime.now().millisecondsSinceEpoch) *
                  1000));
      models.add(NotificationModel(
        marked: false,
        title: element.title ?? '',
        orderNumber: element.message?.orderId?.toString(),
        body: element.message?.text ?? '',
        date: notificationDate,
        id: element.id ?? -1,
        captainID: element.message?.captainID,
        orderStatus: StatusHelper.getStatusEnum(element.message?.orderStatus),
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            (element.createdAt?.timestamp ??
                    DateTime.now().millisecondsSinceEpoch) *
                1000),
        seen: true,
      ));
    });
  }

  List<NotificationModel> get data {
    return models;
  }
}
