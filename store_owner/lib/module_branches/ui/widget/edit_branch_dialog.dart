import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class EditBranchDialog extends StatefulWidget {
  EditBranchDialog({Key? key}) : super(key: key);
  @override
  State<EditBranchDialog> createState() => _EditBranchDialogState();
}

class _EditBranchDialogState extends State<EditBranchDialog> {
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text(S.current.updateBranch),
      content: Container(
        constraints: BoxConstraints(maxHeight: 200),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Text(
                  S.of(context).newName,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CustomFormField(
              onChanged: () {
                setState(() {});
              },
              controller: nameController,
              hintText: S.current.branch01,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
            child: Text(S.of(context).save),
            onPressed: nameController.text.isNotEmpty == true
                ? () {
                    Navigator.of(context).pop(nameController.text);
                  }
                : null)
      ],
    );
  }
}
