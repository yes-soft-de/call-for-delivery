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
    MyNotificationResponse? _myNotificationResponse =
        await _myNotificationsManager.getNotification();
    if (_myNotificationResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_myNotificationResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _myNotificationResponse.statusCode));
    }
    if (_myNotificationResponse.data == null) return DataModel.empty();
    return NotificationModel.withData(_myNotificationResponse);
  }

  Future<DataModel> getUpdates({bool onlyNewUpdates = false}) async {
    UpdateResponse? _updateResponse =
        await _myNotificationsManager.getUpdates(onlyNewUpdates);
    if (_updateResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_updateResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_updateResponse.statusCode));
    }
    if (_updateResponse.data == null) return DataModel.empty();
        UpdateModel updateModel = UpdateModel.withData(_updateResponse);

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
    ActionResponse? _myNotificationResponse =
        await _myNotificationsManager.deleteNotification(id);
    if (_myNotificationResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_myNotificationResponse.statusCode != '401') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _myNotificationResponse.statusCode));
    }
    return DataModel.empty();
  }
}
