import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/conflict_distance_order.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/refused_order_distance_conflict.dart';
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_distance_conflict_card.dart';
import 'package:c4d/utils/components/custom_c4d_field.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class OrderDistanceConflictLoadedState extends States {
  OrderDistanceConflictScreenState screenState;
  List<ConflictDistanceOrder> orders;

  OrderDistanceConflictLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      Navigator.of(screenState.context).pushNamed(
                          OrdersRoutes.ORDER_STATUS_SCREEN,
                          arguments: orders[index].orderId);
                    },
                    child: OrderDistanceConflict(
                      orderNumber: orders[index].orderId.toString(),
                      branchName: orders[index].storeBranchName,
                      captain: orders[index].captainName,
                      distance: orders[index].proposedDestinationOrDistance,
                      onEdit: () {
                        ActionType action = ActionType.defaultValue;
                        TextEditingController decision =
                            TextEditingController();
                        TextEditingController reason = TextEditingController();
                        final GlobalKey<FormState> formKey =
                            GlobalKey<FormState>();

                        _caseDetailsAndSolveDialog(context, orders[index],
                            formKey, reason, decision, action);
                      },
                      storeOwner: orders[index].storeOwnerName,
                      conflictReason: orders[index].conflictNote,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }

  void _caseDetailsAndSolveDialog(
      context,
      ConflictDistanceOrder element,
      GlobalKey<FormState> formKey,
      TextEditingController reason,
      TextEditingController decision,
      ActionType action) {
    showDialog(
      context: context,
      builder: (context) {
        var color = Theme.of(context).colorScheme.primary.withAlpha(100);
        return Dialog(
          insetPadding: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: LayoutBuilder(
              builder: (context, constrain) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.current.editDistanceRequestDetails,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 10),
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: constrain.maxHeight - 120),
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          _Field(
                            title: S.current.requestedEdit,
                            text: element.proposedDestinationOrDistance,
                          ),
                          SizedBox(height: 20),
                          _Field(
                            title: S.current.editReason,
                            text: element.conflictNote,
                          ),
                          SizedBox(height: 10),
                          HDivider(dividerColor: color),
                          SizedBox(height: 10),
                          _AdminDecisionWidget(
                            formKey: formKey,
                            reason: reason,
                            decision: decision,
                            onActionChange: (newAction) {
                              action = newAction;
                            },
                          ),
                        ],
                      ),
                    ),
                    // buttons
                    SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: _elevatedButtonStyle(color: Colors.red),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showRefusedDialog(context, reason, element);
                                },
                                child: Text(S.current.ignoreOrder)),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              style: _elevatedButtonStyle(),
                              onPressed: () {
                                if (formKey.currentState?.validate() == true) {
                                  Navigator.pop(context);
                                  if (action == ActionType.addKiloMeter) {
                                    var request = AddExtraDistanceRequest(
                                      id: element.orderId,
                                      adminNote: reason.text.trim(),
                                      additionalDistance:
                                          double.tryParse(decision.text),
                                    );
                                    _showConfirmDialog(
                                        context, action, request);
                                  } else if (action ==
                                      ActionType.editCoordinates) {
                                    var request = AddExtraDistanceRequest(
                                      id: element.orderId,
                                      adminNote: reason.text.trim(),
                                      destination: Destination(
                                        lat: double.tryParse(decision.text
                                            .trim()
                                            .split(',')[0]
                                            .trim()),
                                        lon: double.tryParse(decision.text
                                            .trim()
                                            .split(',')[1]
                                            .trim()),
                                      ),
                                    );
                                    _showConfirmDialog(
                                        context, action, request);
                                  }
                                }
                              },
                              child: Text(
                                S.current.updateDistance,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showRefusedDialog(BuildContext context,
      TextEditingController reason, ConflictDistanceOrder element) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xff666ACB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 50,
                      color: Colors.amber,
                    ),
                    Flexible(
                      child: Text(
                        S.current.areYouSureAboutRefusedTheConflictRequest,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  reason.text,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            S.current.cancel,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          onPressed: () {
                            Navigator.pop(context);
                            var request = RefusedOrderDistanceConflictRequest(
                              id: element.orderId,
                              adminNote: reason.text.trim(),
                            );
                            screenState.manager.refusedOrderDistanceConflict(
                                screenState, request);
                          },
                          child: Text(
                            S.current.confirm,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmDialog(BuildContext context, ActionType action,
      AddExtraDistanceRequest request) {
    var text = '';

    if (action == ActionType.addKiloMeter) {
      text = S.current.added;
      text += ' ${request.additionalDistance} ${S.current.km} ';
      text += S.current.toTheCalculatedDistance;
    }
    if (action == ActionType.editCoordinates) {
      text = S.current.clientLocationUpdatedTo;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xff666ACB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 50,
                      color: Colors.amber,
                    ),
                    Text(
                      S.current.areYouSureAboutEdit,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                    visible: action == ActionType.editCoordinates,
                    child: Text(
                      request.destination.toString(),
                      style: TextStyle(fontSize: 14, color: Color(0xff03D1FE)),
                    )),
                SizedBox(height: 20),
                Text(
                  request.adminNote ?? '',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            S.current.cancel,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          onPressed: () {
                            Navigator.pop(context);
                            if (action == ActionType.addKiloMeter) {
                              screenState.manager
                                  .addExtraDistance(screenState, request);
                            } else if (action == ActionType.editCoordinates) {
                              screenState.manager
                                  .updateDistance(screenState, request);
                            }
                          },
                          child: Text(
                            S.current.confirm,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ButtonStyle _elevatedButtonStyle({Color color = Colors.amber}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _AdminDecisionWidget extends StatefulWidget {
  final Function(ActionType newAction) onActionChange;
  final TextEditingController decision;
  final TextEditingController reason;
  final GlobalKey<FormState> formKey;

  const _AdminDecisionWidget({
    Key? key,
    required this.onActionChange,
    required this.decision,
    required this.reason,
    required this.formKey,
  }) : super(key: key);

  @override
  State<_AdminDecisionWidget> createState() => _AdminDecisionWidgetState();
}

class _AdminDecisionWidgetState extends State<_AdminDecisionWidget> {
  ActionType action = ActionType.defaultValue;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              S.current.adminDecision,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 10),
          _PickActionWidget(
            onChange: (newAction) {
              action = newAction;
              widget.onActionChange(newAction);
              setState(() {});
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              action == ActionType.addKiloMeter
                  ? S.current.kiloMeterNumber
                  : S.current.newCoordinates,
            ),
          ),
          CustomFormField(
            validator: true,
            validatorFunction: (value) {
              if (action == ActionType.addKiloMeter) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseCompleteField;
                }
              } else if (action == ActionType.editCoordinates) {
                if (value == null ||
                    value.isEmpty ||
                    value.split(',').length != 2) {
                  return S.current.pleaseCompleteField;
                }
              }
              return null;
            },
            controller: widget.decision,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(S.current.reason),
          ),
          CustomC4DFormField(
            validator: false,
            controller: widget.reason,
            maxLength: 5,
          ),
        ],
      ),
    );
  }
}

class _PickActionWidget extends StatefulWidget {
  /// [action] can be ether ['add kilo meter'] or ['edit location']
  final Function(ActionType action) onChange;

  const _PickActionWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<_PickActionWidget> createState() => _PickActionWidgetState();
}

class _PickActionWidgetState extends State<_PickActionWidget> {
  ActionType action = ActionType.defaultValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.pickChoice, style: TextStyle(color: Colors.blueAccent)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  action = ActionType.addKiloMeter;
                  widget.onChange(action);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: action == ActionType.addKiloMeter
                              ? Colors.blueAccent
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(S.current.addKiloMeter),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  action = ActionType.editCoordinates;
                  widget.onChange(action);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: action == ActionType.editCoordinates
                              ? Colors.blueAccent
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(S.current.editCoordinates),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String title;
  final String text;

  const _Field({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title),
        ),
        Container(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(text),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
