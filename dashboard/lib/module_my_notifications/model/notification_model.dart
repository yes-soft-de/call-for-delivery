import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';

class NotificationModel extends DataModel {
  String? id;
  String body = S.current.orderDetails;
  String title = S.current.orderNumber;
  String? adminName;
  // OrderStatusEnum? orderStatus;
  String? date;
  int? orderId;
  bool marked = false;
  String? message;
  List<NotificationModel> models = [];

  NotificationModel({
    required this.title,
    required this.body,
    required this.id,
    required this.adminName,
    this.message,
    this.date,
    this.orderId,
    required this.marked,
    // required this.id,
  });

  NotificationModel.withData(MyNotificationResponse orders) {
    var data = orders.data;
    data?.forEach((element) {
      String notificationDate = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      models.add(NotificationModel(
        adminName: element.adminName ?? '',
        id: element.id,
        message: element.message?.text ?? '',
        marked: false,
        date: notificationDate,
        title: element.title ?? '',
        orderId: element.orderId,
        body: element.message?.text ?? '',
        // id: element.id ?? -1 ,
      ));
    });
  }

  List<NotificationModel> get data {
    return models;
  }
}
