import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class ProvideDistance extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final bool payment;
  final Function(String, String?) callBack;
  final Function()? onChanged;
  const ProvideDistance(
      {Key? key,
      required this.controller,
      required this.callBack,
      required this.controller2,
      this.payment = true,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              CustomFormField(
                hintText:
                    '${S.of(context).finishOrderProvideDistanceInKm} e.g 45',
                controller: controller,
                numbers: true,
                last: false,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Visibility(
                visible: payment,
                child: CustomFormField(
                  onChanged: (s) {
                    if (onChanged != null) {
                      onChanged!();
                    }
                  },
                  hintText: S.current.collectedPayment,
                  controller: controller2,
                  numbers: true,
                  last: false,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.green[700],
            ),
            child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 20,
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty ) {
                    callBack(controller.text, controller2.text.trim() == '' ? null :controller2.text.trim());
                  } else {
                    CustomFlushBarHelper.createError(
                            title: S.current.warnning,
                            message: S.of(context).pleaseProvideTheDistance)
                        .show(context);
                  }
                }),
          ),
        ),
      ],
    );
  }
}
