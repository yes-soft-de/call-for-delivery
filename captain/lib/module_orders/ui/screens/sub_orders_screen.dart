import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubOrdersScreen extends StatefulWidget {
  final SubOrdersStateManager _stateManager;
  SubOrdersScreen(this._stateManager);

  @override
  SubOrdersScreenState createState() => SubOrdersScreenState();
}

class SubOrdersScreenState extends State<SubOrdersScreen> {
  int orderId = -1;
  late States currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SubOrdersStateManager get manager => widget._stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (mounted) {
        widget._stateManager.getOrder(this, orderId, false);
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool canRemoveIt = false;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      widget._stateManager.getOrder(this, orderId);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.groupOrder, actions: []),
        body: currentState.getUI(context),
      ),
    );
  }
}
