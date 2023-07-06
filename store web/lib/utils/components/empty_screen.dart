import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/utils/components/fixed_container.dart';
import 'package:store_web/utils/images/images.dart';

class EmptyStateWidget extends StatelessWidget {
  final String empty;
  final VoidCallback? onRefresh;
  const EmptyStateWidget({super.key, required this.empty, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return FixedContainer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
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
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
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
                Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
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
}
