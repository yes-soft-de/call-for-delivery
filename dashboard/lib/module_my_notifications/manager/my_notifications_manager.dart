import 'package:c4d/module_my_notifications/response/update_response/update_response.dart';

import 'package:injectable/injectable.dart';
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';

import '../../abstracts/response/action_response.dart';

@injectable
class MyNotificationsManager {
  final MyNotificationsRepository _myNotificationsRepository;

  MyNotificationsManager(this._myNotificationsRepository);

  Future<MyNotificationResponse?> getNotification() =>
      _myNotificationsRepository.getMyNotification();
  Future<ActionResponse?> deleteNotification(String id) =>
      _myNotificationsRepository.deleteNotification(id);
  Future<UpdateResponse?> getUpdates() =>
      _myNotificationsRepository.getUpdates();
}
