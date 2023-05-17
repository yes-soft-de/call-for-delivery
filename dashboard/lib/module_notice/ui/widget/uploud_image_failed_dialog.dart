import 'dart:io';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class UploadImageFailedDialog extends StatelessWidget {
  final NoticeRequest request;
  final Function(NoticeRequest) onConfirm;

  const UploadImageFailedDialog(
      {Key? key, required this.request, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.current.failedAcrossWhenUploadingThisImages,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Container(
        color: Theme.of(context).colorScheme.background,
        child: _ImagesWhoseFailed(
          images: request.images ?? [],
          onChange: (updatedList) {
            request.images = updatedList;
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          child: Text(S.current.retry),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm(request);
          },
        ),
        ElevatedButton(
          child: Text(S.current.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _ImagesWhoseFailed extends StatefulWidget {
  final List<NoticeImage> images;
  final Function(List<NoticeImage>) onChange;

  const _ImagesWhoseFailed({
    Key? key,
    required this.images,
    required this.onChange,
  }) : super(key: key);

  @override
  State<_ImagesWhoseFailed> createState() => _ImagesWhoseFailedState();
}

class _ImagesWhoseFailedState extends State<_ImagesWhoseFailed> {
  List<NoticeImage> images = [];
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    if (flag) {
      images = widget.images;
      flag = false;
    }
    return Wrap(
      alignment: WrapAlignment.center,
      children: widget.images.map((e) {
        return Visibility(
            visible: e.uploadError,
            child: Stack(
              children: [
                _Image(noticeImage: e),
                Positioned(
                  left: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      images.remove(e);
                      widget.onChange(images);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
      }).toList(),
    );
  }
}

class _Image extends StatelessWidget {
  final NoticeImage noticeImage;

  const _Image({Key? key, required this.noticeImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageTemp = File(noticeImage.image);
    return noticeImage.isRemote
        ? SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomNetworkImage(
                height: 100,
                width: 100,
                imageSource: noticeImage.image,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              constraints: BoxConstraints.loose(
                Size(100, 100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(imageTemp),
              ),
            ),
          );
  }
}
