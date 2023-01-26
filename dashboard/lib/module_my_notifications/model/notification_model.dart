import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';

class NotificationModel extends DataModel {
  String? orderNumber;
  String body = S.current.orderDetails;
  String title = S.current.orderNumber;
  String date = '';
  bool marked = false;
  late int id;
  OrderStatusEnum? orderStatus;
  int? captainID;
  List<NotificationModel> models = [];

  NotificationModel({
    required this.orderNumber,
    required this.title,
    required this.body,
    required this.date,
    required this.marked,
    // required this.id,
    required this.captainID,
    required this.orderStatus,
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
        marked: false,
        title: element.title ?? '',
        orderNumber: element.message?.orderId?.toString() ?? '-1',
        body: element.message?.text ?? '',
        date: notificationDate,
        // id: element.id ?? -1 ,
        captainID: element.message?.captainID,
        orderStatus: StatusHelper.getStatusEnum(element.message?.orderStatus),
      ));
    });
  }

  List<NotificationModel> get data {
    return models;
  }
}
