import 'dart:io';

import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RowImagePicker extends StatefulWidget {
  final Function(List<NoticeImage>) onChange;
  final List<NoticeImage> initImages;
  RowImagePicker({Key? key, required this.onChange, required this.initImages})
      : super(key: key);

  @override
  State<RowImagePicker> createState() => _RowImagePickerState();
}

class _RowImagePickerState extends State<RowImagePicker> {
  final ImagePicker _imagePicker = ImagePicker();
  List<NoticeImage> images = [];
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      images = widget.initImages;
      flag = false;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            images.addAll(
                (await _imagePicker.pickMultiImage(imageQuality: 70)).map(
              (e) => NoticeImage(id: 0, image: e.path),
            ));
            widget.onChange(images);
            setState(() {});
          },
          icon: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Theme.of(context).colorScheme.outline.withAlpha(75),
            ),
            child: Icon(Icons.add),
          ),
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 100),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                if (images[index].toDelete) return SizedBox();
                return Stack(
                  children: [
                    _Image(noticeImage: images[index]),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          if (images[index].isRemote) {
                            images[index].toDelete = true;
                          } else {
                            images.removeAt(index);
                          }
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
                );
              },
            ),
          ),
        ),
      ],
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
