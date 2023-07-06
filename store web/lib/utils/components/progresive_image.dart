import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:store_web/consts/urls.dart';
import 'package:store_web/utils/images/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageSource;
  final Color? background;
  const CustomNetworkImage({super.key, 
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
                color: background ?? Theme.of(context).colorScheme.background),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.delivery_dining_rounded,
                    size: 30,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                  child: SizedBox(
                    width: 28,
                    child: LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).textTheme.displayLarge!.color!)),
                  ),
                ),
              ],
            ),
          );
        },
        fadeDuration: const Duration(milliseconds: 750),
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
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
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
                    child: Image.network(image),
                    resetDuration: const Duration(milliseconds: 150),
                    onZoomStart: () {},
                    onZoomEnd: () {},
                  ),
                );
              });
        },
        child: ProgressiveImage.custom(
          height: height,
          width: width,
          placeholderBuilder: (context) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: background ?? Theme.of(context).colorScheme.background),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.delivery_dining_rounded,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0),
                    child: SizedBox(
                      width: 28,
                      child: LinearProgressIndicator(
                          minHeight: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).textTheme.displayLarge!.color!)),
                    ),
                  ),
                ],
              ),
            );
          },
          fadeDuration: const Duration(milliseconds: 750),
          thumbnail: NetworkImage(image),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
