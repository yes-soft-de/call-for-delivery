import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:flutter/material.dart';

class UploadImageFailedDialog extends StatelessWidget {
  final NoticeRequest request;
  const UploadImageFailedDialog({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Text('test'),
            Wrap(
              children: request.images?.map((e) => SizedBox()).toList() ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
