import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class NewOrderStateManager {
  final OrdersService _service;
  final ProfileService _profileService;
  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  NewOrderStateManager(this._service, this._profileService);
}
