import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/images/images.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? error;
  final VoidCallback? onRefresh;
  final List<String>? errors;

  ErrorStateWidget({this.error, required this.onRefresh, this.errors})
      : assert(error != null || errors != null);

  @override
  Widget build(BuildContext context) {
    return FixedContainer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                error != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flushbar(
                          title: S.of(context).thisErrorHappened,
                          message: error,
                          icon: const Icon(
                            Icons.info,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          flushbarStyle: FlushbarStyle.FLOATING,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flushbar(
                          title: S.of(context).errOc + ' : ',
                          messageText: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: getErrorMessage(errors!, true)),
                          icon: const Icon(
                            Icons.info,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          flushbarStyle: FlushbarStyle.FLOATING,
                        ),
                      ),
                Container(
                  height: 24,
                ),
                SvgPicture.asset(
                  SvgAsset.ERROR_SVG,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Container(
                  height: 32,
                ),
                Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0),
                        onPressed: onRefresh,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).refresh,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getErrorMessage(List<String> errs, bool indexed) {
    List<Widget> errorMessages = [];
    int i = 1;
    String index;
    errs.forEach((element) {
      index = indexed ? '$i- ' : '';
      errorMessages.add(Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          index + element,
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ));
      i++;
    });
    return errorMessages;
  }
}

class ErrorOrderNotificationStateWidget extends StatelessWidget {
  final String? error;
  final VoidCallback? onRefresh;
  final List<String>? errors;

  ErrorOrderNotificationStateWidget(
      {this.error, required this.onRefresh, this.errors})
      : assert(error != null || errors != null);

  @override
  Widget build(BuildContext context) {
    return FixedContainer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Column(children: [
                Text(
                  S.current.welcomeCaptain,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  S.current.activateOrderNotification,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SvgPicture.asset(
                  SvgAsset.WAITING_PARKS_SVG,
                  height: 325,
                  width: 325,
                ),
              ]),
              Container(
                height: 24,
              ),
              Visibility(
                visible: onRefresh != null,
                child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 3),
                        onPressed: onRefresh,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.of(context).activeOrderNotification,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
              Container(
                height: 32,
              ),
              Text(
                S.current.hereOrdersWillBeShown,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getErrorMessage(List<String> errs, bool indexed) {
    List<Widget> errorMessages = [];
    int i = 1;
    String index;
    errs.forEach((element) {
      index = indexed ? '$i- ' : '';
      errorMessages.add(Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          index + element,
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ));
      i++;
    });
    return errorMessages;
  }
}
