import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class ProvideDistance extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final bool payment;
  final Function(String, String?) callBack;
  final Function()? onChanged;
  final Widget thirdField;
  const ProvideDistance(
      {Key? key,
      required this.controller,
      required this.callBack,
      required this.controller2,
      this.payment = true,
      this.onChanged,
      required this.thirdField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          // CustomFormField(
          //   hintText: '${S.of(context).finishOrderProvideDistanceInKm} e.g 45',
          //   controller: controller,
          //   numbers: true,
          //   last: payment == false ? true : false,
          // ),
        const SizedBox(
          height: 8.0,
        ),
        Visibility(
          visible: payment,
          child: CustomFormField(
            onChanged: () {
              if (onChanged != null) {
                onChanged!();
              }
            },
            hintText: S.current.collectedPayment,
            controller: controller2,
            numbers: true,
            last: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: thirdField,
        )
      ],
    );
  }
}
