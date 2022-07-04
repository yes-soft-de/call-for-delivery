import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/images/images.dart';

class OrderStatusWarningState extends States {
  final String? error;
  final List<String>? errors;
  final String title;
  final bool hasAppbar;
  final VoidCallback onPressed;
  final double? size;
  final IconData? icon;
  final VoidCallback? tapApp;
  State<StatefulWidget> screenState;
  OrderStatusWarningState(this.screenState,
      {this.error,
      this.errors,
      required this.onPressed,
      required this.title,
      this.hasAppbar = true,
      this.size,
      this.icon,
      this.tapApp})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: hasAppbar
          ? CustomC4dAppBar.appBar(context,
              title: title, colorIcon: Colors.amber, icon: icon, onTap: tapApp)
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flushbar(
                  title: S.of(context).thisErrorHappened,
                  message: error ?? S.current.errorHappened,
                  icon: const Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                  flushbarStyle: FlushbarStyle.FLOATING,
                ),
              ),
              Container(
                height: 24,
              ),
              SvgPicture.asset(
                ImageAsset.EMPTY_SVG,
                height: size ?? MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: 32,
              ),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => false);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            OrdersRoutes.CAPTAIN_ORDERS_SCREEN,
                            (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).goingBackToHome,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
