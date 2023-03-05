import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImagePath extends StatelessWidget {
  final Uri? imagePath;
  final Function(Uri) callBack;
  const GetImagePath(
      {Key? key, required this.callBack, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
        child: SizedBox(
          height: 150,
          child: GestureDetector(
            onTap: () {
              ImagePicker.platform
                  .getImage(source: ImageSource.gallery)
                  .then((value) {
                if (value != null) {
                  callBack(Uri(path: value.path));
                }
              });
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(imagePath!.toFilePath())),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          ImagePicker.platform
              .getImage(source: ImageSource.gallery)
              .then((value) {
            if (value != null) {
              callBack(Uri(path: value.path));
            }
          });
        },
        child: SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
