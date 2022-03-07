import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:intl/intl.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';

class NotificationModel extends DataModel {
  String orderNumber = '-1';
  String body = S.current.orderDetails;
  String title = S.current.orderNumber;
  String date = '';
  bool marked = false;
  List<NotificationModel> models = [];

  NotificationModel(
      {required this.orderNumber,
      required this.title,
      required this.body,
      required this.date,
      required this.marked});

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
          orderNumber: element.message?.orderId?.toString() ?? '-1',
          body: element.message?.text ?? '',
          date: notificationDate));
    });
  }

  List<NotificationModel> get data {
    return models;
  }
}
