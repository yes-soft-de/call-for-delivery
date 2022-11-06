import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/request/delete_subscription_request.dart';
import 'package:c4d/module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/state/store_financial_subscriptions_details/store_financial_details_state.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreSubscriptionsFinanceDetailsScreen extends StatefulWidget {
  final StoreFinancialSubscriptionsDuesDetailsStateManager _manager;
  const StoreSubscriptionsFinanceDetailsScreen(
    this._manager,
  );
  @override
  State<StatefulWidget> createState() =>
      StoreSubscriptionsFinanceDetailsScreenState();
}

class StoreSubscriptionsFinanceDetailsScreenState
    extends State<StoreSubscriptionsFinanceDetailsScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = StoreSubscriptionsFinanceDetailsStateLoaded(this);
    manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  StoreFinancialSubscriptionsDuesDetailsStateManager get manager =>
      widget._manager;

  void refresh() {
    if (mounted) setState(() {});
  }

  late StoreSubscriptionsFinanceModel model;
  bool flag = true;
  void moveBack() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.deleteCaptainOfferSubscriptionSuccessfully)
          .show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreSubscriptionsFinanceModel && flag) {
      model = args;
      flag = false;
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.financeSubscriptionDetails,
            actions: [
              Visibility(
                visible: model.isCurrent || model.status == 'date finished',
                child: CustomC4dAppBar.actionIcon(context, onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return CustomAlertDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: ctx,
                                  builder: (c) {
                                    return CustomAlertDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        widget._manager.deleteSubscriptions(
                                            this,
                                            DeleteSubscriptionsRequest(
                                                id: model.id,
                                                deletePayment: 1));
                                      },
                                      onPressed2: () {
                                        Navigator.of(context).pop();
                                        widget._manager.deleteSubscriptions(
                                            this,
                                            DeleteSubscriptionsRequest(
                                                id: model.id,
                                                deletePayment: 0));
                                      },
                                      actionTitle2: S.current.no,
                                      actionTitle: S.current.yes,
                                      content: S.current
                                          .areYouWantToDeleteAllPayments,
                                      oneAction: false,
                                    );
                                  });
                            },
                            content:
                                S.current.areSureAboutDeleteThisSubscriptions,
                            oneAction: false);
                      });
                }, icon: Icons.delete),
              ),
              Visibility(
                visible: model.isCurrent,
                child: CustomC4dAppBar.actionIcon(context, onTap: () {
                  Navigator.of(context).pushNamed(
                      SubscriptionsRoutes.EDIT_SUBSCRIPTION_SCREEN,
                      arguments: model.id);
                }, icon: Icons.edit),
              )
            ]),
        body: currentState.getUI(context));
  }
}
