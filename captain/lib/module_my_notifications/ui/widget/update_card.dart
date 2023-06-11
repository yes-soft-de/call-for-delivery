import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateCard extends StatelessWidget {
  final UpdateModel update;

  const UpdateCard({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xff082555),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(title: update.title),
            const SizedBox(height: 10),
            _Text(text: update.msg),
            const SizedBox(height: 10),
            _Images(images: update.images),
            const SizedBox(height: 10),
            _CreatedAt(createdAt: update.date),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xff225198),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xff00f0ff),
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class _CreatedAt extends StatelessWidget {
  final String createdAt;
  const _CreatedAt({required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Text(
          createdAt,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xff00f0ff),
              ),
        )
      ],
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  const _Text({required this.text});

  @override
  Widget build(BuildContext context) {
    return Linkify(
      text: text,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      onOpen: (link) async {
        var uri = Uri.tryParse(link.url) ?? Uri();
        var canLaunch = await canLaunchUrl(uri);

        if (canLaunch) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      options: const LinkifyOptions(removeWww: true, looseUrl: true),
    );
  }
}

class _Images extends StatelessWidget {
  final List<String> images;
  const _Images({required this.images});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: images.isNotEmpty,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 250,
        ),
        child: Swiper(
          itemCount: images.length,
          pagination: const SwiperPagination(
            margin: EdgeInsets.only(bottom: 0),
            builder: SwiperPagination.dots,
            alignment: Alignment.bottomCenter,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Expanded(
                  child: CustomNetworkImage(
                    imageSource: images[index],
                    height: 200,
                    width: 200,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
