import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/order_actionlogs_response/order_actionlogs_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_logs_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class OrderActionLogsModel extends DataModel {
  late int id;
  late String action;
  late OrderStatusEnum state;
  late String createdAt;
  late String createdBy;
  late String image;
  late String imagePath;
  OrderActionLogsModel({
    required this.id,
    required this.action,
    required this.createdAt,
    required this.createdBy,
    required this.state,
    required this.image,
    required this.imagePath,
  });
  List<OrderActionLogsModel> _orders = [];
  OrderActionLogsModel.withData(OrderActionLogsResponse response) {
    var data = response.data;
    data?.forEach((element) {
      // date formatter
      // created At
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));

      _orders.add(OrderActionLogsModel(
        id: element.id ?? -1,
        state: StatusHelper.getOrderStatusEnumFromIndex(element.state),
        action: ActionTypeLogsHelper.getOrderLogsMessages(element.action),
        createdAt: create,
        createdBy: element.createdBy ?? S.current.unknown,
        image: element.image?.image ?? '',
        imagePath: element.image?.imageUrl ?? '',
      ));
    });
  }
  List<OrderActionLogsModel> get data => _orders;
}
