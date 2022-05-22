import 'package:flutter/material.dart';

class CapacityBar extends StatelessWidget {
  final bool danger;
  final int filled;
  final int empty;
  final int remainingCount;
  final int totalCount;
  final IconData icon;
  const CapacityBar(
      {Key? key,
      required this.danger,
      required this.filled,
      required this.empty,
      required this.remainingCount,
      required this.totalCount,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: danger
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 16,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: filled,
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: danger == true
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: empty,
                          child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$remainingCount / ',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$totalCount',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
