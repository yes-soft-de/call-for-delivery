import 'package:flutter/material.dart';

class ControlWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool? active;
  final Function() onPressed;
  const ControlWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.active,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    offset: Offset(1, 1),
                    spreadRadius: 2.5,
                    blurRadius: 6,
                    color: Theme.of(context).backgroundColor)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 35,
                ),
                Visibility(
                  visible: active != null,
                  replacement: Text(title),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Spacer(),
                      Visibility(
                        visible: active != null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: PhysicalModel(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              elevation: 5,
                              shape: BoxShape.circle,
                              child: Icon(
                                Icons.circle,
                                color:
                                    active == true ? Colors.green : Colors.red,
                                size: 15,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
