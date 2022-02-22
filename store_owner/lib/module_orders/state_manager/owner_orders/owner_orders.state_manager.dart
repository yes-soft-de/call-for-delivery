import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';

@injectable
class OwnerOrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final ProfileService _profileService;

  final PublishSubject<OwnerOrdersListState> _stateSubject = PublishSubject();
  final PublishSubject<ProfileResponseModel> _profileSubject = PublishSubject();
  final PublishSubject<CompanyInfoResponse> _companySubject = PublishSubject();

  Stream<OwnerOrdersListState> get stateStream => _stateSubject.stream;

  Stream<ProfileResponseModel> get profileStream => _profileSubject.stream;

  Stream<CompanyInfoResponse> get companyStream => _companySubject.stream;

  OwnerOrdersStateManager(
    this._ordersService,
    this._authService,
    this._profileService,
  );

}
