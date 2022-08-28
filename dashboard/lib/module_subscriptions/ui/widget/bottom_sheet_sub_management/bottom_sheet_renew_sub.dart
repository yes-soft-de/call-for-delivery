import 'package:flutter/material.dart';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/ui/widget/bottom_sheet_sub_management/custom_text_button.dart';

class BottomSheetRenewSubscription extends StatelessWidget {
  final Function() packageExtend;
  final Function() renewNewPlan;
  final Function() renewOldPlan;
  final Function() captainOffer;
  const BottomSheetRenewSubscription({
    Key? key,
    required this.packageExtend,
    required this.renewNewPlan,
    required this.renewOldPlan,
    required this.captainOffer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // extend subscription
                  CustomTextButton(
                    label: S.current.packageExtend,
                    onPressed: packageExtend,
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).backgroundColor,
                    thickness: 2.5,
                  ),
                  // renew new subscription
                  CustomTextButton(
                    label: S.current.renewNewPlan,
                    onPressed: renewNewPlan,
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).backgroundColor,
                    thickness: 2.5,
                  ),
                  // renew current subscription
                  CustomTextButton(
                    label: S.current.renewOldPlan,
                    onPressed: renewOldPlan,
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).backgroundColor,
                    thickness: 2.5,
                  ),
                  CustomTextButton(
                    label: S.current.subscribeToCaptainOffer,
                    onPressed: captainOffer,
                  ),
                ],
              ),
            ),
          ),
        ),
        // close button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    S.current.close,
                    style: Theme.of(context).textTheme.button,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
