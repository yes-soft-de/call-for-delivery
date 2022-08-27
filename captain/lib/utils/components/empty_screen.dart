import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String empty;
  final VoidCallback? onRefresh;
  final double? height;
  const EmptyStateWidget(
      {required this.empty, required this.onRefresh, this.height});

  @override
  Widget build(BuildContext context) {
    return FixedContainer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flushbar(
                  title: S.of(context).warnning,
                  message: empty,
                  icon: const Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(25),
                  flushbarStyle: FlushbarStyle.FLOATING,
                ),
              ),
              Container(
                height: 24,
              ),
              SvgPicture.asset(
                SvgAsset.EMPTY_SVG,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: 32,
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
                            S.of(context).refresh,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyOrdersEmptyStateWidget extends StatelessWidget {
  final VoidCallback? onRefresh;
  final double? height;
  const NearbyOrdersEmptyStateWidget({required this.onRefresh, this.height});

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
                Padding(
                  padding: const EdgeInsets.only(top: 75.0, bottom: 75),
                  child:
                      Lottie.asset(LottieAsset.WELCOME_CAPTAIN, repeat: false),
                ),
                Text(
                  S.current.hereOrdersWillBeShown,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ]),
              Container(
                height: 24,
              ),
              Container(
                height: 32,
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
                            S.of(context).refresh,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyOrdersStateWidget extends StatelessWidget {
  final VoidCallback? onRefresh;
  final double? height;
  const MyOrdersStateWidget({required this.onRefresh, this.height});

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
                Padding(
                  padding: const EdgeInsets.only(top: 75.0, bottom: 75),
                  child:
                      Lottie.asset(LottieAsset.WELCOME_CAPTAIN, repeat: false),
                ),
                Text(
                  S.current.hereAcceptedOrderShown,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ]),
              Container(
                height: 24,
              ),
              Container(
                height: 32,
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
                            S.of(context).refresh,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
