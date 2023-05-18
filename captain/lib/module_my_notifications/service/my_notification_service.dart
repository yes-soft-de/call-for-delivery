import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/presistance/my_notification_hive_helper.dart';
import 'package:c4d/module_my_notifications/response/update_response/update_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart';
import 'package:c4d/module_my_notifications/model/notification_model.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class MyNotificationsService {
  final MyNotificationsManager _myNotificationsManager;

  MyNotificationsService(this._myNotificationsManager);

  Future<DataModel> getNotification() async {
    MyNotificationResponse? myNotificationResponse =
        await _myNotificationsManager.getNotification();
    if (myNotificationResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (myNotificationResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          myNotificationResponse.statusCode));
    }
    if (myNotificationResponse.data == null) return DataModel.empty();
    return NotificationModel.withData(myNotificationResponse);
  }

  Future<DataModel> getUpdates({bool onlyNewUpdates = false}) async {
    UpdateResponse? updateResponse =
        await _myNotificationsManager.getUpdates(onlyNewUpdates);
    if (updateResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (updateResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(updateResponse.statusCode));
    }
    if (updateResponse.data == null) return DataModel.empty();

    UpdateModel updateModel = UpdateModel.withData(updateResponse);

    if (onlyNewUpdates) {
      updateModel = filterNewUpdate(updateModel);
    }

    return updateModel;
  }

  UpdateModel filterNewUpdate(UpdateModel updateModel) {
    var hiveHelper = MyNotificationHiveHelper();

    List<UpdateModel> newUpdate = updateModel.data.reversed.toList();
    var tempList = [...newUpdate];

    for (var update in tempList) {
      if (update.id > (hiveHelper.getLastNotificationSeenId() ?? 0)) {
        hiveHelper.setLastNotificationSeenId(update.id);
      } else {
        newUpdate.remove(update);
      }
    }

    updateModel = UpdateModel.fromList(newUpdate);

    return updateModel;
  }

  Future<DataModel> deleteNotification(String id) async {
    ActionResponse? myNotificationResponse =
        await _myNotificationsManager.deleteNotification(id);
    if (myNotificationResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (myNotificationResponse.statusCode != '401') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          myNotificationResponse.statusCode));
    }
    return DataModel.empty();
  }
}
