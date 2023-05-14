import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RowImagePicker extends StatefulWidget {
  final Function(List<String>) onChange;
  RowImagePicker({Key? key, required this.onChange}) : super(key: key);

  @override
  State<RowImagePicker> createState() => _RowImagePickerState();
}

class _RowImagePickerState extends State<RowImagePicker> {
  final ImagePicker _imagePicker = ImagePicker();
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            images.addAll((await _imagePicker.pickMultiImage(imageQuality: 70)).map((e) => e.path,));
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
                final imageTemp = File(images[index]);
                return Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints.loose(
                        Size(100, 100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.file(imageTemp),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          images.removeAt(index);
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
