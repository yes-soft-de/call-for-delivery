import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:progressive_image/progressive_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageSource;
  final Color? background;
  CustomNetworkImage({
    required this.height,
    required this.width,
    required this.imageSource,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    var image = imageSource;
    bool asset = image.contains('assets');
    if (!image.contains('/original-image/')) {
      image = ImageAsset.PLACEHOLDER;
      asset = true;
    }
    if (asset) {
      return ProgressiveImage.custom(
        height: height,
        width: width,
        placeholderBuilder: (context) {
          return Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: background ?? Theme.of(context).backgroundColor),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.delivery_dining_rounded,
                    size: 30,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                  child: Container(
                    width: 28,
                    child: LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).textTheme.headline1!.color!)),
                  ),
                ),
              ],
            ),
          );
        },
        fadeDuration: Duration(milliseconds: 750),
        thumbnail: AssetImage(image),
        image: AssetImage(image),
        fit: BoxFit.cover,
      );
    } else {
      if (!image.contains('http')) {
        image = Urls.IMAGES_ROOT + image;
      }
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.black,
                  body: PinchZoom(
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                    resetDuration: const Duration(milliseconds: 150),
                    onZoomStart: () {},
                    onZoomEnd: () {},
                  ),
                );
              });
        },
        child: CachedNetworkImage(
          height: height,
          width: width,
          placeholder: (context, url) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: background ?? Theme.of(context).backgroundColor),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.delivery_dining_rounded,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0),
                    child: Container(
                      width: 28,
                      child: LinearProgressIndicator(
                          minHeight: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).textTheme.headline1!.color!)),
                    ),
                  ),
                ],
              ),
            );
          },
          filterQuality: FilterQuality.medium,
          fadeInDuration: Duration(milliseconds: 750),
          fadeOutDuration: Duration(milliseconds: 750),
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
