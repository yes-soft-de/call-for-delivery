import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/components/progresive_image.dart';

class UpdateDialog extends StatelessWidget {
  final List<UpdateModel> updateModel;
  const UpdateDialog({super.key, required this.updateModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xbb002140),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _Title(),
              _Body(updateModel: updateModel),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<UpdateModel> updateModel;
  const _Body({required this.updateModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      child: Swiper(
        outer: true,
        itemCount: updateModel.length,
        pagination: const SwiperPagination(
          margin: EdgeInsets.only(bottom: 0),
          builder: SwiperPagination.dots,
          alignment: Alignment.bottomCenter,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  children: [
                    _ADTitle(title: updateModel[index].title),
                    _Images(images: updateModel[index].images),
                    Visibility(
                      visible: updateModel[index].images.isEmpty,
                      child: const SizedBox(
                        height: 50,
                      ),
                    ),
                    _Text(text: updateModel[index].msg),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white)),
                  child: Text(
                    S.current.goToOffers,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(MyNotificationsRoutes.UPDATES_SCREEN);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ADTitle extends StatelessWidget {
  final String title;
  const _ADTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xff00f0ff),
          ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  const _Text({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Linkify(
        text: text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
        onOpen: (link) async {
          var uri = Uri.tryParse(link.url) ?? Uri();
          var canLaunch = await canLaunchUrl(uri);

          if (canLaunch) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        options: const LinkifyOptions(removeWww: true, looseUrl: true),
      ),
    );
  }
}

class _Images extends StatelessWidget {
  final List<String> images;

  const _Images({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: images.isNotEmpty,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 200,
        ),
        child: Swiper(
          autoplay: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return CustomNetworkImage(
              imageSource: images[index],
              height: 200,
              width: 200,
            );
          },
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          S.current.addsAndOffers,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }
}
