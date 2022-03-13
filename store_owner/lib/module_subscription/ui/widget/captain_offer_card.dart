import 'package:c4d/generated/l10n.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CaptainOfferCard extends StatelessWidget {
  final String captainNumber;
  final String price;
  final String title;
  final Function()? onPressed;
  const CaptainOfferCard(
      {Key? key,
      required this.captainNumber,
      required this.price,
      required this.title,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.7),
          Theme.of(context).colorScheme.primary.withOpacity(0.8),
          Theme.of(context).colorScheme.primary.withOpacity(0.9),
          Theme.of(context).colorScheme.primary,
        ]),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ),
          // divider
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DottedLine(
              dashColor: Theme.of(context).backgroundColor,
              lineThickness: 2.5,
              dashRadius: 25,
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.sync_alt_rounded,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 105,
                child: Text(
                  '$captainNumber' + ' ' + S.of(context).extraCaptain,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // cost
          Padding(
            padding:
                const EdgeInsets.only(right: 32.0, left: 32, top: 8, bottom: 8),
            child: DottedLine(
              dashColor: Theme.of(context).backgroundColor,
              lineThickness: 2.5,
              dashRadius: 25,
              dashLength: 4,
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.coins,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 105,
                child: Text(
                  '$price ${S.current.sar}',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button?.color),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Theme.of(context).backgroundColor,
                  onPrimary: Theme.of(context).colorScheme.primary),
              child: Text(S.current.subscribe))
        ],
      ),
    );
  }
}
