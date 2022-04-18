import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class InfoButtonOrder extends StatefulWidget {
  final VoidCallback? onTap;
  InfoButtonOrder({Key? key, this.onTap}) : super(key: key);

  @override
  State<InfoButtonOrder> createState() => _InfoButtonOrderState();
}

class _InfoButtonOrderState extends State<InfoButtonOrder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _sizeAnimation =
        Tween<double>(begin: 35, end: 75).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = _sizeAnimation.value;
    return GestureDetector(
      onTap: widget.onTap,
      child: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).backgroundColor),
          height: 35,
          width: width,
          duration: Duration(seconds: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: _animationController.isCompleted,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      S.current.details,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).disabledColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Icon(Icons.info, color: Theme.of(context).disabledColor),
            ],
          ),
        ),
      ),
    );
  }
}
