import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_web/abstracts/states/loading_state.dart';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/authorization_routes.dart';
import 'package:store_web/module_main/model/profile_model/profile_model.dart';
import 'package:store_web/module_main/model/store_profile_model.dart';
import 'package:store_web/module_main/service/main_service.dart';
import 'package:store_web/module_main/ui/screen/main_screen.dart';
import 'package:store_web/module_main/ui/states/main_state_loaded.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

@injectable
class MainStateManager {
  final MainService _mainService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  MainStateManager(this._mainService);

  void deleteStore(MainScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));

    _mainService.getProfile().then(
      (value) {
        if (value.hasError || value.isEmpty) {
          CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened,
          ).show(screenState.context);
          _stateSubject.add(MainStateLoaded(screenState));
        } else {
          value as ProfileModel;
          var profile = value.data;

          _mainService.getAdminToken().then(
            (adminToken) {
              if (adminToken == null || adminToken.isEmpty) {
                CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.errorHappened,
                ).show(screenState.context);
                _stateSubject.add(MainStateLoaded(screenState));
              } else {
                _mainService.getStoreProfile(profile.id, adminToken).then(
                  (value) {
                    if (value.hasError || value.isEmpty) {
                      CustomFlushBarHelper.createError(
                        title: S.current.warnning,
                        message: S.current.errorHappened,
                      ).show(screenState.context);
                      _stateSubject.add(MainStateLoaded(screenState));
                    } else {
                      value as StoreProfileModel;
                      var storeProfile = value.data;
                      _mainService
                          .deleteStore(storeProfile.storeId, adminToken)
                          .then(
                        (value) {
                          if (value.hasError) {
                            _stateSubject.add(MainStateLoaded(screenState));
                            CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: value.error ?? S.current.errorHappened,
                            ).show(screenState.context);
                          } else {
                            CustomFlushBarHelper.createSuccess(
                              title: S.current.warnning,
                              message: S.current.userDeleted,
                            ).show(screenState.context);
                            Navigator.pushNamedAndRemoveUntil(
                              screenState.context,
                              AuthorizationRoutes.LOGIN_SCREEN,
                              (route) => false,
                            );
                          }
                        },
                      );
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
