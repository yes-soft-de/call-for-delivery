import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

void showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required Widget confirmButtonTitle,
  bool? hasCancelButton,
  required Color confirmButtonColor,
  required Function() onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Color(0xff024D92),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: Colors.yellow,
                    size: 50,
                  ),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmButtonColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        child: confirmButtonTitle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: hasCancelButton != null && hasCancelButton,
                      child: Expanded(
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
