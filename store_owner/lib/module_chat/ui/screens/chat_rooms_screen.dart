import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_chat/state_manager/order_chat_list_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/utils/components/fixed_container.dart';

@injectable
class OrderChatRoomsScreen extends StatefulWidget {
  final OrdersChatListStateManager _stateManager;
  OrderChatRoomsScreen(this._stateManager);

  @override
  OrderChatRoomsScreenState createState() => OrderChatRoomsScreenState();
}

class OrderChatRoomsScreenState extends State<OrderChatRoomsScreen> {
  late States currentState;
  bool markerMode = false;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getRooms() async {
    widget._stateManager.getRooms(this);
  }

  void deleteNotification(String id) {
    // widget._stateManager.deleteNotification(this, id);
  }

  void deleteNotifications(List<String> notification) {
    //   widget._stateManager.deleteNotifications(this, notification);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 3);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.getRooms(this);
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: FixedContainer(child: currentState.getUI(context)),
      ),
    );
  }
}
