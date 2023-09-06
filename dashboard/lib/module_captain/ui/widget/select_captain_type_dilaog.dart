import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/utils/components/selectable_item.dart';
import 'package:flutter/material.dart';

class SelectPlanTypeDialog extends StatefulWidget {
  final ProfileModel model;
  final Function(PlanType planType) onPlanChange;

  const SelectPlanTypeDialog({
    super.key,
    required this.model,
    required this.onPlanChange,
  });

  @override
  State<SelectPlanTypeDialog> createState() => _SelectPlanTypeDialogState();
}

class _SelectPlanTypeDialogState extends State<SelectPlanTypeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.selectCaptainPlan,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  SelectableItem<PlanType>(
                    onTap: () {
                      widget.model.planType = PlanType.defaultPlan;
                      setState(() {});
                    },
                    value: PlanType.defaultPlan,
                    selectedValue: widget.model.planType,
                    title: PlanType.defaultPlan.name,
                  ),
                  SelectableItem<PlanType>(
                    onTap: () {
                      widget.model.planType = PlanType.naherEvanOrders;
                      setState(() {});
                    },
                    value: PlanType.naherEvanOrders,
                    selectedValue: widget.model.planType,
                    title: PlanType.naherEvanOrders.name,
                  ),
                  SelectableItem<PlanType>(
                    onTap: () {
                      widget.model.planType = PlanType.naherEvanHours;
                      setState(() {});
                    },
                    value: PlanType.naherEvanHours,
                    selectedValue: widget.model.planType,
                    title: PlanType.naherEvanHours.name,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        widget.onPlanChange(widget.model.planType);
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.current.confirm,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.current.cancel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
