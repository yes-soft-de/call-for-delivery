import 'package:c4d/module_main/widget/animation.dart';
import 'package:c4d/utils/global/screen_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeWidgetTile extends StatelessWidget {
  final String title;
  final String count;
  const HomeWidgetTile(this.count, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !ScreenType.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.25,
      child: Column(
        children: [
          Visibility(
            visible: kIsWeb == false,
            replacement: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2.5),
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(count,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AnimatedLiquidCircularProgressIndicator(
                  ValueKey(title), int.parse(count)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: kIsWeb
                    ? null
                    : LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.85),
                        Theme.of(context).colorScheme.primary.withOpacity(0.9),
                        Theme.of(context).colorScheme.primary.withOpacity(0.95),
                        Theme.of(context).colorScheme.primary,
                      ]),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
