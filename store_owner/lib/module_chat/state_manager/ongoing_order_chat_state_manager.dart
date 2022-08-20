import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_chat/model/chat_rooms_model.dart';
import 'package:c4d/module_chat/service/chat/char_service.dart';
import 'package:c4d/module_chat/ui/screens/ongoing_chat_rooms_screen.dart';
import 'package:c4d/module_chat/ui/state/ongoing_order_chat_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';

@injectable
class OngoingOrderChatStateManager {
  final ChatService _chatService;
  final AuthService _authService;

  OngoingOrderChatStateManager(this._chatService, this._authService);
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  void getRooms(OngoingOrderChatScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(LoadingState(screenState));
      _chatService.getOngoingOrderChat().then((value) {
        if (value.hasError) {
          _stateSubject.add(ErrorState(screenState,
              title: S.current.enquiries,
              error: value.error ?? S.current.errorHappened, onPressed: () {
            getRooms(screenState);
          }));
        } else if (value.isEmpty) {
          _stateSubject.add(EmptyState(screenState,
              title: S.current.enquiries,
              emptyMessage: S.current.homeDataEmpty, onPressed: () {
            getRooms(screenState);
          }));
        } else {
          value as ChatRoomsModel;
          _stateSubject
              .add(OngoingOrderChatLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}
